import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/name_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    return openDatabase(
      join(path, 'names.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE names(id INTEGER PRIMARY KEY, name TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertName(NameModel nameModel) async {
    final db = await database;
    return db.insert('names', nameModel.toMap());
  }

  Future<List<NameModel>> getNames() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('names');
    return List.generate(maps.length, (i) {
      return NameModel.fromMap(maps[i]);
    });
  }

  Future<int> updateName(NameModel nameModel) async {
    final db = await database;
    return db.update(
      'names',
      nameModel.toMap(),
      where: 'id = ?',
      whereArgs: [nameModel.id],
    );
  }

  Future<int> deleteName(int id) async {
    final db = await database;
    return db.delete(
      'names',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
