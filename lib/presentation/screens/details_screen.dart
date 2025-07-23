import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/book.dart';
import '../../data/datasources/book_local_data_source.dart';
import '../../data/models/book_model.dart';

class DetailsScreen extends StatefulWidget {
  final Book book;

  const DetailsScreen({super.key, required this.book});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _rotation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveBook() async {
    final bookModel = BookModel(
      key: widget.book.key,
      title: widget.book.title,
      authors: widget.book.authors,
      coverId: widget.book.coverId,
    );

    await BookLocalDataSource().insertBook(bookModel);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Book saved to local storage")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final imageUrl = book.coverId != null
        ? 'https://covers.openlibrary.org/b/id/${book.coverId}-L.jpg'
        : null;

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveBook,
        label: const Text("Save"),
        icon: const Icon(Icons.bookmark_add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (imageUrl != null)
              Center(
                child: AnimatedBuilder(
                  animation: _rotation,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: _rotation.value,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 220,
                        placeholder: (_, __) =>
                        const CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 24),
            Text(book.title,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              "by ${book.authors?.join(', ') ?? 'Unknown Author'}",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
