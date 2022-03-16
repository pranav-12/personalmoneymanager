

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personal_moneymanagement/models/catagory/catagory_models.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CatagoryDbFunctions {
  Future<List<CatagoryModel>> getCatagories();
  Future<void> insertCatagory(CatagoryModel value);
  Future<void> deleteCategory(String categoryID);
}

class CatagoryDb implements CatagoryDbFunctions {
  CatagoryDb._internal();

  static CatagoryDb instance = CatagoryDb._internal();

  factory CatagoryDb() {
    return instance;
  }

  ValueNotifier<List<CatagoryModel>> incomeCategoryListListener =
      ValueNotifier([]);
  ValueNotifier<List<CatagoryModel>> expenseCategoryListListener =
      ValueNotifier([]);

  @override
  Future<void> insertCatagory(CatagoryModel value) async {
    final _catagorydb = await Hive.openBox<CatagoryModel>(CATEGORY_DB_NAME);
    _catagorydb.put(value.id,value);
    refreshUI();
  }

  @override
  Future<List<CatagoryModel>> getCatagories() async {
    final _catagorydb = await Hive.openBox<CatagoryModel>(CATEGORY_DB_NAME);
    return _catagorydb.values.toList();
  }

  Future<void> refreshUI() async {
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();
    final _allCategories = await getCatagories();
    await Future.forEach(_allCategories, (CatagoryModel category) {
      if (category.type == catagoryType.income) {
        incomeCategoryListListener.value.add(category);
      } else{
        expenseCategoryListListener.value.add(category);}
    });

    incomeCategoryListListener.notifyListeners();
    expenseCategoryListListener.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final _categoryDB = await Hive.openBox<CatagoryModel>(CATEGORY_DB_NAME);
    _categoryDB.delete(categoryID);
    refreshUI();
  }
}
