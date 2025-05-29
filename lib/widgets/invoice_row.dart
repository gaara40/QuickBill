import 'package:flutter/material.dart';

class InvoiceRow extends StatelessWidget {
  const InvoiceRow({
    super.key,
    required this.customer,
    required this.date,
    required this.amount,
    required this.invoiceNumber,
    required this.onTap,
  });

  final String customer;
  final String date;
  final String amount;
  final String invoiceNumber;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: EdgeInsets.all(8),
      title: Text(
        customer,
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      ),

      subtitle: Text(
        '#INV-${invoiceNumber.substring(invoiceNumber.length - 6)}',
        style: theme.textTheme.bodySmall,
      ),
      onTap: onTap,
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '₹ $amount',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(date, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
