import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:quick_bill/models/inventory_item.dart';

// StateNotifier for managing the inventory list
class InventoryNotifier extends StateNotifier<List<InventoryItem>> {
  final Box<InventoryItem> _box;

  InventoryNotifier(this._box) : super(_box.values.toList());

  void addItem(InventoryItem item) {
    _box.put(item.id, item);
    state = [...state, item];
  }

  void deleteItem(String id) {
    _box.delete(id);
    state = state.where((item) => item.id != id).toList();
  }

  void updateItem(String id, InventoryItem updatedItem) {
    _box.put(id, updatedItem);
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
      _box.put(current.id, updatedItem);

      final updatedList = [...state];
      updatedList[index] = updatedItem;
      state = updatedList;
    }
  }

  void clear() {
    _box.clear();
    state = [];
  }
}

final inventoryProvider =
    StateNotifierProvider<InventoryNotifier, List<InventoryItem>>((ref) {
      final box = Hive.box<InventoryItem>('inventoryItem_box');
      return InventoryNotifier(box);
    });
