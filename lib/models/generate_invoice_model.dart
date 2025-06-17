import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_bill/models/invoice_item.dart';
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
    String? id,
  }) : id = uuid.v4();

  // Firebase Map Conversion
  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'dateTime': Timestamp.fromDate(dateTime),
      'total': total,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }

  // Firebase Constructor
  factory GenerateInvoiceModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GenerateInvoiceModel(
      id: doc.id,
      customerName: data['customerName'],
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      total: data['total'],
      items: List<InvoiceItem>.from(
        data['items'].map((item) => InvoiceItem.fromMap(item)),
      ),
    );
  }
}
