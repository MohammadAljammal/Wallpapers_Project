import 'package:josequal/model/wallpapers_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSqfLite {
  static final _databaseName = "wallpapers.db";
  static final _databaseVersion = 1;
  static final table = 'favorite_wallpapers';
  static final columnId = 'id';

  /// For Singleton
  DatabaseSqfLite._privateConstructor();

  static final DatabaseSqfLite instance = DatabaseSqfLite._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// For Initialize DB
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  /// For Create DB
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            width INTEGER,
            height INTEGER,
            photographer_id INTEGER,
            url TEXT,
            photographer TEXT,
            photographer_url TEXT,
            avg_color TEXT,
            original TEXT,
            large2x TEXT,
            large TEXT,
            medium TEXT,
            small TEXT,
            portrait TEXT,
            landscape TEXT,
            tiny TEXT,
            liked TEXT,
            alt TEXT
          )
          ''');
  }

  /// For Add WallpaperModel To DB
  Future<int> insert(WallpaperModel wallpaperModel) async {
    Database db = await instance.database;
    return await db.insert(table, wallpaperModel.toJsonSql());
  }

  /// For Fetch Favorite Wallpapers From DB
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  /// For Delete Wallpaper From DB
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
