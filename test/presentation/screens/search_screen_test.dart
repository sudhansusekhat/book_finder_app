import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_finder_app/domain/entities/book.dart';
import 'package:book_finder_app/presentation/blocs/book_search/book_search_bloc.dart';
import 'package:book_finder_app/presentation/blocs/book_search/book_search_state.dart';
import 'package:book_finder_app/presentation/blocs/book_search/book_search_event.dart';
import 'package:book_finder_app/presentation/screens/search_screen.dart';

class MockBookSearchBloc extends Mock implements BookSearchBloc {}

class FakeBookSearchEvent extends Fake implements BookSearchEvent {}
class FakeBookSearchState extends Fake implements BookSearchState {}

void main() {
  late MockBookSearchBloc mockBloc;

  final book = Book(
    title: "Flutter Test Book",
    authors: ["Test Author"],
    coverId: 123,
    key: "OL123M",
  );

  setUpAll(() {
    registerFallbackValue(FakeBookSearchEvent());
    registerFallbackValue(FakeBookSearchState());
  });

  setUp(() {
    mockBloc = MockBookSearchBloc();
  });

  Widget makeTestableWidget() {
    return MaterialApp(
      home: BlocProvider<BookSearchBloc>.value(
        value: mockBloc,
        child: const SearchScreen(),
      ),
    );
  }

  testWidgets('shows TextField and search icon', (tester) async {
    when(() => mockBloc.state).thenReturn(BookSearchInitial());

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('shows book list when BookSearchLoaded is emitted', (tester) async {
    when(() => mockBloc.state).thenReturn(BookSearchLoaded([book]));

    await tester.pumpWidget(makeTestableWidget());
    await tester.pumpAndSettle(); // settle animations

    expect(find.text("Flutter Test Book"), findsOneWidget);
    expect(find.text("Test Author"), findsOneWidget);
  });

  testWidgets('tapping search icon triggers SearchBooksEvent', (tester) async {
    when(() => mockBloc.state).thenReturn(BookSearchInitial());
    when(() => mockBloc.add(any())).thenAnswer((_) {});

    await tester.pumpWidget(makeTestableWidget());

    await tester.enterText(find.byType(TextField), 'flutter');
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    verify(() => mockBloc.add(const SearchBooksEvent('flutter'))).called(1);
  });
}
