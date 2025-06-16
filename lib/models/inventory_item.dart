import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class InventoryItem {
  final String id;
  final String name;
  final double price;
  final int qty;

  InventoryItem({
    required this.name,
    required this.price,
    required this.qty,
    String? id,
  }) : id = id ?? uuid.v4();

  InventoryItem copyWith({String? id, String? name, double? price, int? qty}) {
    return InventoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      qty: qty ?? this.qty,
    );
  }

  factory InventoryItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return InventoryItem(
      id: doc.id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      qty: data['qty'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price, 'qty': qty};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InventoryItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
