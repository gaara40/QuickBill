import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/models/invoice_item_model.dart';

final availableItemsProvider = Provider<List<InvoiceItem>>((ref) {
  return [
    InvoiceItem(name: 'Tubelight', price: 50, qty: 1),
    InvoiceItem(name: 'Bulb', price: 20, qty: 2),
    InvoiceItem(name: 'Meter', price: 15, qty: 7),
    InvoiceItem(name: 'Switch', price: 12, qty: 3),
    InvoiceItem(name: 'Wire Roll', price: 150, qty: 1),
    InvoiceItem(name: 'Fan', price: 1200, qty: 5),
    InvoiceItem(name: 'Extension Box', price: 300, qty: 2),
    InvoiceItem(name: 'Screwdriver Set', price: 180, qty: 1),
    InvoiceItem(name: 'MCB Breaker', price: 450, qty: 1),
    InvoiceItem(name: 'LED Panel Light', price: 600, qty: 8),
    InvoiceItem(name: 'PVC Pipe 1 inch', price: 80, qty: 1),
    InvoiceItem(name: 'Ceiling Rose', price: 25, qty: 1),
    InvoiceItem(name: 'Cable Clips', price: 40, qty: 5),
    InvoiceItem(name: 'Power Socket', price: 90, qty: 1),
    InvoiceItem(name: 'Modular Switch Plate', price: 60, qty: 3),
    InvoiceItem(name: 'Electric Tester', price: 70, qty: 1),
    InvoiceItem(name: 'Multimeter', price: 950, qty: 4),
    InvoiceItem(name: 'Conduit Bender', price: 500, qty: 1),
    InvoiceItem(name: 'Fuse Carrier', price: 35, qty: 9),
  ];
});
