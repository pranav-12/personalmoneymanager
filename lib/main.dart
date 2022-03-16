import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personal_moneymanagement/models/catagory/catagory_models.dart';
import 'package:personal_moneymanagement/models/transactions/transactionmodel.dart';
import 'package:personal_moneymanagement/screens/add_transaction/screen_add_transaction.dart';
import 'package:personal_moneymanagement/screens/home/screen_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(catagoryTypeAdapter().typeId)) {
    Hive.registerAdapter(catagoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CatagoryModelAdapter().typeId)) {
    Hive.registerAdapter(CatagoryModelAdapter());
  }
  runApp(const MyApp());

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Money Manager',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const ScreenHome(),
        routes: {
          ScreenAddTransaction.routeName: (ctx) => const ScreenAddTransaction(),
        });
  }
}
