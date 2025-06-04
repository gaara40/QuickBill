import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/global_providers/inventory_provider.dart';
import 'package:quick_bill/models/inventory_item.dart';

Future<void> showInventoryItemDialog({
  required BuildContext context,
  required WidgetRef ref,
  InventoryItem? existingItem,
}) async {
  final nameController = TextEditingController(text: existingItem?.name ?? '');
  final priceController = TextEditingController(
    text: existingItem?.price.toString() ?? '',
  );
  final qtyController = TextEditingController(
    text: existingItem?.qty.toString() ?? '',
  );

  final formKey = GlobalKey<FormState>();

  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(existingItem == null ? 'Add Item' : 'Edit Item'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Item Name'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Enter item name'
                              : null,
                ),
                TextFormField(
                  controller: priceController,

                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    prefix: Text('₹ '),
                  ),
                  validator: (value) {
                    final price = double.tryParse(value ?? '');
                    if (price == null || price <= 0) {
                      return 'Enter valid price';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: qtyController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  validator: (value) {
                    final qty = int.tryParse(value ?? '');
                    if (qty == null || qty <= 0) {
                      return 'Enter valid quantity';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final name = nameController.text.trim();
                final price = double.parse(priceController.text);
                final qty = int.parse(qtyController.text);

                if (existingItem == null) {
                  // Adding item
                  ref
                      .read(inventoryProvider.notifier)
                      .addItem(
                        InventoryItem(name: name, price: price, qty: qty),
                      );
                } else {
                  // Update item
                  ref
                      .read(inventoryProvider.notifier)
                      .updateItem(
                        existingItem.id,
                        existingItem.copyWith(
                          name: name,
                          price: price,
                          qty: qty,
                        ),
                      );
                }

                Navigator.pop(context);
              }
            },
            child: Text(existingItem == null ? 'Add' : 'Update'),
          ),
        ],
      );
    },
  );
}
