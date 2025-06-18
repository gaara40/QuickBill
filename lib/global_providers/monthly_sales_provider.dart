import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quick_bill/global_providers/invoice_history_provider.dart';

//Monthly Sales
final monthlySalesProvider = Provider<Map<String, double>>((ref) {
  final invoices = ref.watch(invoiceHistoryProvider);
  final Map<String, double> monthlySales = {};

  final formatter = DateFormat('MMM yyyy');

  for (var invoice in invoices) {
    final key = formatter.format(invoice.dateTime);
    monthlySales[key] = (monthlySales[key] ?? 0) + invoice.total;
  }
  return monthlySales;
});

//Yearly Sales
final yearlySalesProvider = Provider<Map<String, double>>((ref) {
  final invoices = ref.watch(invoiceHistoryProvider);
  final Map<String, double> yearlySales = {};

  for (var invoice in invoices) {
    final key = invoice.dateTime.year.toString();
    yearlySales[key] = (yearlySales[key] ?? 0) + invoice.total;
  }

  return yearlySales;
});

//Top-Selling item
final topSellingItemsProvider = Provider<List<MapEntry<String, int>>>((ref) {
  final invoices = ref.watch(invoiceHistoryProvider);
  final Map<String, int> itemCounts = {};

  for (var invoice in invoices) {
    for (var item in invoice.items) {
      itemCounts[item.name] = (itemCounts[item.name] ?? 0) + item.qty;
    }
  }

  final sorted =
      itemCounts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

  return sorted.take(3).toList();
});
