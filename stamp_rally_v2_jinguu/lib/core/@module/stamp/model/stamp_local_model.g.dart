// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stamp_local_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StampLocalModelImpl _$$StampLocalModelImplFromJson(
        Map<String, dynamic> json) =>
    _$StampLocalModelImpl(
      eventCode: json['eventCode'] as String,
      historicSpotId: json['historicSpotId'] as String,
      placeName: json['placeName'] as String,
      stampedDateTimeList: (json['stampedDateTimeList'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$StampLocalModelImplToJson(
        _$StampLocalModelImpl instance) =>
    <String, dynamic>{
      'eventCode': instance.eventCode,
      'historicSpotId': instance.historicSpotId,
      'placeName': instance.placeName,
      'stampedDateTimeList':
          instance.stampedDateTimeList.map((e) => e.toIso8601String()).toList(),
    };
