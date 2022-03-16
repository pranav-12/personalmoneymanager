

import 'package:flutter/material.dart';
import 'package:personal_moneymanagement/db/catagory/catagory_db.dart';
import 'package:personal_moneymanagement/models/catagory/catagory_models.dart';

ValueNotifier<catagoryType> selectedCategoryNotifier =
    ValueNotifier(catagoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Text('Add Category'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Categoty Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                RadioButton(title: 'Income', type: catagoryType.income),
                RadioButton(title: 'Expense', type: catagoryType.expense)
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final _name = _nameEditingController.text;
              if (_name.isEmpty) {
                return;
              }
              final _type = selectedCategoryNotifier.value;
              final _category = CatagoryModel(
                  id: DateTime.now().microsecondsSinceEpoch.toString(),
                  name: _name,
                  type: _type);

              CatagoryDb().insertCatagory(_category);
              Navigator.of(ctx).pop();
            },
            child: const Text('Add'),
          )
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final catagoryType type;
  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext ctx, catagoryType newCategory, Widget? _) {
            return Radio<catagoryType>(
              value: type,
              groupValue: newCategory,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategoryNotifier.value = value;
                selectedCategoryNotifier.notifyListeners();
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
