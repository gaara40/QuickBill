import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quick_bill/firebase_options.dart';
import 'package:quick_bill/models/generate_invoice_model.dart';
import 'package:quick_bill/models/inventory_item.dart';
import 'package:quick_bill/models/invoice_item.dart';
import 'package:quick_bill/screens/splash_screen.dart';
import 'package:quick_bill/theme_data.dart';
import 'package:path_provider/path_provider.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(InventoryItemAdapter());
  Hive.registerAdapter(InvoiceItemAdapter());
  Hive.registerAdapter(GenerateInvoiceModelAdapter());
  await Hive.openBox<InventoryItem>('inventoryItem_box');
  await Hive.openBox<GenerateInvoiceModel>('invoice_box');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: QuickBillTheme.lightTheme,
      darkTheme: QuickBillTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: SplashScreen(),
    );
  }
}
