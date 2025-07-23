import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:book_finder_app/data/models/book_model.dart';
import 'package:book_finder_app/data/repositories/book_repository_impl.dart';
import 'package:book_finder_app/domain/entities/book.dart';

import '../../mocks_test.mocks.dart' show MockBookRemoteDataSource;


void main() {
  late MockBookRemoteDataSource mockDataSource;
  late BookRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockBookRemoteDataSource();
    repository = BookRepositoryImpl(remoteDataSource: mockDataSource);
  });

  final bookModel = BookModel(
    title: 'Clean Code',
    authors: ['Robert C. Martin'],
    coverId: 12345,
    key: 'OL123456M',
  );

  final bookEntity = Book(
    title: 'Clean Code',
    authors: ['Robert C. Martin'],
    coverId: 12345,
    key: 'OL123456M',
  );

  group('BookRepositoryImpl', () {
    test('should return list of Book entities when API call is successful', () async {
      // Arrange
      when(mockDataSource.searchBooks('Clean Code', 1))
          .thenAnswer((_) async => [bookModel]);

      // Act
      final result = await repository.searchBooks('Clean Code', 1);

      // Assert
      expect(result, [bookEntity]);
      verify(mockDataSource.searchBooks('Clean Code', 1)).called(1);
    });

    test('should throw Exception when API call fails', () async {
      // Arrange
      when(mockDataSource.searchBooks(any, any)).thenThrow(Exception('API failed'));

      // Assert
      expect(() => repository.searchBooks('Something', 1), throwsException);
    });
  });
}
