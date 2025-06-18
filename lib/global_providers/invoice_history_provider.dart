import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quick_bill/models/generate_invoice_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class InvoiceHistoryNotifier extends StateNotifier<List<GenerateInvoiceModel>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  InvoiceHistoryNotifier() : super([]) {
    loadInvoices();
  }

  // Load invoices from Firestore
  Future<void> loadInvoices() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final invoiceCollection = _firestore
          .collection('users')
          .doc(userId)
          .collection('invoices')
          .orderBy('dateTime', descending: true);

      final snapshot = await invoiceCollection.get();
      state =
          snapshot.docs.map((doc) {
            return GenerateInvoiceModel.fromFirestore(doc);
          }).toList();
    }
  }

  // Add a new invoice to Firestore and update local state
  Future<void> addInvoice(GenerateInvoiceModel invoice) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        final invoiceRef = _firestore
            .collection('users')
            .doc(userId)
            .collection('invoices')
            .doc(invoice.id);

        await invoiceRef.set(invoice.toMap());
        state = [invoice, ...state];
      }
    } catch (e) {
      debugPrint("Error saving invoice to Firestore: $e");
    }
  }

  // You can add other methods for deleting or updating invoices if necessary
}

final invoiceHistoryProvider =
    StateNotifierProvider<InvoiceHistoryNotifier, List<GenerateInvoiceModel>>((
      ref,
    ) {
      return InvoiceHistoryNotifier();
    });

final totalSalesProvider = Provider<double>((ref) {
  final invoices = ref.watch(invoiceHistoryProvider);
  return invoices.fold(0.0, (sum, invoice) => sum + invoice.total);
});
