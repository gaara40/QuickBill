import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/models/inventory_item.dart';

class InventoryNotifier extends StateNotifier<List<InventoryItem>> {
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  InventoryNotifier() : super([]) {
    _init();
  }

  Future<void> _init() async {
    if (userId != null) {
      final collection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('inventory_items');

      final snapshot = await collection.get();
      state =
          snapshot.docs.map((doc) {
            return InventoryItem.fromFirestore(doc);
          }).toList();
    }
  }

  void addItem(InventoryItem item) async {
    if (userId != null) {
      final collection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('inventory_items');
      await collection.add(item.toMap());
      state = [...state, item];
    }
  }

  void deleteItem(String id) async {
    if (userId != null) {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('inventory_items')
          .doc(id);

      try {
        await docRef.delete();

        state = state.where((item) => item.id != id).toList();

        debugPrint("Item deleted successfully from Firestore and local state.");
      } catch (e) {
        debugPrint("Error deleting item: $e");
      }
    }
  }

  void updateItem(String id, InventoryItem updatedItem) async {
    if (userId != null) {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('inventory_items')
          .doc(id);

      await docRef.update(updatedItem.toMap());

      final index = state.indexWhere((item) => item.id == id);
      if (index != -1) {
        final updatedList = [...state];
        updatedList[index] = updatedItem;
        state = updatedList;
      }
    }
  }

  void updateItemQuantityAfterSale(String name, int soldQty) async {
    final index = state.indexWhere((item) => item.name == name);
    if (index != -1) {
      final updated = [...state];
      final existing = updated[index];
      final newQty = existing.qty - soldQty;

      updated[index] = existing.copyWith(qty: newQty.clamp(0, existing.qty));
      state = updated;

      if (userId != null) {
        final docRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('inventory_items')
            .doc(existing.id);

        await docRef.update({'qty': newQty.clamp(0, existing.qty)});
      }
    }
  }

  void clear() {
    state = [];
  }
}

final inventoryProvider =
    StateNotifierProvider<InventoryNotifier, List<InventoryItem>>((ref) {
      return InventoryNotifier();
    });
