import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/stuClass.dart';
 
class Dbase {
  static final _databaseName = "stu.db";
  static final _databaseVersion = 1;
 
  static final table = 'stu';
 
  static final columnId = 'id';
  static final columnName = 'name';
  static final columnClgName= 'clgname';
  static final columnBranch = 'branch';
  static final columnYear = 'year';
 
  Dbase._privateConstructor();
  static final Dbase instance = Dbase._privateConstructor();
 
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }
 
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }
 
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName FLOAT NOT NULL
            $columnClgName FLOAT NOT NULL
            $columnBranch FLOAT NOT NULL
            $columnYear FLOAT NOT NULL
          )
          ''');
  }
 
  Future<int?> insert(StuClass todo) async {
    Database? db = await instance.database;
    var res = await db?.insert(table, todo.toMap());
    return res;
  }
 
  Future<List<Map<String, dynamic>>?> queryAllRows() async {
    Database? db = await instance.database;
    var res = await db?.query(table, orderBy: "$columnId DESC");
    return res;
  }
 
  Future<int?> delete(int id) async {
    Database? db = await instance.database;
    return await db?.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
 
  Future<List<Map<String, Object?>>?> clearTable() async {
    Database? db = await instance.database;
    return await db?.rawQuery("DELETE FROM $table");
  }
}