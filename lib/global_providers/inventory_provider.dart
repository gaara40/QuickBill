import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quick_bill/models/inventory_item.dart';

class InventoryNotifier extends StateNotifier<List<InventoryItem>> {
  InventoryNotifier() : super([]);

  void addItem(InventoryItem item) {
    state = [...state, item];
  }

  void deleteItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void updateItem(String id, InventoryItem updatedItem) {
    final index = state.indexWhere((item) => item.id == id);
    if (index != -1) {
      final updatedList = [...state];
      updatedList[index] = updatedItem;
      state = updatedList;
    }
  }

  void updateItemQuantityAfterSale(String name, int soldQty) {
    final index = state.indexWhere((item) => item.name == name);
    if (index != -1) {
      final current = state[index];
      final newQty = (current.qty - soldQty).clamp(0, current.qty);
      final updatedItem = current.copyWith(qty: newQty);

      final updatedList = [...state];
      updatedList[index] = updatedItem;
      state = updatedList;
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
