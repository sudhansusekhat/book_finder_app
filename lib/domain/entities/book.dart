import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String title;
  final List<String>? authors;
  final int? coverId;
  final String key;

  const Book({
    required this.title,
    this.authors,
    this.coverId,
    required this.key,
  });

  @override
  List<Object?> get props => [title, authors, coverId, key];
}
