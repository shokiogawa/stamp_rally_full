// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_card_local_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompleteCardLocalModelImpl _$$CompleteCardLocalModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CompleteCardLocalModelImpl(
      eventCode: json['eventCode'] as String,
      title: json['title'] as String,
      completeDateTime: DateTime.parse(json['completeDateTime'] as String),
      message: json['message'] as String,
    );

Map<String, dynamic> _$$CompleteCardLocalModelImplToJson(
        _$CompleteCardLocalModelImpl instance) =>
    <String, dynamic>{
      'eventCode': instance.eventCode,
      'title': instance.title,
      'completeDateTime': instance.completeDateTime.toIso8601String(),
      'message': instance.message,
    };
