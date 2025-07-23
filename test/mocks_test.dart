import 'package:book_finder_app/data/datasources/book_remote_data_source.dart' show BookRemoteDataSource;
import 'package:book_finder_app/domain/usecases/search_books_usecase.dart' show SearchBooksUseCase;
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:book_finder_app/domain/repositories/book_repository.dart';

@GenerateMocks([
  Dio,
  BookRepository, BookRemoteDataSource, SearchBooksUseCase
])
void main() {}
