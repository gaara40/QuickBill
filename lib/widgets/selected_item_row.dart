import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/global_providers/invoice_provider.dart';
import 'package:quick_bill/models/invoice_item_model.dart';

class SelectedItemRow extends ConsumerWidget {
  final InvoiceItem item;
  const SelectedItemRow({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${item.name} (₹${item.price})',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap:
                      () => ref
                          .read(invoiceProvider.notifier)
                          .decrementQty(item.name),
                  child: const Icon(Icons.remove, size: 20),
                ),
                const SizedBox(width: 12),
                Text('${item.qty}', style: theme.textTheme.bodyMedium),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap:
                      () => ref
                          .read(invoiceProvider.notifier)
                          .incrementQty(item.name, context, item),
                  child: const Icon(Icons.add, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
