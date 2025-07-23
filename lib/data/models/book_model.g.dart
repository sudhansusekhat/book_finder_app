// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookModelImpl _$$BookModelImplFromJson(Map<String, dynamic> json) =>
    _$BookModelImpl(
      title: json['title'] as String,
      authors: (json['author_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      coverId: (json['cover_i'] as num?)?.toInt(),
      key: json['key'] as String,
    );

Map<String, dynamic> _$$BookModelImplToJson(_$BookModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author_name': instance.authors,
      'cover_i': instance.coverId,
      'key': instance.key,
    };
