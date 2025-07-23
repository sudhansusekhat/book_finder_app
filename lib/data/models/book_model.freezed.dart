// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BookModel _$BookModelFromJson(Map<String, dynamic> json) {
  return _BookModel.fromJson(json);
}

/// @nodoc
mixin _$BookModel {
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_name')
  List<String>? get authors => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_i')
  int? get coverId => throw _privateConstructorUsedError;
  @JsonKey(name: 'key')
  String get key => throw _privateConstructorUsedError;

  /// Serializes this BookModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookModelCopyWith<BookModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookModelCopyWith<$Res> {
  factory $BookModelCopyWith(BookModel value, $Res Function(BookModel) then) =
      _$BookModelCopyWithImpl<$Res, BookModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'author_name') List<String>? authors,
    @JsonKey(name: 'cover_i') int? coverId,
    @JsonKey(name: 'key') String key,
  });
}

/// @nodoc
class _$BookModelCopyWithImpl<$Res, $Val extends BookModel>
    implements $BookModelCopyWith<$Res> {
  _$BookModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? authors = freezed,
    Object? coverId = freezed,
    Object? key = null,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            authors: freezed == authors
                ? _value.authors
                : authors // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            coverId: freezed == coverId
                ? _value.coverId
                : coverId // ignore: cast_nullable_to_non_nullable
                      as int?,
            key: null == key
                ? _value.key
                : key // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BookModelImplCopyWith<$Res>
    implements $BookModelCopyWith<$Res> {
  factory _$$BookModelImplCopyWith(
    _$BookModelImpl value,
    $Res Function(_$BookModelImpl) then,
  ) = __$$BookModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'author_name') List<String>? authors,
    @JsonKey(name: 'cover_i') int? coverId,
    @JsonKey(name: 'key') String key,
  });
}

/// @nodoc
class __$$BookModelImplCopyWithImpl<$Res>
    extends _$BookModelCopyWithImpl<$Res, _$BookModelImpl>
    implements _$$BookModelImplCopyWith<$Res> {
  __$$BookModelImplCopyWithImpl(
    _$BookModelImpl _value,
    $Res Function(_$BookModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? authors = freezed,
    Object? coverId = freezed,
    Object? key = null,
  }) {
    return _then(
      _$BookModelImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        authors: freezed == authors
            ? _value._authors
            : authors // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        coverId: freezed == coverId
            ? _value.coverId
            : coverId // ignore: cast_nullable_to_non_nullable
                  as int?,
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BookModelImpl implements _BookModel {
  const _$BookModelImpl({
    @JsonKey(name: 'title') required this.title,
    @JsonKey(name: 'author_name') final List<String>? authors,
    @JsonKey(name: 'cover_i') this.coverId,
    @JsonKey(name: 'key') required this.key,
  }) : _authors = authors;

  factory _$BookModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookModelImplFromJson(json);

  @override
  @JsonKey(name: 'title')
  final String title;
  final List<String>? _authors;
  @override
  @JsonKey(name: 'author_name')
  List<String>? get authors {
    final value = _authors;
    if (value == null) return null;
    if (_authors is EqualUnmodifiableListView) return _authors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'cover_i')
  final int? coverId;
  @override
  @JsonKey(name: 'key')
  final String key;

  @override
  String toString() {
    return 'BookModel(title: $title, authors: $authors, coverId: $coverId, key: $key)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._authors, _authors) &&
            (identical(other.coverId, coverId) || other.coverId == coverId) &&
            (identical(other.key, key) || other.key == key));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    const DeepCollectionEquality().hash(_authors),
    coverId,
    key,
  );

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookModelImplCopyWith<_$BookModelImpl> get copyWith =>
      __$$BookModelImplCopyWithImpl<_$BookModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookModelImplToJson(this);
  }
}

abstract class _BookModel implements BookModel {
  const factory _BookModel({
    @JsonKey(name: 'title') required final String title,
    @JsonKey(name: 'author_name') final List<String>? authors,
    @JsonKey(name: 'cover_i') final int? coverId,
    @JsonKey(name: 'key') required final String key,
  }) = _$BookModelImpl;

  factory _BookModel.fromJson(Map<String, dynamic> json) =
      _$BookModelImpl.fromJson;

  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'author_name')
  List<String>? get authors;
  @override
  @JsonKey(name: 'cover_i')
  int? get coverId;
  @override
  @JsonKey(name: 'key')
  String get key;

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookModelImplCopyWith<_$BookModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
