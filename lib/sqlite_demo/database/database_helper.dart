import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../user_detail_page/controller/splitify_controller.dart';
import '../modal/user_modal.dart';
import '../user_repo/user_repo.dart';
import 'package:get/get.dart';
/*class DatabaseHandler {
  final SplitifyControler splitifyControler = Get.find();

  static DatabaseHandler _databaseHandler = DatabaseHandler._internal();
  static Database? _database;

  factory DatabaseHandler(){return _databaseHandler;}
  DatabaseHandler._internal();

  Future<Database?> openDB() async {
    _database = await openDatabase(
      join(await getDatabasesPath(),'demo.db'),
    );
    return _database;
  }
 *//* Future<Database?> openDB() async {
    _database = await DatabaseHandler().openDB();
    return _database;
  }*//*

  Future<void> insertDB() async {
    _database = await openDB();
    UserRepo userRepo = new UserRepo();
    userRepo.createTable(_database);
    UserModal userModal = UserModal(
     tripName:  splitifyControler.writeATripController.text.toString()..split("text").last.replaceAll(":", "").split("┤").last.split("├").first,
     userName: splitifyControler.controllers.string.toString()..split("text").last.replaceAll(":", "").split("┤").last.split("├").first,
      amount: splitifyControler.amountController.text.toString()..split("text").last.replaceAll(":", "").split("┤").last.split("├").first);
    await _database?.insert('user', userModal.toJson());
    await _database?.close();

  }

  Future<void> getFromUser() async {
    _database = await openDB();
    UserRepo userRepo = new UserRepo();
    await userRepo.getUsers(_database);
    await _database?.close();
  }
}*/


class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();
  final SplitifyControler splitifyControler = Get.find();

  DatabaseHelper._();

  late Database db;

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  Future<void> initDB() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'users_demo.db'),
      onCreate: (database, version) async {
        await database.execute(
          """
            CREATE TABLE users (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              tripName TEXT NOT NULL,
              amount INTEGER NOT NULL, 
              userName TEXT NOT NULL
            )
          """,
        );
      },
      version: 1,
    );
  }

  Future<int> insertUser(User user) async {
    int result = await db.insert('users', user.toMap());
    return result;
  }

  Future<int> updateUser(User user) async {
    int result = await db.update(
      'users',
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
    return result;
  }

  Future<List<User>> retrieveUsers() async {
    final List<Map<String, Object?>> queryResult = await db.query('users');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }

  Future<void> deleteUser(int id) async {
    await db.delete(
      'users',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
