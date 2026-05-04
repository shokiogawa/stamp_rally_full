// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stamp_rally_event_csv_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StampRallyEventCsvModelImpl _$$StampRallyEventCsvModelImplFromJson(
        Map<String, dynamic> json) =>
    _$StampRallyEventCsvModelImpl(
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      position: json['position'] as String?,
      placeDataListCsv: json['placeDataListCsv'] as String?,
      mainImage: json['mainImage'] as String?,
      period: json['period'] as String?,
      prizeInfoName: json['prizeInfoName'] as String?,
      prizeInfoImage: json['prizeInfoImage'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$StampRallyEventCsvModelImplToJson(
        _$StampRallyEventCsvModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'title': instance.title,
      'description': instance.description,
      'position': instance.position,
      'placeDataListCsv': instance.placeDataListCsv,
      'mainImage': instance.mainImage,
      'period': instance.period,
      'prizeInfoName': instance.prizeInfoName,
      'prizeInfoImage': instance.prizeInfoImage,
      'status': instance.status,
    };
