import 'package:flutter/material.dart';
import 'package:pantheon/models.dart/generalUser_model.dart';
import 'package:pantheon/providers.dart/db_provider.dart';

class UsersProvider extends ChangeNotifier {

  String createOrUpdate = "create";
  int? id;
  String name = '';
  String password = '';
  double? weight;
  double? height;
  String rol = 'general';

  bool _isLoading = false;
  List<GeneralUser> users = [];
  
  bool get isLoading => _isLoading;

  set isLoading(bool opc) {
    _isLoading = opc;
  }

  bool isValidLocalForm(GlobalKey<FormState> formKey) {
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }

  Future<GeneralUser> addUser() async {
    final GeneralUser generalUser = GeneralUser(name: name, weight: weight, height: height, password: password, rol: rol);

    final id = await DBProvider.db.newUser(generalUser);

    generalUser.id = id;

    users.add(generalUser);

    notifyListeners();

    return generalUser;
  }

  Future<bool> getUserByName(String name) async {
    final res = await DBProvider.db.getUserName(name);
    return res;
  }

  getUserInfo(int id) async {
    final res = await DBProvider.db.getUserById(id);
    print('*** GET USER INFO: $res');
    return res;
  }

  getSesion(String name) async {
    final res = await DBProvider.db.getUserIdByName(name);
    return res;
  }

  Future<bool> validateUser(String name, String password) async {
    final res = await DBProvider.db.validateUserDB(name, password);
    return res;
  }

  getTodo() {
    print(''' datos del GETTODO
      name: $name
      peso: $weight
      altura: $height
      password: $password
      '''
    );
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
    //notifyListeners();
  }

  loadUsers() async {
    final List<GeneralUser> users = await DBProvider.db.getAllUsers();
    //operador Spreed
    this.users = [...users];
    notifyListeners();
  }
}