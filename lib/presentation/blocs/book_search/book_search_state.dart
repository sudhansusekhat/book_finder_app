import 'package:equatable/equatable.dart';
import '../../../domain/entities/book.dart';

abstract class BookSearchState extends Equatable {
  const BookSearchState();
}

class BookSearchInitial extends BookSearchState {
  @override
  List<Object?> get props => [];
}

class BookSearchLoading extends BookSearchState {
  @override
  List<Object?> get props => [];
}

class BookSearchLoaded extends BookSearchState {
  final List<Book> books;
  final bool hasReachedMax;

  const BookSearchLoaded(this.books, {this.hasReachedMax = false});

  BookSearchLoaded copyWith({
    List<Book>? books,
    bool? hasReachedMax,
  }) {
    return BookSearchLoaded(
      books ?? this.books,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [books, hasReachedMax];
}

class BookSearchError extends BookSearchState {
  final String message;

  const BookSearchError(this.message);

  @override
  List<Object?> get props => [message];
}
