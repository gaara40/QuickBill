class InvoiceItem {
  final String name;
  final double price;
  final int qty;

  const InvoiceItem({
    required this.name,
    required this.price,
    required this.qty,
  });

  double get total => price * qty;

  InvoiceItem copyWith({String? name, double? price, int? qty}) {
    return InvoiceItem(
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
