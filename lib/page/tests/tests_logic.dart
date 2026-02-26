import 'package:flutter_rapid/flutter_rapid.dart';
import '../../../data/app_data.dart';

class TestsLogic extends RapidLogic {
  List<LabTest> allTests = AppData.tests;

  String search = '';
  String? selectedCategory;

  // Initial category (when coming from category screen)
  void setInitialCategory(String? categoryId) {
    selectedCategory = categoryId;
  }

  void setSearch(String value) {
    search = value;
    update();
  }

  void setCategory(String? categoryId) {
    selectedCategory = categoryId;
    update();
  }

  List<LabTest> get filteredTests {
    return allTests.where((test) {
      final matchesSearch =
          search.isEmpty ||
          test.name.toLowerCase().contains(search.toLowerCase());

      final matchesCategory =
          selectedCategory == null ||
          test.categoryId == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }
}