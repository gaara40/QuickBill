import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quick_bill/global_providers/inventory_provider.dart';
import 'package:quick_bill/global_providers/invoice_provider.dart';
import 'package:quick_bill/models/inventory_item.dart';
import 'package:quick_bill/models/invoice_item_model.dart';

import 'package:quick_bill/widgets/selected_item_row.dart';

class NewInvoice extends ConsumerStatefulWidget {
  const NewInvoice({super.key});

  @override
  ConsumerState<NewInvoice> createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends ConsumerState<NewInvoice> {
  final customerNameController = TextEditingController();

  bool _initialized = false;

  @override
  void dispose() {
    customerNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inventoryItems = ref.watch(inventoryProvider);
    final selectedItems = ref.watch(invoiceProvider);
    final theme = Theme.of(context);
    final subTotal = ref.watch(invoiceProvider.notifier).subTotal;

    return Scaffold(
      appBar: AppBar(title: Text('Generate Invoice')),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fixed input section
            TextField(
              controller: customerNameController,
              decoration: const InputDecoration(labelText: 'Customer Name'),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<InventoryItem>(
              value: null,
              items:
                  inventoryItems.isNotEmpty
                      ? inventoryItems
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item.name),
                            ),
                          )
                          .toList()
                      : [
                        const DropdownMenuItem(
                          value: null,

                          child: Text(
                            'Inventory is empty. Please add items.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],

              onChanged:
                  inventoryItems.isNotEmpty
                      ? (value) {
                        if (value != null) {
                          ref
                              .read(invoiceProvider.notifier)
                              .addOrUpdate(
                                InvoiceItem(
                                  name: value.name,
                                  price: value.price,
                                  qty: value.qty,
                                ),
                                context,
                              );
                        }
                      }
                      : null,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Select Item',
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child:
                  selectedItems.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              size: 60,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No items added yet.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Select an item to begin billing.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                      : ListView.builder(
                        itemCount: selectedItems.length,
                        itemBuilder: (context, index) {
                          final item = selectedItems[index];
                          return SelectedItemRow(item: item);
                        },
                      ),
            ),

            const Divider(thickness: 1),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal', style: theme.textTheme.titleMedium),
                Text(
                  '₹ ${subTotal.toStringAsFixed(2)}',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Generate Invoice'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(invoiceProvider.notifier).clear();
      });
    }
  }
}
