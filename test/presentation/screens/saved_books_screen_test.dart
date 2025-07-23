import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';

import 'package:book_finder_app/data/datasources/book_local_data_source.dart';
import 'package:book_finder_app/data/models/book_model.dart';
import 'package:book_finder_app/presentation/screens/saved_books_screen.dart';

void main() {
  late Database inMemoryDb;
  late BookLocalDataSource dataSource;

  final testBook = BookModel(
    key: 'OL123',
    title: 'Saved Test Book',
    authors: ['Tester'],
    coverId: 100,
  );

  setUp(() async {
    inMemoryDb = await openDatabase(
      inMemoryDatabasePath,
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

    dataSource = BookLocalDataSource(overrideDb: inMemoryDb);
    await dataSource.insertBook(testBook);
  });

  tearDown(() async {
    await inMemoryDb.close();
  });

  testWidgets('displays saved book title and author from local db',
          (tester) async {
        await tester.pumpWidget(MaterialApp(
          home: SavedBooksScreen(overrideDataSource: dataSource),
        ));

        await tester.pumpAndSettle();

        expect(find.text('Saved Test Book'), findsOneWidget);
        expect(find.textContaining('Tester'), findsOneWidget);
      });

  testWidgets('shows fallback message if no books are saved',
          (tester) async {
        final emptyDb = await openDatabase(
          inMemoryDatabasePath,
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

        final emptyDataSource = BookLocalDataSource(overrideDb: emptyDb);

        await tester.pumpWidget(MaterialApp(
          home: SavedBooksScreen(overrideDataSource: emptyDataSource),
        ));

        await tester.pumpAndSettle();

        expect(find.textContaining("No saved books"), findsOneWidget);
        await emptyDb.close();
      });
}
