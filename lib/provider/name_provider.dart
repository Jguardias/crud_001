import 'package:flutter/material.dart';
import '../bd/database_helper.dart';
import '../model/name_model.dart';

class NameProvider with ChangeNotifier {
  List<NameModel> _names = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<NameModel> get names => _names;

  Future<void> loadNames() async {
    _names = await _dbHelper.getNames();
    notifyListeners();
  }

  Future<void> addName(NameModel name) async {
    await _dbHelper.insertName(name);
    await loadNames();
  }

  Future<void> updateName(NameModel name) async {
    await _dbHelper.updateName(name);
    await loadNames();
  }

  Future<void> deleteName(int id) async {
    await _dbHelper.deleteName(id);
    await loadNames();
  }
}
