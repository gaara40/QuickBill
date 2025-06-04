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

  void updateItem(String id, InventoryItem newItem) {
    final index = state.indexWhere((item) => item.id == id);
    if (index != -1) {
      final updated = [...state];
      updated[index] = newItem;
      state = updated;
    }
  }

  void clear() {
    state = [];
  }
}

final inventoryProvider =
    StateNotifierProvider<InventoryNotifier, List<InventoryItem>>(
      (ref) => InventoryNotifier(),
    );
