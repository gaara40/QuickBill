import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quick_bill/models/generate_invoice_model.dart';

class InvoiceHistoryNotifier extends StateNotifier<List<GenerateInvoiceModel>> {
  InvoiceHistoryNotifier() : super([]);

  void addInvoice(GenerateInvoiceModel invoice) {
    state = [...state, invoice];
  }
}

final invoiceHistoryProvider =
    StateNotifierProvider<InvoiceHistoryNotifier, List<GenerateInvoiceModel>>((
      ref,
    ) {
      return InvoiceHistoryNotifier();
    });

final totalSalesProvider = Provider<double>((ref) {
  final invoices = ref.watch(invoiceHistoryProvider);
  return invoices.fold(0.0, (sum, invoice) => sum + invoice.total);
});
