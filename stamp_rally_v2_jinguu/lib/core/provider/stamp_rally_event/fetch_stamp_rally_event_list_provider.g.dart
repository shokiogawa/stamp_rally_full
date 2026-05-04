// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_stamp_rally_event_list_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StampRallyEventModelImpl _$$StampRallyEventModelImplFromJson(
        Map<String, dynamic> json) =>
    _$StampRallyEventModelImpl(
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
      status:
          $enumDecodeNullable(_$StampRallyEventStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$StampRallyEventModelImplToJson(
        _$StampRallyEventModelImpl instance) =>
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
      'status': _$StampRallyEventStatusEnumMap[instance.status],
    };

const _$StampRallyEventStatusEnumMap = {
  StampRallyEventStatus.notStarted: 'notStarted',
  StampRallyEventStatus.inProgress: 'inProgress',
  StampRallyEventStatus.completed: 'completed',
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchStampRallyEventList2Hash() =>
    r'9ea838441b9b2b66bcaa2ffafe9e6b6acf350b81';

/// See also [fetchStampRallyEventList2].
@ProviderFor(fetchStampRallyEventList2)
final fetchStampRallyEventList2Provider =
    AutoDisposeFutureProvider<List<StampRallyEventModel>>.internal(
  fetchStampRallyEventList2,
  name: r'fetchStampRallyEventList2Provider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchStampRallyEventList2Hash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchStampRallyEventList2Ref
    = AutoDisposeFutureProviderRef<List<StampRallyEventModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
