import 'package:equatable/equatable.dart';

abstract class BookSearchEvent extends Equatable {
  const BookSearchEvent();
}

class SearchBooksEvent extends BookSearchEvent {
  final String query;

  const SearchBooksEvent(this.query);

  @override
  List<Object> get props => [query];
}

class LoadMoreBooksEvent extends BookSearchEvent {
  const LoadMoreBooksEvent();

  @override
  List<Object?> get props => [];
}
