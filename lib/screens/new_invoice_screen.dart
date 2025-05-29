import 'package:flutter/material.dart';

class NewInvoiceScreen extends StatefulWidget {
  const NewInvoiceScreen({super.key});

  @override
  State<NewInvoiceScreen> createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  String? selectedItem;
  List<String> items = ['Paint Can', 'Screw Box'];

  final customerController = TextEditingController();

  final quantityController = TextEditingController();
  double total = 0;

  void calculateTotal() {
    final qty = int.tryParse(quantityController.text) ?? 0;
    const pricePerItem = 100.0; // temp price
    setState(() {
      total = qty * pricePerItem;
    });
  }

  @override
  void dispose() {
    customerController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Create Invoice")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: customerController,
              decoration: const InputDecoration(
                labelText: 'Customer Name',
                hintText: 'Name',
              ),
            ),
            const SizedBox(height: 16),

            // Item Dropdown
            DropdownButtonFormField<String>(
              value: selectedItem,
              decoration: const InputDecoration(labelText: "Select Item"),
              items:
                  items
                      .map((i) => DropdownMenuItem(value: i, child: Text(i)))
                      .toList(),
              onChanged: (value) => setState(() => selectedItem = value),
            ),
            const SizedBox(height: 16),

            // Quantity
            TextFormField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Quantity"),
              onChanged: (_) => calculateTotal(),
            ),
            const SizedBox(height: 24),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total:', style: theme.textTheme.titleMedium),
                Text(
                  '₹ ${total.toStringAsFixed(2)}',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),

            ElevatedButton.icon(
              onPressed: () {
                // TODO: Save and generate invoice
              },
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Generate Invoice'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
