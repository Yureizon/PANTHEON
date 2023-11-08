import 'package:flutter/material.dart';
import 'package:pantheon/models.dart/generalUser_model.dart';
import 'package:pantheon/providers.dart/db_provider.dart';

class UsersProvider extends ChangeNotifier {
  GlobalKey<FormState> formKeyUsers = GlobalKey<FormState>();

  String createOrUpdate = "create";
  int? id;
  String name = '';
  String password = '';
  double? weight;
  double? height;
  String? rol;

  bool _isLoading = false;
  List<GeneralUser> users = [];
  
  bool get isLoading => _isLoading;

  set isLoading(bool opc) {
    _isLoading = opc;
  }

  bool isValidForm() {
    print(formKeyUsers.currentState?.validate());
    return formKeyUsers.currentState?.validate() ?? false;
  }

  Future<GeneralUser> addUser() async {
    final GeneralUser generalUser = GeneralUser(name: name, weight: weight, height: height, password: password);

    final id = await DBProvider.db.newUser(generalUser);

    generalUser.id = id;

    users.add(generalUser);

    notifyListeners();

    return generalUser;
  }

  getUserByName(String name) async {
    final res = await DBProvider.db.getUserName(name);
    return res;
  }

  deleteUserById(int id) async {
    final res = await DBProvider.db.deleteUser(id);
    loadUsers();
  }

  updateUser() async {
    final generalUser = GeneralUser(id: id, name: name, weight: weight, height: height, password: password);
    final res = await DBProvider.db.updateUser(generalUser);
    print("Updated ID: $res");
    loadUsers();
  }

  assignDataWithUser(GeneralUser generalUser) {
    id = generalUser.id;
    name = generalUser.name;
    password = generalUser.password;
    weight = generalUser.weight;
    height = generalUser.height;
  }

  resetUserData() {
    id = 0;
    name = '';
    password = '';
    weight = 0.0;
    height = 0.0;
    createOrUpdate = "create";
  }

  loadUsers() async {
    final List<GeneralUser> users = await DBProvider.db.getAllUsers();
    //operador Spreed
    this.users = [...users];
    notifyListeners();
  }
}