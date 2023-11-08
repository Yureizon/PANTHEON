//import 'dart:ffi';
import 'dart:io';

import 'package:pantheon/models.dart/ejercicio_model.dart';
import 'package:pantheon/models.dart/generalUser_model.dart';
import 'package:pantheon/models.dart/receta_model.dart';
import 'package:pantheon/models.dart/workout_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';


class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    //Obteniendo direccion base donde se guardará la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    //Armamos la url donde quedará la base de datos
    final path = join(documentsDirectory.path, 'UsersDB.db');

    //Imprimos ruta
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) => {},
      onCreate: (db, version) async {
        await db.execute('''

        CREATE TABLE users(
          id INTEGER PRIMARY KEY,
          name TEXT,
          password TEXT,
          weight REAL,
          height REAL,
          rol TEXT
        )
        ''');

        await db.execute('''
          CREATE TABLE workouts (
            id INTEGER PRIMARY KEY,
            fecha TEXT,
            grupo TEXT
          )
          '''
        );

        await db.execute('''
          CREATE TABLE recetas (
            id INTEGER PRIMARY KEY,
            titulo TEXT,
            descripcion TEXT
          )
          '''
        );

        await db.execute('''
          CREATE TABLE ejercicios (
            id INTEGER PRIMARY KEY,
            titulo TEXT,
            subtitulo TEXT,
            descripcion TEXT
          )
          '''
        );
      },
    );
  }

  Future<int> newUserRaw(GeneralUser generalUser) async {
    final int? id = generalUser.id;
    final String name= generalUser.name;
    final double? weight = generalUser.weight;
    final double? height = generalUser.height;

    final db =
        await database; //Recibimos instancia de base de datos para trabajar con ella

    final int res = await db.rawInsert('''

      INSERT INTO users (id, name, weight, height) VALUES ($id, "$name", $weight, $height)

''');
    print(res);
    return res;
  }

  Future<int> newUser(GeneralUser generalUser) async {
    final db = await database;

    final int res = await db.insert("users", generalUser.toJson());

    return res;
  }

  Future<int> newWorkout (Workout workout) async {
    final db = await database;

    final int res = await db.insert("workouts", workout.toJson());

    return res;
  }

  Future<int> newReceta (Receta receta) async {
    final db = await database;

    final int res = await db.insert("recetas", receta.toJson());

    return res;
  }

  Future<int> newEjercicio (Ejercicio ejercicio) async {
    final db = await database;

    final int res = await db.insert("ejercicios", ejercicio.toJson());

    return res;
  }

  //Obtener un registro por id
  Future<GeneralUser?> getUserById(int id) async {
    final Database? db = await database;

    //usando Query para construir la consulta, con where y argumentos posicionales (whereArgs)
    final res = await db!.query('users', where: 'id = ?', whereArgs: [id]);
    print(res);
    //Preguntamos si trae algun dato. Si lo hace
    return res.isNotEmpty ? GeneralUser.fromJson(res.first) : null;
  }

  Future<bool> getUserName (String name) async {
    final Database? db = await database;
    //usando Query para construir la consulta, con where y argumentos posicionales (whereArgs)
    final res = await db!.query('users', where: 'name = ?', whereArgs: [name]);
    // Verifica si hay coincidencias en la lista de resultados
    print(res);
    bool userExists = res.isNotEmpty;
    return userExists;
  }

  Future<List<GeneralUser>> getAllUsers() async {
    final Database? db = await database;
    final res = await db!.query('users');
    //Transformamos con la funcion map instancias de nuestro modelo. Si no existen registros, devolvemos una lista vacia
    return res.isNotEmpty ? res.map((n) => GeneralUser.fromJson(n)).toList() : [];
  }

  Future<List<Workout>> getAllWorkouts() async {
    final Database? db = await database;
    final res = await db!.query('workouts');
    //Transformamos con la funcion map instancias de nuestro modelo. Si no existen registros, devolvemos una lista vacia
    return res.isNotEmpty ? res.map((n) => Workout.fromJson(n)).toList() : [];
  }

  Future<List<Receta>> getAllRecetas() async {
    final Database? db = await database;
    final res = await db!.query('recetas');
    //Transformamos con la funcion map instancias de nuestro modelo. Si no existen registros, devolvemos una lista vacia
    return res.isNotEmpty ? res.map((n) => Receta.fromJson(n)).toList() : [];
  }

  Future<List<Ejercicio>> getAllEjercicios() async {
    final Database? db = await database;
    final res = await db!.query('ejercicios');
    //Transformamos con la funcion map instancias de nuestro modelo. Si no existen registros, devolvemos una lista vacia
    return res.isNotEmpty ? res.map((n) => Ejercicio.fromJson(n)).toList() : [];
  }

  Future<int> updateUser(GeneralUser generalUser) async {
    try {
      //
      final Database? db = await database;
      //con updates, se usa el nombre de la tabla, seguido de los valores en formato de Mapa, seguido del where con parametros posicionales y los argumentos finales
      final res = await db!
          .update('users', generalUser.toJson(), where: 'id = ?', whereArgs: [generalUser.id]);
      return res;
    } catch (e) {
      print('Error al actualizar el usuario: $e');
      return -1;
    }
    
  }

  Future<int> deleteUser(int id) async {
    final Database? db = await database;
    final int res = await db!.delete('users', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteWorkout(int id) async {
    final Database? db = await database;
    final int res = await db!.delete('workouts', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteReceta(int id) async {
    final Database? db = await database;
    final int res = await db!.delete('recetas', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteEjercicio(int id) async {
    final Database? db = await database;
    final int res = await db!.delete('ejercicios', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllUsers() async {
    final Database? db = await database;
    final res = await db!.rawDelete('''
      DELETE FROM users    
    ''');
    return res;
  }
}