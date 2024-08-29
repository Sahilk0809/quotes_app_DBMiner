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
      author TEXT NOT NULL,
      isFavourite INTEGER DEFAULT 0,
      )
      ''';
        db.execute(sql);
      },
    );
  }

  Future<int> addFavouriteInDatabase(
      String quote, String author, String category, int isFavourite) async {
    final db = await database;
    String sql = '''
    INSERT INTO $tableName (quote, author, category, isFavourite)
    VALUES (?, ?, ?, ?)
    ''';
    List args = [quote, author, category, isFavourite];
    return await db!.rawInsert(sql, args);
  }

  Future<List<QuotesModel>> readFavouriteQuotes() async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName
    ''';
    final map = await db!.rawQuery(sql);
    return List.generate(
      map.length,
      (index) => QuotesModel.fromMap(map[index]),
    );
  }

  Future<int> deleteFavouriteQuote(int id) async {
    final db = await database;
    String sql = '''
    DELETE FROM $tableName WHERE id = ?
    ''';
    List args = [id];
    return await db!.rawDelete(sql, args);
  }
}
