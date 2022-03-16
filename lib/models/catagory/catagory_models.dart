import 'package:hive_flutter/adapters.dart';
part 'catagory_models.g.dart';

@HiveType(typeId: 2)
enum catagoryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 1)
class CatagoryModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isdeleted;
  @HiveField(3)
  final catagoryType type;

  CatagoryModel(
      {required this.id,
      required this.name,
      required this.type,
      this.isdeleted = false});

  @override
  String toString() {
    return '($name  $type)';
  }
}
