import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  String dbName = 'quotes.db';
  String tableName = 'like';

  Database? _database;

  Future<Database?> get database async => _database ?? await initDatabase();

  Future<Database?> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, dbName);
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        String sql = '''
      CREATE TABLE $tableName (
      id INTEGER PRIMARY AUTOINCREMENT,
      quote TEXT NOT NULL,
      author TEXT NOT NULL
      )
      ''';
        db.execute(sql);
      },
    );
  }

  Future<int> insertData(String quote, String author) async {
    final db = await database;
    String sql = '''
    INSERT INTO $tableName (quote, author) VALUES (?, ?)
    ''';
    List args = [quote, author];
    return await db!.rawInsert(sql, args);
  }

  Future<List<Map<String, Object?>>> readAllData() async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName
    ''';
    return await db!.rawQuery(sql);
  }

  Future<int> deleteData(int id) async{
    final db = await database;
    String sql = '''
    DELETE FROM $tableName WHERE id = ?
    ''';
    return await db!.rawDelete(sql, [id]);
  }
}
