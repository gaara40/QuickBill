import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'invoice_item.g.dart';

final uuid = Uuid();

@HiveType(typeId: 1)
class InvoiceItem extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final int qty;

  InvoiceItem({
    required this.name,
    required this.price,
    required this.qty,
    String? id,
  }) : id = uuid.v4();

  double get total => price * qty;

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
