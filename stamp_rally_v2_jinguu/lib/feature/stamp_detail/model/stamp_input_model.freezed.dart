// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stamp_input_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StampInputModel _$StampInputModelFromJson(Map<String, dynamic> json) {
  return _StampInputModel.fromJson(json);
}

/// @nodoc
mixin _$StampInputModel {
// スタンプを押したスポットのID
  String get historicSpotId => throw _privateConstructorUsedError;
  String get placeName => throw _privateConstructorUsedError;

  /// Serializes this StampInputModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StampInputModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StampInputModelCopyWith<StampInputModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StampInputModelCopyWith<$Res> {
  factory $StampInputModelCopyWith(
          StampInputModel value, $Res Function(StampInputModel) then) =
      _$StampInputModelCopyWithImpl<$Res, StampInputModel>;
  @useResult
  $Res call({String historicSpotId, String placeName});
}

/// @nodoc
class _$StampInputModelCopyWithImpl<$Res, $Val extends StampInputModel>
    implements $StampInputModelCopyWith<$Res> {
  _$StampInputModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StampInputModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? historicSpotId = null,
    Object? placeName = null,
  }) {
    return _then(_value.copyWith(
      historicSpotId: null == historicSpotId
          ? _value.historicSpotId
          : historicSpotId // ignore: cast_nullable_to_non_nullable
              as String,
      placeName: null == placeName
          ? _value.placeName
          : placeName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StampInputModelImplCopyWith<$Res>
    implements $StampInputModelCopyWith<$Res> {
  factory _$$StampInputModelImplCopyWith(_$StampInputModelImpl value,
          $Res Function(_$StampInputModelImpl) then) =
      __$$StampInputModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String historicSpotId, String placeName});
}

/// @nodoc
class __$$StampInputModelImplCopyWithImpl<$Res>
    extends _$StampInputModelCopyWithImpl<$Res, _$StampInputModelImpl>
    implements _$$StampInputModelImplCopyWith<$Res> {
  __$$StampInputModelImplCopyWithImpl(
      _$StampInputModelImpl _value, $Res Function(_$StampInputModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of StampInputModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? historicSpotId = null,
    Object? placeName = null,
  }) {
    return _then(_$StampInputModelImpl(
      historicSpotId: null == historicSpotId
          ? _value.historicSpotId
          : historicSpotId // ignore: cast_nullable_to_non_nullable
              as String,
      placeName: null == placeName
          ? _value.placeName
          : placeName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StampInputModelImpl extends _StampInputModel {
  const _$StampInputModelImpl(
      {required this.historicSpotId, required this.placeName})
      : super._();

  factory _$StampInputModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StampInputModelImplFromJson(json);

// スタンプを押したスポットのID
  @override
  final String historicSpotId;
  @override
  final String placeName;

  @override
  String toString() {
    return 'StampInputModel(historicSpotId: $historicSpotId, placeName: $placeName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StampInputModelImpl &&
            (identical(other.historicSpotId, historicSpotId) ||
                other.historicSpotId == historicSpotId) &&
            (identical(other.placeName, placeName) ||
                other.placeName == placeName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, historicSpotId, placeName);

  /// Create a copy of StampInputModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StampInputModelImplCopyWith<_$StampInputModelImpl> get copyWith =>
      __$$StampInputModelImplCopyWithImpl<_$StampInputModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StampInputModelImplToJson(
      this,
    );
  }
}

abstract class _StampInputModel extends StampInputModel {
  const factory _StampInputModel(
      {required final String historicSpotId,
      required final String placeName}) = _$StampInputModelImpl;
  const _StampInputModel._() : super._();

  factory _StampInputModel.fromJson(Map<String, dynamic> json) =
      _$StampInputModelImpl.fromJson;

// スタンプを押したスポットのID
  @override
  String get historicSpotId;
  @override
  String get placeName;

  /// Create a copy of StampInputModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StampInputModelImplCopyWith<_$StampInputModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
