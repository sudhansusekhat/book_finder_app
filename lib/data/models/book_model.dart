import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/book.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

@freezed
class BookModel with _$BookModel {
  const factory BookModel({
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'author_name') List<String>? authors,
    @JsonKey(name: 'cover_i') int? coverId,
    @JsonKey(name: 'key') required String key,
  }) = _BookModel;

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
}

extension BookModelMapper on BookModel {
  Book toEntity() {
    return Book(
      title: this.title,
      authors: this.authors,
      coverId: this.coverId,
      key: this.key,
    );
  }
}
