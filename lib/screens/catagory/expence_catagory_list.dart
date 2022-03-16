
import 'package:flutter/material.dart';
import 'package:personal_moneymanagement/db/catagory/catagory_db.dart';
import 'package:personal_moneymanagement/models/catagory/catagory_models.dart';

class ExpenseCatagoryList extends StatelessWidget {
  const ExpenseCatagoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CatagoryDb().expenseCategoryListListener,
        builder: (BuildContext ctx, List<CatagoryModel> newList, Widget? _) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final Category = newList[index];
                return Card(
                  child: ListTile(
                    title: Text(Category.name),
                    trailing: IconButton(
                      onPressed: () {
                        CatagoryDb.instance.deleteCategory(Category.id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(height: 10);
              },
              itemCount: newList.length);
        });
  }
}
