import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:book_finder_app/domain/entities/book.dart';
import 'package:book_finder_app/presentation/blocs/book_search/book_search_bloc.dart';
import 'package:book_finder_app/presentation/blocs/book_search/book_search_event.dart';
import 'package:book_finder_app/presentation/blocs/book_search/book_search_state.dart';

import '../../mocks_test.mocks.dart' show MockSearchBooksUseCase;


void main() {
  late MockSearchBooksUseCase mockUseCase;
  late BookSearchBloc bloc;

  final mockBook = Book(
    title: 'Effective Dart',
    authors: ['Dart Team'],
    coverId: 54321,
    key: 'OL987654M',
  );

  setUp(() {
    mockUseCase = MockSearchBooksUseCase();
    bloc = BookSearchBloc(searchBooksUseCase: mockUseCase);
  });

  test('initial state is BookSearchInitial', () {
    expect(bloc.state, BookSearchInitial());
  });

  blocTest<BookSearchBloc, BookSearchState>(
    'emits [Loading, Loaded] when search is successful',
    build: () {
      when(mockUseCase('dart', 1)).thenAnswer((_) async => [mockBook]);
      return bloc;
    },
    act: (bloc) => bloc.add(const SearchBooksEvent('dart')),
    expect: () => [
      BookSearchLoading(),
      BookSearchLoaded([mockBook], hasReachedMax: true),
    ],
    verify: (_) => verify(mockUseCase('dart', 1)).called(1),
  );

  blocTest<BookSearchBloc, BookSearchState>(
    'emits [Loading, Error] when search fails',
    build: () {
      when(mockUseCase('flutter', 1)).thenThrow(Exception('API error'));
      return bloc;
    },
    act: (bloc) => bloc.add(const SearchBooksEvent('flutter')),
    expect: () => [
      BookSearchLoading(),
      isA<BookSearchError>(),
    ],
  );

  blocTest<BookSearchBloc, BookSearchState>(
    'appends books on LoadMoreBooksEvent',
    build: () {
      when(mockUseCase('dart', 1)).thenAnswer((_) async => [mockBook]);
      when(mockUseCase('dart', 2)).thenAnswer((_) async => [mockBook]);
      return bloc;
    },
    act: (bloc) async {
      bloc.add(const SearchBooksEvent('dart'));
      await Future.delayed(Duration.zero);
      bloc.add(const LoadMoreBooksEvent());
    },
    expect: () => [
      BookSearchLoading(),
      BookSearchLoaded([mockBook], hasReachedMax: true),
      BookSearchLoaded([mockBook, mockBook], hasReachedMax: true),
    ],
  );
}
