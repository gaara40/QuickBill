import 'package:hive_flutter/adapters.dart';
import 'package:quick_bill/models/invoice_item.dart';
import 'package:uuid/uuid.dart';

part 'generate_invoice_model.g.dart';

final uuid = Uuid();

@HiveType(typeId: 2)
class GenerateInvoiceModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String customerName;

  @HiveField(2)
  final DateTime dateTime;

  @HiveField(3)
  final List<InvoiceItem> items;

  @HiveField(4)
  final double total;

  GenerateInvoiceModel({
    required this.customerName,
    required this.dateTime,
    required this.items,
    required this.total,
  }) : id = uuid.v4();
}
