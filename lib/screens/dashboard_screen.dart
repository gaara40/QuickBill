import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/global_providers/auth_providers.dart';
import 'package:quick_bill/global_providers/inventory_provider.dart';
import 'package:quick_bill/global_providers/invoice_history_provider.dart';
import 'package:quick_bill/global_providers/invoice_provider.dart';
import 'package:quick_bill/main.dart';
import 'package:quick_bill/widgets/insights.dart';

import 'package:quick_bill/widgets/new_invoice.dart';
import 'package:quick_bill/widgets/recent_invoices.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final totalSales = ref.watch(totalSalesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('QuickBill'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    title: Text('Logout'),
                    content: Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text('No'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(ctx);
                          await ref.read(authServiceProvider).signOut();
                          ref.invalidate(invoiceProvider);
                          ref.invalidate(invoiceHistoryProvider);
                          ref.invalidate(inventoryProvider);
                          ref.invalidate(totalSalesProvider);
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Sales
            Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: 100),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'Total Sales',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 0, 0, 0.8),
                        ),
                      ),

                      Text(
                        '₹ ${totalSales.toStringAsFixed(2)}',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 0, 0, 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => NewInvoice()),
                        ),
                    icon: const Icon(Icons.receipt_long),
                    label: const Text('New Invoice'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      navigatorKey.currentState?.push(
                        MaterialPageRoute(builder: (_) => Insights()),
                      );
                      // showDialog(
                      //   context: context,
                      //   builder: (_) {
                      //     return AlertDialog(
                      //       title: Text('Feature coming soon...'),
                      //     );
                      //   },
                      // );
                    },
                    icon: const Icon(Icons.insights),
                    label: const Text('Insights'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      foregroundColor: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Expanded(child: RecentInvoices()),
          ],
        ),
      ),
    );
  }
}
