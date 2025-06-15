import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class InvoiceItem {
  final String id;
  final String name;
  final double price;
  final int qty;

  InvoiceItem({
    required this.name,
    required this.price,
    required this.qty,
    String? id,
  }) : id = id ?? uuid.v4();

  double get total => price * qty;

  // Firebase Map Conversion
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'price': price, 'qty': qty, 'total': total};
  }

  // Firebase Constructor
  factory InvoiceItem.fromMap(Map<String, dynamic> map) {
    return InvoiceItem(
      id: map['id'] ?? uuid.v4(), // Use provided ID or generate a new one
      name: map['name'],
      price: map['price'],
      qty: map['qty'],
    );
  }

  // Firebase from Firestore Document
  factory InvoiceItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return InvoiceItem(
      id: doc.id,
      name: data['name'],
      price: data['price'].toDouble(),
      qty: data['qty'],
    );
  }

  // Copy method for updates
  InvoiceItem copyWith({String? name, double? price, int? qty, String? id}) {
    return InvoiceItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      qty: qty ?? this.qty,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceItem &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
