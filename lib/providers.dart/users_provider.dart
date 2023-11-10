import 'package:flutter/material.dart';
import 'package:pantheon/models.dart/generalUser_model.dart';
import 'package:pantheon/providers.dart/db_provider.dart';
import 'package:pantheon/providers.dart/logged_user_provider.dart';

class UsersProvider extends ChangeNotifier {
  GlobalKey<FormState> formKeyUsers = GlobalKey<FormState>(); // key para Sign Up
  GlobalKey<FormState> formKeyUsers2 = GlobalKey<FormState>(); // key para Login
  GlobalKey<FormState> formKeyUsers3 = GlobalKey<FormState>(); // key para actulizar peso
  GlobalKey<FormState> formKeyUsers4 = GlobalKey<FormState>(); // key para actulizar altura

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

  bool isValidForm() { // Valid for Sign Up
    print(formKeyUsers.currentState?.validate());
    return formKeyUsers.currentState?.validate() ?? false;
  }

  bool isValidForm2() { // Valid for Login
    print(formKeyUsers2.currentState?.validate());
    return formKeyUsers2.currentState?.validate() ?? false;
  }

  bool isValidForm3() { // Valid for Peso
    print(formKeyUsers2.currentState?.validate());
    return formKeyUsers2.currentState?.validate() ?? false;
  }

  bool isValidForm4() { // Valid for Altura
    print(formKeyUsers2.currentState?.validate());
    return formKeyUsers2.currentState?.validate() ?? false;
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
    //print("Nombre que llega al provider: $name");
    final res = await DBProvider.db.getUserName(name);
    return res;
  }

  getUserInfo(int id) async {
    final res = await DBProvider.db.getUserById(id);
    print('*** GET USER INFO: $res');
    return res;
  }

  getSesion(String name) async {
    //print("Nombre que llega al provider GETSESION: $name");
    final res = await DBProvider.db.getUserIdByName(name);
    //print('*** ID que retorna GETSESIO: $res');
    return res;
  }

  Future<bool> validateUser(String name, String password) async {
    //print("Nombre que llega al provider: $name");
    //print("Contraseña que llega al provider: $password");
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