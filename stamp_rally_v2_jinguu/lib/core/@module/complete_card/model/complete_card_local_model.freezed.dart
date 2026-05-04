// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complete_card_local_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompleteCardLocalModel _$CompleteCardLocalModelFromJson(
    Map<String, dynamic> json) {
  return _CompleteCardLocalModel.fromJson(json);
}

/// @nodoc
mixin _$CompleteCardLocalModel {
  String get eventCode => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get completeDateTime => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this CompleteCardLocalModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompleteCardLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompleteCardLocalModelCopyWith<CompleteCardLocalModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompleteCardLocalModelCopyWith<$Res> {
  factory $CompleteCardLocalModelCopyWith(CompleteCardLocalModel value,
          $Res Function(CompleteCardLocalModel) then) =
      _$CompleteCardLocalModelCopyWithImpl<$Res, CompleteCardLocalModel>;
  @useResult
  $Res call(
      {String eventCode,
      String title,
      DateTime completeDateTime,
      String message});
}

/// @nodoc
class _$CompleteCardLocalModelCopyWithImpl<$Res,
        $Val extends CompleteCardLocalModel>
    implements $CompleteCardLocalModelCopyWith<$Res> {
  _$CompleteCardLocalModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompleteCardLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventCode = null,
    Object? title = null,
    Object? completeDateTime = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      eventCode: null == eventCode
          ? _value.eventCode
          : eventCode // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      completeDateTime: null == completeDateTime
          ? _value.completeDateTime
          : completeDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompleteCardLocalModelImplCopyWith<$Res>
    implements $CompleteCardLocalModelCopyWith<$Res> {
  factory _$$CompleteCardLocalModelImplCopyWith(
          _$CompleteCardLocalModelImpl value,
          $Res Function(_$CompleteCardLocalModelImpl) then) =
      __$$CompleteCardLocalModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String eventCode,
      String title,
      DateTime completeDateTime,
      String message});
}

/// @nodoc
class __$$CompleteCardLocalModelImplCopyWithImpl<$Res>
    extends _$CompleteCardLocalModelCopyWithImpl<$Res,
        _$CompleteCardLocalModelImpl>
    implements _$$CompleteCardLocalModelImplCopyWith<$Res> {
  __$$CompleteCardLocalModelImplCopyWithImpl(
      _$CompleteCardLocalModelImpl _value,
      $Res Function(_$CompleteCardLocalModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompleteCardLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventCode = null,
    Object? title = null,
    Object? completeDateTime = null,
    Object? message = null,
  }) {
    return _then(_$CompleteCardLocalModelImpl(
      eventCode: null == eventCode
          ? _value.eventCode
          : eventCode // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      completeDateTime: null == completeDateTime
          ? _value.completeDateTime
          : completeDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompleteCardLocalModelImpl extends _CompleteCardLocalModel {
  const _$CompleteCardLocalModelImpl(
      {required this.eventCode,
      required this.title,
      required this.completeDateTime,
      required this.message})
      : super._();

  factory _$CompleteCardLocalModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompleteCardLocalModelImplFromJson(json);

  @override
  final String eventCode;
  @override
  final String title;
  @override
  final DateTime completeDateTime;
  @override
  final String message;

  @override
  String toString() {
    return 'CompleteCardLocalModel(eventCode: $eventCode, title: $title, completeDateTime: $completeDateTime, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompleteCardLocalModelImpl &&
            (identical(other.eventCode, eventCode) ||
                other.eventCode == eventCode) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.completeDateTime, completeDateTime) ||
                other.completeDateTime == completeDateTime) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, eventCode, title, completeDateTime, message);

  /// Create a copy of CompleteCardLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompleteCardLocalModelImplCopyWith<_$CompleteCardLocalModelImpl>
      get copyWith => __$$CompleteCardLocalModelImplCopyWithImpl<
          _$CompleteCardLocalModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompleteCardLocalModelImplToJson(
      this,
    );
  }
}

abstract class _CompleteCardLocalModel extends CompleteCardLocalModel {
  const factory _CompleteCardLocalModel(
      {required final String eventCode,
      required final String title,
      required final DateTime completeDateTime,
      required final String message}) = _$CompleteCardLocalModelImpl;
  const _CompleteCardLocalModel._() : super._();

  factory _CompleteCardLocalModel.fromJson(Map<String, dynamic> json) =
      _$CompleteCardLocalModelImpl.fromJson;

  @override
  String get eventCode;
  @override
  String get title;
  @override
  DateTime get completeDateTime;
  @override
  String get message;

  /// Create a copy of CompleteCardLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompleteCardLocalModelImplCopyWith<_$CompleteCardLocalModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
