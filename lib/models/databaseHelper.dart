import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'store.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart_items (
        id TEXT PRIMARY KEY,
        title TEXT,
        quantity INTEGER,
        price REAL,
        productId TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE orders (
        id TEXT PRIMARY KEY,
        total REAL,
        date TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE order_items (
         id TEXT,
          orderId TEXT,
          title TEXT,
          price REAL,
          quantity INTEGER,
          productId TEXT,
          PRIMARY KEY (id, orderId),
          FOREIGN KEY (orderId) REFERENCES orders (id)
      )
    ''');
  }
}
