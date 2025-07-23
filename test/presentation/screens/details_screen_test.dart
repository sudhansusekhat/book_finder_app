import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:book_finder_app/presentation/screens/details_screen.dart';
import 'package:book_finder_app/domain/entities/book.dart';

void main() {
  final testBook = Book(
    title: 'Test Book Title',
    authors: ['Test Author'],
    coverId: 1234,
    key: 'OL1234M',
  );

  testWidgets('renders book details with title and author', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DetailsScreen(book: testBook),
    ));

    expect(find.text('Test Book Title'), findsOneWidget);
    expect(find.textContaining('Test Author'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('tapping save button shows SnackBar', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DetailsScreen(book: testBook),
    ));

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle(); // let SnackBar appear

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.textContaining('Book saved'), findsOneWidget);
  });
}
