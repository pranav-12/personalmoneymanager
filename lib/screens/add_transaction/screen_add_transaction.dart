import 'package:flutter/material.dart';
import 'package:personal_moneymanagement/db/catagory/catagory_db.dart';
import 'package:personal_moneymanagement/db/transaction/transaction_db.dart';
import 'package:personal_moneymanagement/models/catagory/catagory_models.dart';
import 'package:personal_moneymanagement/models/transactions/transactionmodel.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenAddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  catagoryType? _selectCategoryType;
  CatagoryModel? _selectCategoryModel;
  String? _categoryID;

  final _purposeController = TextEditingController();

  final _amountController = TextEditingController();
  @override
  void initState() {
    _selectCategoryType = catagoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Purpose
              TextFormField(
                controller: _purposeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Purpose',
                ),
              ),
              //Amount
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Amount',
                ),
              ),
              //Calender

              TextButton.icon(
                onPressed: () async {
                  final _selectDateTEMP = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(
                      Duration(days: 30),
                    ),
                    lastDate: DateTime.now(),
                  );
                  if (_selectDateTEMP == null) {
                    return;
                  } else {
                    print(_selectDateTEMP.toString());
                    setState(() {
                      _selectedDate = _selectDateTEMP;
                    });
                  }
                },
                icon: Icon(Icons.calendar_today),
                label: Text(_selectedDate == null
                    ? 'Select Date'
                    : _selectedDate!.toString()),
              ),

              //Category
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: catagoryType.income,
                        groupValue: _selectCategoryType,
                        onChanged: (newvalue) {
                          setState(() {
                            _selectCategoryType = catagoryType.income;
                            _categoryID = null;
                          });
                        },
                      ),
                      Text('Income'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: catagoryType.expense,
                        groupValue: _selectCategoryType,
                        onChanged: (newvalue) {
                          setState(() {
                            _selectCategoryType = catagoryType.expense;
                            _categoryID = null;
                          });
                        },
                      ),
                      Text('Expense'),
                    ],
                  ),
                ],
              ),
              //category Type
              DropdownButton(
                hint: const Text('Select Category'),
                value: _categoryID,
                items: (_selectCategoryType == catagoryType.income
                        ? CatagoryDb().incomeCategoryListListener
                        : CatagoryDb().expenseCategoryListListener)
                    .value
                    .map(
                  (e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                      onTap: () {
                        _selectCategoryModel = e;
                      },
                    );
                  },
                ).toList(),
                onChanged: (selectedValue) {
                  setState(() {
                    _categoryID = selectedValue as String?;
                  });
                },
              ),

              //submitButton

              ElevatedButton.icon(
                onPressed: () {
                  addTransaction();
                },
                icon: Icon(Icons.check),
                label: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeController.text;
    final _amounttext = _amountController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amounttext.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    final _parsedAmount = double.tryParse(_amounttext);
    if (_parsedAmount == null) {
      return;
    }
    if (_selectCategoryModel == null) {
      return;
    }

    final _model = TransactionModel(
      purpose: _purposeText,
      amount: _parsedAmount,
      date: _selectedDate!,
      type: _selectCategoryType!,
      category: _selectCategoryModel!,
    );

    await TransactionDb.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDb.instance.refresh();
  }
}
