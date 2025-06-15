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

  InventoryItem copyWith({String? name, double? price, int? qty, String? id}) {
    return InventoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      qty: qty ?? this.qty,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryItem &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
