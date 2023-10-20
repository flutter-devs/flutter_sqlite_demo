import 'package:flutter/material.dart';
import 'package:flutter_sqlite_demo/database/database_helper.dart';
import 'package:flutter_sqlite_demo/model/user_model.dart';

class UserProvider with ChangeNotifier {
  bool isLoading = false;
  List<UserModel> _users = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<UserModel> get users => _users;

  Future<void> loadUsers() async {
    isLoading = true;
    _users = await _databaseHelper.getUsers();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addUser(UserModel user) async {
    await _databaseHelper.insertUser(user);
    notifyListeners();
  }

  Future<void> updateUser(UserModel user) async {
    await _databaseHelper.updateUser(user);
    notifyListeners();
  }

  Future<void> deleteUser(int id) async {
    await _databaseHelper.deleteUser(id);
    await loadUsers();
  }
}
