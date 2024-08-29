import 'package:path/path.dart';
import 'package:quotes_app_databse/modal/quote_modal.dart';
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
}
