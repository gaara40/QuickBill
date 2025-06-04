import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/global_providers/inventory_provider.dart';
import 'package:quick_bill/widgets/inventory_item_card.dart';
import 'package:quick_bill/widgets/show_inventory_item_dialog.dart';

class InventoryItemList extends ConsumerWidget {
  const InventoryItemList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryItems = ref.watch(inventoryProvider);

    return ListView.builder(
      itemCount: inventoryItems.length,
      itemBuilder: (context, index) {
        final inventoryItem = inventoryItems[index];
        return Column(
          children: [
            Dismissible(
              key: ValueKey(inventoryItem.id),
              direction: DismissDirection.horizontal,
              background: Container(
                color: Colors.blue.withValues(alpha: 0.6),
                padding: EdgeInsets.all(12),
                alignment: Alignment.centerLeft,
                child: Icon(Icons.edit, color: Colors.white),
              ),
              secondaryBackground: Container(
                color: Colors.red.withValues(alpha: 0.6),
                padding: EdgeInsets.all(12),
                alignment: Alignment.centerRight,
                child: Icon(Icons.delete, color: Colors.white),
              ),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  showInventoryItemDialog(
                    context: context,
                    ref: ref,
                    existingItem: inventoryItem,
                  );
                  return false;
                }

                if (direction == DismissDirection.endToStart) {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text('Delete Item'),
                          content: Text(
                            "Are you sure you want to delete '${inventoryItem.name}' from inventory?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('No'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text('Yes'),
                            ),
                          ],
                        ),
                  );

                  if (confirm == true) {
                    ref
                        .read(inventoryProvider.notifier)
                        .deleteItem(inventoryItem.id);
                    return true;
                  }

                  return false;
                }

                return false;
              },
              child: InventoryItemCard(inventoryItem: inventoryItem),
            ),
            if (index < inventoryItems.length - 1)
              Divider(height: 0, thickness: 1), // Add divider between items
          ],
        );
      },
    );
  }
}
