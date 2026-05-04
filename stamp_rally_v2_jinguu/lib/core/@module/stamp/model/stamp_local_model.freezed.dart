// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stamp_local_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StampLocalModel _$StampLocalModelFromJson(Map<String, dynamic> json) {
  return _StampLocalModel.fromJson(json);
}

/// @nodoc
mixin _$StampLocalModel {
  String get eventCode => throw _privateConstructorUsedError; // スタンプを押したスポットのID
  String get historicSpotId => throw _privateConstructorUsedError;
  String get placeName => throw _privateConstructorUsedError; // スタンプを押した日時のリスト
  List<DateTime> get stampedDateTimeList => throw _privateConstructorUsedError;

  /// Serializes this StampLocalModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StampLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StampLocalModelCopyWith<StampLocalModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StampLocalModelCopyWith<$Res> {
  factory $StampLocalModelCopyWith(
          StampLocalModel value, $Res Function(StampLocalModel) then) =
      _$StampLocalModelCopyWithImpl<$Res, StampLocalModel>;
  @useResult
  $Res call(
      {String eventCode,
      String historicSpotId,
      String placeName,
      List<DateTime> stampedDateTimeList});
}

/// @nodoc
class _$StampLocalModelCopyWithImpl<$Res, $Val extends StampLocalModel>
    implements $StampLocalModelCopyWith<$Res> {
  _$StampLocalModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StampLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventCode = null,
    Object? historicSpotId = null,
    Object? placeName = null,
    Object? stampedDateTimeList = null,
  }) {
    return _then(_value.copyWith(
      eventCode: null == eventCode
          ? _value.eventCode
          : eventCode // ignore: cast_nullable_to_non_nullable
              as String,
      historicSpotId: null == historicSpotId
          ? _value.historicSpotId
          : historicSpotId // ignore: cast_nullable_to_non_nullable
              as String,
      placeName: null == placeName
          ? _value.placeName
          : placeName // ignore: cast_nullable_to_non_nullable
              as String,
      stampedDateTimeList: null == stampedDateTimeList
          ? _value.stampedDateTimeList
          : stampedDateTimeList // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StampLocalModelImplCopyWith<$Res>
    implements $StampLocalModelCopyWith<$Res> {
  factory _$$StampLocalModelImplCopyWith(_$StampLocalModelImpl value,
          $Res Function(_$StampLocalModelImpl) then) =
      __$$StampLocalModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String eventCode,
      String historicSpotId,
      String placeName,
      List<DateTime> stampedDateTimeList});
}

/// @nodoc
class __$$StampLocalModelImplCopyWithImpl<$Res>
    extends _$StampLocalModelCopyWithImpl<$Res, _$StampLocalModelImpl>
    implements _$$StampLocalModelImplCopyWith<$Res> {
  __$$StampLocalModelImplCopyWithImpl(
      _$StampLocalModelImpl _value, $Res Function(_$StampLocalModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of StampLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventCode = null,
    Object? historicSpotId = null,
    Object? placeName = null,
    Object? stampedDateTimeList = null,
  }) {
    return _then(_$StampLocalModelImpl(
      eventCode: null == eventCode
          ? _value.eventCode
          : eventCode // ignore: cast_nullable_to_non_nullable
              as String,
      historicSpotId: null == historicSpotId
          ? _value.historicSpotId
          : historicSpotId // ignore: cast_nullable_to_non_nullable
              as String,
      placeName: null == placeName
          ? _value.placeName
          : placeName // ignore: cast_nullable_to_non_nullable
              as String,
      stampedDateTimeList: null == stampedDateTimeList
          ? _value._stampedDateTimeList
          : stampedDateTimeList // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StampLocalModelImpl extends _StampLocalModel {
  const _$StampLocalModelImpl(
      {required this.eventCode,
      required this.historicSpotId,
      required this.placeName,
      final List<DateTime> stampedDateTimeList = const []})
      : _stampedDateTimeList = stampedDateTimeList,
        super._();

  factory _$StampLocalModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StampLocalModelImplFromJson(json);

  @override
  final String eventCode;
// スタンプを押したスポットのID
  @override
  final String historicSpotId;
  @override
  final String placeName;
// スタンプを押した日時のリスト
  final List<DateTime> _stampedDateTimeList;
// スタンプを押した日時のリスト
  @override
  @JsonKey()
  List<DateTime> get stampedDateTimeList {
    if (_stampedDateTimeList is EqualUnmodifiableListView)
      return _stampedDateTimeList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stampedDateTimeList);
  }

  @override
  String toString() {
    return 'StampLocalModel(eventCode: $eventCode, historicSpotId: $historicSpotId, placeName: $placeName, stampedDateTimeList: $stampedDateTimeList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StampLocalModelImpl &&
            (identical(other.eventCode, eventCode) ||
                other.eventCode == eventCode) &&
            (identical(other.historicSpotId, historicSpotId) ||
                other.historicSpotId == historicSpotId) &&
            (identical(other.placeName, placeName) ||
                other.placeName == placeName) &&
            const DeepCollectionEquality()
                .equals(other._stampedDateTimeList, _stampedDateTimeList));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, eventCode, historicSpotId,
      placeName, const DeepCollectionEquality().hash(_stampedDateTimeList));

  /// Create a copy of StampLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StampLocalModelImplCopyWith<_$StampLocalModelImpl> get copyWith =>
      __$$StampLocalModelImplCopyWithImpl<_$StampLocalModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StampLocalModelImplToJson(
      this,
    );
  }
}

abstract class _StampLocalModel extends StampLocalModel {
  const factory _StampLocalModel(
      {required final String eventCode,
      required final String historicSpotId,
      required final String placeName,
      final List<DateTime> stampedDateTimeList}) = _$StampLocalModelImpl;
  const _StampLocalModel._() : super._();

  factory _StampLocalModel.fromJson(Map<String, dynamic> json) =
      _$StampLocalModelImpl.fromJson;

  @override
  String get eventCode; // スタンプを押したスポットのID
  @override
  String get historicSpotId;
  @override
  String get placeName; // スタンプを押した日時のリスト
  @override
  List<DateTime> get stampedDateTimeList;

  /// Create a copy of StampLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StampLocalModelImplCopyWith<_$StampLocalModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
