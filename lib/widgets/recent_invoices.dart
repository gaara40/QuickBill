import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/global_providers/invoice_history_provider.dart';
import 'package:quick_bill/utils/date_utils.dart';
import 'package:quick_bill/widgets/invoice_row.dart';

class RecentInvoices extends ConsumerWidget {
  const RecentInvoices({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final invoiceHistory = ref.watch(invoiceHistoryProvider);
    final invoices = invoiceHistory.toList();
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 70,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.2),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Recent Invoices',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child:
                  invoiceHistory.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              size: 60,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No invoices yet.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Generate new invoice to see it here.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                      : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final invoice = invoices[index];
                            return InvoiceRow(
                              customer: invoice.customerName,
                              date: formatDate(invoice.dateTime),
                              amount: invoice.total.toStringAsFixed(2),
                              invoiceNumber: invoice.id,
                              onTap: () {},
                            );
                          },
                          separatorBuilder: (_, _) => const Divider(height: 1),
                          itemCount: invoices.length,
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
