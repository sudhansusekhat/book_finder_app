import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../blocs/book_search/book_search_bloc.dart';
import '../blocs/book_search/book_search_event.dart';
import '../blocs/book_search/book_search_state.dart';
import '../../domain/entities/book.dart';
import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<BookSearchBloc>().add(LoadMoreBooksEvent());
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    if (query.trim().isNotEmpty) {
      context.read<BookSearchBloc>().add(SearchBooksEvent(query.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Search book by title...',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => _onSearch(_controller.text),
              ),
            ),
            onSubmitted: _onSearch,
          ),
        ),
        Expanded(
          child: BlocBuilder<BookSearchBloc, BookSearchState>(
            builder: (context, state) {
              if (state is BookSearchLoading) {
                return _buildShimmer();
              } else if (state is BookSearchLoaded) {
                if (state.books.isEmpty) {
                  return const Center(child: Text('No books found.'));
                }
                return RefreshIndicator(
                  onRefresh: () async => _onSearch(_controller.text),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.hasReachedMax
                        ? state.books.length
                        : state.books.length + 1,
                    itemBuilder: (context, index) {
                      if (index >= state.books.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return _buildBookItem(state.books[index]);
                    },
                  ),
                );
              } else if (state is BookSearchError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const Center(child: Text('Search for books above'));
            },
          ),
        )
      ],
    );
  }

  Widget _buildShimmer() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: const ListTile(
          leading: CircleAvatar(radius: 28, backgroundColor: Colors.white),
          title: SizedBox(height: 14, width: double.infinity, child: DecoratedBox(decoration: BoxDecoration(color: Colors.white))),
          subtitle: SizedBox(height: 10, width: double.infinity, child: DecoratedBox(decoration: BoxDecoration(color: Colors.white))),
        ),
      ),
    );
  }

  Widget _buildBookItem(Book book) {
    return ListTile(
      leading: book.coverId != null
          ? CachedNetworkImage(
        imageUrl: 'https://covers.openlibrary.org/b/id/${book.coverId}-M.jpg',
        placeholder: (context, url) => const CircularProgressIndicator(),
        width: 50,
        height: 70,
        fit: BoxFit.cover,
      )
          : const Icon(Icons.book, size: 50),
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
  }
}
