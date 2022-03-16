import 'package:hive_flutter/adapters.dart';
import 'package:personal_moneymanagement/models/catagory/catagory_models.dart';
part 'transactionmodel.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final catagoryType type;
  @HiveField(4)
  final CatagoryModel category;
  @HiveField(5)
  String? id;

  TransactionModel({
    required this.purpose,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
