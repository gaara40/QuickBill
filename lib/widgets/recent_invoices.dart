import 'package:flutter/material.dart';
import 'package:quick_bill/widgets/invoice_row.dart';

class RecentInvoices extends StatelessWidget {
  const RecentInvoices({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                IconButton(onPressed: () {}, icon: Icon(Icons.swap_vert)),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return InvoiceRow(
                    customer: "Raju",
                    date: '29 Jan 2025',
                    amount: '450',
                    invoiceNumber: '45555567876543',
                    onTap: () {},
                  );
                },
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemCount: 7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
