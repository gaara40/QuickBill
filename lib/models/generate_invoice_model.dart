import 'package:quick_bill/models/invoice_item_model.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class GenerateInvoiceModel {
  final String id;
  final String customerName;
  final DateTime dateTime;
  final List<InvoiceItem> items;
  final double total;

  GenerateInvoiceModel({
    required this.customerName,
    required this.dateTime,
    required this.items,
    required this.total,
  }) : id = uuid.v4();
}
