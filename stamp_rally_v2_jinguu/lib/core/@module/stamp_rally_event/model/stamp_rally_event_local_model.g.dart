// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stamp_rally_event_local_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StampRallyEventLocalModelImpl _$$StampRallyEventLocalModelImplFromJson(
        Map<String, dynamic> json) =>
    _$StampRallyEventLocalModelImpl(
      code: json['code'] as String?,
      status:
          $enumDecodeNullable(_$StampRallyEventStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$StampRallyEventLocalModelImplToJson(
        _$StampRallyEventLocalModelImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': _$StampRallyEventStatusEnumMap[instance.status],
    };

const _$StampRallyEventStatusEnumMap = {
  StampRallyEventStatus.notStarted: 'notStarted',
  StampRallyEventStatus.inProgress: 'inProgress',
  StampRallyEventStatus.completed: 'completed',
};
