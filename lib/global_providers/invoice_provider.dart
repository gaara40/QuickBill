import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/global_providers/inventory_provider.dart';
import 'package:quick_bill/models/invoice_item_model.dart';

class InvoiceNotifier extends StateNotifier<List<InvoiceItem>> {
  InvoiceNotifier() : super([]);

  void addOrUpdate(InvoiceItem item, BuildContext context) {
    final index = state.indexWhere((element) => element.name == item.name);
    final maxQty = item.qty;
    if (index == -1) {
      state = [...state, item.copyWith(qty: 1)];
    } else {
      final updated = [...state];
      final existing = updated[index];
      if (existing.qty >= maxQty) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No more stock available for ${existing.name}'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }
      updated[index] = existing.copyWith(qty: existing.qty + 1);
      state = updated;
    }
  }

  void incrementQty(
    String name,
    BuildContext context,
    InvoiceItem item,
    WidgetRef ref,
  ) {
    final index = state.indexWhere((element) => element.name == name);
    if (index != -1) {
      final updated = [...state];
      final existing = updated[index];

      final inventoryItems = ref.read(inventoryProvider);
      final stock =
          inventoryItems.firstWhere((element) => element.name == name).qty;

      if (existing.qty >= stock) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No more stock available for ${existing.name}'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }
      updated[index] = existing.copyWith(qty: existing.qty + 1);
      state = updated;
    }
  }

  void decrementQty(String name) {
    final index = state.indexWhere((e) => e.name == name);
    if (index != -1) {
      final updated = [...state];
      final existing = updated[index];
      final newQty = existing.qty - 1;
      if (newQty > 0) {
        updated[index] = existing.copyWith(qty: newQty);
      } else {
        updated.removeAt(index);
      }
      state = updated;
    }
  }

  double get subTotal => state.fold(0, (sum, item) => sum + item.total);

  void clear() {
    state = [];
  }
}

final invoiceProvider =
    StateNotifierProvider<InvoiceNotifier, List<InvoiceItem>>((ref) {
      return InvoiceNotifier();
    });
