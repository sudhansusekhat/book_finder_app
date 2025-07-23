import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/book_model.dart';

class BookLocalDataSource {
  final Database? overrideDb;
  Database? _db;

  BookLocalDataSource({this.overrideDb});

  Future<Database> get database async {
    if (overrideDb != null) return overrideDb!;
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'books.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE books(
            key TEXT PRIMARY KEY,
            title TEXT,
            authors TEXT,
            coverId INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertBook(BookModel book) async {
    final db = await database;
    await db.insert(
      'books',
      {
        'key': book.key,
        'title': book.title,
        'authors': book.authors?.join(',') ?? '',
        'coverId': book.coverId
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<BookModel>> getSavedBooks() async {
    final db = await database;
    final result = await db.query('books');

    return result.map((json) {
      return BookModel(
        key: json['key'] as String,
        title: json['title'] as String,
        authors: (json['authors'] as String).split(','),
        coverId: json['coverId'] as int?,
      );
    }).toList();
  }
}
