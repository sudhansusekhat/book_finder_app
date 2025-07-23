import 'package:flutter/material.dart';
import '../../data/datasources/book_local_data_source.dart';
import '../../domain/entities/book.dart';
import '../../data/models/book_model.dart';
import 'details_screen.dart';

class SavedBooksScreen extends StatefulWidget {
  final BookLocalDataSource dataSource;

  SavedBooksScreen({super.key, BookLocalDataSource? overrideDataSource})
      : dataSource = overrideDataSource ?? BookLocalDataSource();

  @override
  State<SavedBooksScreen> createState() => _SavedBooksScreenState();
}

class _SavedBooksScreenState extends State<SavedBooksScreen> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    _loadSavedBooks();
  }

  Future<void> _loadSavedBooks() async {
    final result = await widget.dataSource.getSavedBooks();
    setState(() {
      books = result.map((b) => b.toEntity()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: books.isEmpty
          ? const Center(child: Text("No saved books yet."))
          : ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text(book.authors?.join(', ') ?? 'Unknown Author'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsScreen(book: book),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
