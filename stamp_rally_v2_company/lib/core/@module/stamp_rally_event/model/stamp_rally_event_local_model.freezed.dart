// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stamp_rally_event_local_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StampRallyEventLocalModel _$StampRallyEventLocalModelFromJson(
    Map<String, dynamic> json) {
  return _StampRallyEventLocalModel.fromJson(json);
}

/// @nodoc
mixin _$StampRallyEventLocalModel {
  String? get code => throw _privateConstructorUsedError;
  StampRallyEventStatus? get status => throw _privateConstructorUsedError;

  /// Serializes this StampRallyEventLocalModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StampRallyEventLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StampRallyEventLocalModelCopyWith<StampRallyEventLocalModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StampRallyEventLocalModelCopyWith<$Res> {
  factory $StampRallyEventLocalModelCopyWith(StampRallyEventLocalModel value,
          $Res Function(StampRallyEventLocalModel) then) =
      _$StampRallyEventLocalModelCopyWithImpl<$Res, StampRallyEventLocalModel>;
  @useResult
  $Res call({String? code, StampRallyEventStatus? status});
}

/// @nodoc
class _$StampRallyEventLocalModelCopyWithImpl<$Res,
        $Val extends StampRallyEventLocalModel>
    implements $StampRallyEventLocalModelCopyWith<$Res> {
  _$StampRallyEventLocalModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StampRallyEventLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StampRallyEventStatus?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StampRallyEventLocalModelImplCopyWith<$Res>
    implements $StampRallyEventLocalModelCopyWith<$Res> {
  factory _$$StampRallyEventLocalModelImplCopyWith(
          _$StampRallyEventLocalModelImpl value,
          $Res Function(_$StampRallyEventLocalModelImpl) then) =
      __$$StampRallyEventLocalModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, StampRallyEventStatus? status});
}

/// @nodoc
class __$$StampRallyEventLocalModelImplCopyWithImpl<$Res>
    extends _$StampRallyEventLocalModelCopyWithImpl<$Res,
        _$StampRallyEventLocalModelImpl>
    implements _$$StampRallyEventLocalModelImplCopyWith<$Res> {
  __$$StampRallyEventLocalModelImplCopyWithImpl(
      _$StampRallyEventLocalModelImpl _value,
      $Res Function(_$StampRallyEventLocalModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of StampRallyEventLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? status = freezed,
  }) {
    return _then(_$StampRallyEventLocalModelImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StampRallyEventStatus?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StampRallyEventLocalModelImpl extends _StampRallyEventLocalModel {
  const _$StampRallyEventLocalModelImpl({this.code, this.status}) : super._();

  factory _$StampRallyEventLocalModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StampRallyEventLocalModelImplFromJson(json);

  @override
  final String? code;
  @override
  final StampRallyEventStatus? status;

  @override
  String toString() {
    return 'StampRallyEventLocalModel(code: $code, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StampRallyEventLocalModelImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, status);

  /// Create a copy of StampRallyEventLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StampRallyEventLocalModelImplCopyWith<_$StampRallyEventLocalModelImpl>
      get copyWith => __$$StampRallyEventLocalModelImplCopyWithImpl<
          _$StampRallyEventLocalModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StampRallyEventLocalModelImplToJson(
      this,
    );
  }
}

abstract class _StampRallyEventLocalModel extends StampRallyEventLocalModel {
  const factory _StampRallyEventLocalModel(
      {final String? code,
      final StampRallyEventStatus? status}) = _$StampRallyEventLocalModelImpl;
  const _StampRallyEventLocalModel._() : super._();

  factory _StampRallyEventLocalModel.fromJson(Map<String, dynamic> json) =
      _$StampRallyEventLocalModelImpl.fromJson;

  @override
  String? get code;
  @override
  StampRallyEventStatus? get status;

  /// Create a copy of StampRallyEventLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StampRallyEventLocalModelImplCopyWith<_$StampRallyEventLocalModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
