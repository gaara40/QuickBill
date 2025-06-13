import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/models/generate_invoice_model.dart';

class InvoiceHistoryNotifier extends StateNotifier<List<GenerateInvoiceModel>> {
  InvoiceHistoryNotifier() : super([]);

  void addInvoice(GenerateInvoiceModel invoice) {
    state = [...state, invoice];
  }

  double get totalSales {
    return state.fold(0.0, (sum, invoice) => sum + invoice.total);
  }
}

final invoiceHistoryProvider =
    StateNotifierProvider<InvoiceHistoryNotifier, List<GenerateInvoiceModel>>(
      (ref) => InvoiceHistoryNotifier(),
    );

final totalSalesProvider = Provider<double>((ref) {
  final invoices = ref.watch(invoiceHistoryProvider.notifier);
  return invoices.totalSales;
});
