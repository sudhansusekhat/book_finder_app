

import 'package:book_finder_app/data/repositories/book_repository_impl.dart' show BookRepositoryImpl;
import 'package:book_finder_app/domain/usecases/search_books_usecase.dart' show SearchBooksUseCase;
import 'package:book_finder_app/presentation/blocs/book_search/book_search_bloc.dart' show BookSearchBloc;
import 'package:book_finder_app/presentation/screens/saved_books_screen.dart';
import 'package:book_finder_app/presentation/screens/search_screen.dart' show SearchScreen;
import 'package:dio/dio.dart' show Dio;
import 'package:flutter/cupertino.dart' show runApp, StatelessWidget, BuildContext, Widget, Text;
import 'package:flutter/material.dart' show MaterialApp, ThemeData, Colors, TabBar, Tab, AppBar, TabBarView, Scaffold, DefaultTabController;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

import 'data/datasources/book_remote_data_source.dart';



void main() {
  final dio = Dio();
  final BookRemoteDataSource remoteDataSource = BookRemoteDataSourceImpl(dio: dio);
  final repository = BookRepositoryImpl(remoteDataSource: remoteDataSource);

  final useCase = SearchBooksUseCase(repository);

  runApp(MyApp(useCase: useCase));
}

class MyApp extends StatelessWidget {
  final SearchBooksUseCase useCase;

  const MyApp({super.key, required this.useCase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Finder',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: BlocProvider(
        create: (_) => BookSearchBloc(searchBooksUseCase: useCase),
        child: const HomeNavigationScreen(),
      ),
    );
  }
}

class HomeNavigationScreen extends StatelessWidget {
  const HomeNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Book Finder"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Search"),
              Tab(text: "Saved"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const SearchScreen(),
            SavedBooksScreen(),
          ],
        ),
      ),
    );
  }
}
