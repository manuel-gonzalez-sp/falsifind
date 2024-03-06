// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsItemImpl _$$NewsItemImplFromJson(Map<String, dynamic> json) =>
    _$NewsItemImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      content: json['content'] as String,
      sourceUrl: json['sourceUrl'] as String,
      coverUrl: json['coverUrl'] as String?,
      consultationDate: json['consultationDate'] == null
          ? null
          : DateTime.parse(json['consultationDate'] as String),
    );

Map<String, dynamic> _$$NewsItemImplToJson(_$NewsItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date.toIso8601String(),
      'content': instance.content,
      'sourceUrl': instance.sourceUrl,
      'coverUrl': instance.coverUrl,
      'consultationDate': instance.consultationDate?.toIso8601String(),
    };
