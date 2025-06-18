import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quick_bill/global_providers/monthly_sales_provider.dart';

class Insights extends ConsumerWidget {
  const Insights({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthlySales = ref.watch(monthlySalesProvider);
    final yearlySales = ref.watch(yearlySalesProvider);
    final topSellingItems = ref.watch(topSellingItemsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Insights")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            _salesCard('📅 Yearly Sales', yearlySales),
            const SizedBox(height: 10),
            _salesCard('📆 Monthly Sales', monthlySales),
            const SizedBox(height: 10),
            _topSellingItemsCard('🏆 Top Selling Items', topSellingItems),
          ],
        ),
      ),
    );
  }

  Widget _salesCard(String title, Map<String, double> data) {
    final formatter = DateFormat('MMM yyyy');
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            const Divider(thickness: 1),

            SizedBox(
              height: 160,
              child:
                  data.isEmpty
                      ? buildEmptyState(
                        icon: Icons.bar_chart,
                        title: 'No sales yet',
                        subtitle:
                            'Sales insights will appear here once you create invoices.',
                      )
                      : ListView(
                        children:
                            data.entries.map((entry) {
                              return ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                title:
                                    entry.key ==
                                            formatter.format(DateTime.now())
                                        ? const Text(
                                          'This month',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                        : Text(entry.key),
                                trailing: Text(
                                  '₹${entry.value.toStringAsFixed(2)}',
                                ),
                              );
                            }).toList(),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topSellingItemsCard(String title, List<MapEntry<String, int>> items) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 1),
            SizedBox(
              height: 160,
              child:
                  items.isEmpty
                      ? buildEmptyState(
                        icon: Icons.shopping_bag_outlined,
                        title: 'No top sellers yet',
                        subtitle:
                            'Track your best-performing items after some sales.',
                      )
                      : ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text(item.key),
                            trailing: Text('${item.value} pcs'),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildEmptyState({
  required IconData icon,
  required String title,
  required String subtitle,
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 48, color: Colors.grey[400]),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
