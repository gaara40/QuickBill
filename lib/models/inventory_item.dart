import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

part 'inventory_item.g.dart';

final uuid = Uuid();

@HiveType(typeId: 0)
class InventoryItem extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
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
