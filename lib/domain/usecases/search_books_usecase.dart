import '../entities/book.dart';
import '../repositories/book_repository.dart';

class SearchBooksUseCase {
  final BookRepository repository;

  SearchBooksUseCase(this.repository);

  Future<List<Book>> call(String query, int page) {
    return repository.searchBooks(query, page);
  }
}
