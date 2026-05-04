// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stamp_rally_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StampRallyEventImpl _$$StampRallyEventImplFromJson(
        Map<String, dynamic> json) =>
    _$StampRallyEventImpl(
      id: json['id'] as String?,
      code: json['code'] as String?,
      title: json['title'] as String?,
      position: json['position'] as String?,
      url: json['url'] as String?,
      image: json['image'] as String?,
      period: json['period'] as String?,
      status: json['status'] as String?,
      isJoined: json['isJoined'] as bool?,
      isCompleted: json['isCompleted'] as bool?,
    );

Map<String, dynamic> _$$StampRallyEventImplToJson(
        _$StampRallyEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'title': instance.title,
      'position': instance.position,
      'url': instance.url,
      'image': instance.image,
      'period': instance.period,
      'status': instance.status,
      'isJoined': instance.isJoined,
      'isCompleted': instance.isCompleted,
    };
