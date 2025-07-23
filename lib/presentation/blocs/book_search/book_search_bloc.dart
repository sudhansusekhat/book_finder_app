import 'package:flutter_bloc/flutter_bloc.dart';
import 'book_search_event.dart';
import 'book_search_state.dart';
import '../../../domain/entities/book.dart';
import '../../../domain/usecases/search_books_usecase.dart';

class BookSearchBloc extends Bloc<BookSearchEvent, BookSearchState> {
  final SearchBooksUseCase searchBooksUseCase;

  int _currentPage = 1;
  String _currentQuery = '';
  bool _isFetching = false;

  BookSearchBloc({required this.searchBooksUseCase}) : super(BookSearchInitial()) {
    on<SearchBooksEvent>(_onSearchBooks);
    on<LoadMoreBooksEvent>(_onLoadMoreBooks);
  }

  Future<void> _onSearchBooks(SearchBooksEvent event, Emitter emit) async {
    emit(BookSearchLoading());
    _currentPage = 1;
    _currentQuery = event.query;

    try {
      final books = await searchBooksUseCase(event.query, _currentPage);
      emit(BookSearchLoaded(books, hasReachedMax: books.length < 20));
    } catch (e) {
      emit(BookSearchError(e.toString()));
    }
  }

  Future<void> _onLoadMoreBooks(LoadMoreBooksEvent event, Emitter emit) async {
    if (_isFetching || state is! BookSearchLoaded) return;

    final currentState = state as BookSearchLoaded;
    _isFetching = true;
    _currentPage += 1;

    try {
      final moreBooks = await searchBooksUseCase(_currentQuery, _currentPage);
      final allBooks = List<Book>.from(currentState.books)..addAll(moreBooks);

      emit(currentState.copyWith(
        books: allBooks,
        hasReachedMax: moreBooks.length < 20,
      ));
    } catch (e) {
      emit(BookSearchError(e.toString()));
    } finally {
      _isFetching = false;
    }
  }
}
