
import '../../domain/entities/book.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/book_remote_data_source.dart' show BookRemoteDataSource;
import '../models/book_model.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;

  BookRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Book>> searchBooks(String query, int page) async {
    final bookModels = await remoteDataSource.searchBooks(query, page);
    return bookModels.map((model) => model.toEntity()).toList();
  }
}
