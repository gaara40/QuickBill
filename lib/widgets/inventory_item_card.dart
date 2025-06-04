import 'package:flutter/material.dart';
import 'package:quick_bill/models/inventory_item.dart';

class InventoryItemCard extends StatelessWidget {
  const InventoryItemCard({super.key, required this.inventoryItem});

  final InventoryItem inventoryItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(inventoryItem.name),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('₹ ${inventoryItem.price.toStringAsFixed(2)}'),
              Text.rich(
                TextSpan(
                  text: 'Stock : ',
                  children: [
                    TextSpan(
                      text: '${inventoryItem.qty}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
