import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/global_providers/inventory_provider.dart';
import 'package:quick_bill/widgets/inventory_item_list.dart';
import 'package:quick_bill/widgets/show_inventory_item_dialog.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(inventoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Inventory')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child:
            items.isEmpty
                ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.inventory_2_outlined,
                        size: 80,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No items added yet.',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tap the + button to add new inventory items.',
                        style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                )
                : InventoryItemList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showInventoryItemDialog(context: context, ref: ref);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
