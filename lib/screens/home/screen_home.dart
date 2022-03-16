import 'package:flutter/material.dart';

import 'package:personal_moneymanagement/screens/add_transaction/screen_add_transaction.dart';
import 'package:personal_moneymanagement/screens/catagory/category_add_popup.dart';
import 'package:personal_moneymanagement/screens/catagory/screen_catagory.dart';
import 'package:personal_moneymanagement/screens/home/widgets/bottom_navigation.dart';
import 'package:personal_moneymanagement/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [
    ScreenTransactions(),
    ScreenCatagory(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Money Manager'),
        centerTitle: true,
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('Add Transaction');
            Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
          } else {
            print('Add catagory');

            showCategoryAddPopup(context);
            // final _sample = CatagoryModel(
            //     id: DateTime.now().microsecondsSinceEpoch.toString(),
            //     name: 'travel',
            //     type: catagoryType.expense);

            // CatagoryDb().insertCatagory(_sample);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
