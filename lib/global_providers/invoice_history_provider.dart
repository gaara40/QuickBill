import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quick_bill/hive_constants/hive_box_names.dart';
import 'package:quick_bill/models/generate_invoice_model.dart';

class InvoiceHistoryNotifier extends StateNotifier<List<GenerateInvoiceModel>> {
  final Box<GenerateInvoiceModel> _box;

  InvoiceHistoryNotifier(this._box) : super(_box.values.toList());

  void addInvoice(GenerateInvoiceModel invoice) {
    _box.put(invoice.id, invoice);
    state = [...state, invoice];
  }
}

final invoiceHistoryProvider =
    StateNotifierProvider<InvoiceHistoryNotifier, List<GenerateInvoiceModel>>((
      ref,
    ) {
      final box = Hive.box<GenerateInvoiceModel>(HiveBoxNames.invoiceBox);
      return InvoiceHistoryNotifier(box);
    });

final totalSalesProvider = Provider<double>((ref) {
  final invoices = ref.watch(invoiceHistoryProvider);
  return invoices.fold(0.0, (sum, invoice) => sum + invoice.total);
});
