// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsItemImpl _$$NewsItemImplFromJson(Map<String, dynamic> json) =>
    _$NewsItemImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      url: Uri.parse(json['url'] as String),
      consultationDate: DateTime.parse(json['consultationDate'] as String),
      coverUrl: json['coverUrl'] == null
          ? null
          : Uri.parse(json['coverUrl'] as String),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      truthness: (json['truthness'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$NewsItemImplToJson(_$NewsItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'url': instance.url.toString(),
      'consultationDate': instance.consultationDate.toIso8601String(),
      'coverUrl': instance.coverUrl?.toString(),
      'date': instance.date?.toIso8601String(),
      'truthness': instance.truthness,
    };
