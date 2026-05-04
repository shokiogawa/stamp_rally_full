// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complete_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompleteCardModel _$CompleteCardModelFromJson(Map<String, dynamic> json) {
  return _CompleteCardModel.fromJson(json);
}

/// @nodoc
mixin _$CompleteCardModel {
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this CompleteCardModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompleteCardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompleteCardModelCopyWith<CompleteCardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompleteCardModelCopyWith<$Res> {
  factory $CompleteCardModelCopyWith(
          CompleteCardModel value, $Res Function(CompleteCardModel) then) =
      _$CompleteCardModelCopyWithImpl<$Res, CompleteCardModel>;
  @useResult
  $Res call({String title, String message});
}

/// @nodoc
class _$CompleteCardModelCopyWithImpl<$Res, $Val extends CompleteCardModel>
    implements $CompleteCardModelCopyWith<$Res> {
  _$CompleteCardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompleteCardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompleteCardModelImplCopyWith<$Res>
    implements $CompleteCardModelCopyWith<$Res> {
  factory _$$CompleteCardModelImplCopyWith(_$CompleteCardModelImpl value,
          $Res Function(_$CompleteCardModelImpl) then) =
      __$$CompleteCardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String message});
}

/// @nodoc
class __$$CompleteCardModelImplCopyWithImpl<$Res>
    extends _$CompleteCardModelCopyWithImpl<$Res, _$CompleteCardModelImpl>
    implements _$$CompleteCardModelImplCopyWith<$Res> {
  __$$CompleteCardModelImplCopyWithImpl(_$CompleteCardModelImpl _value,
      $Res Function(_$CompleteCardModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompleteCardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
  }) {
    return _then(_$CompleteCardModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompleteCardModelImpl implements _CompleteCardModel {
  const _$CompleteCardModelImpl({required this.title, required this.message});

  factory _$CompleteCardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompleteCardModelImplFromJson(json);

  @override
  final String title;
  @override
  final String message;

  @override
  String toString() {
    return 'CompleteCardModel(title: $title, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompleteCardModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, message);

  /// Create a copy of CompleteCardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompleteCardModelImplCopyWith<_$CompleteCardModelImpl> get copyWith =>
      __$$CompleteCardModelImplCopyWithImpl<_$CompleteCardModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompleteCardModelImplToJson(
      this,
    );
  }
}

abstract class _CompleteCardModel implements CompleteCardModel {
  const factory _CompleteCardModel(
      {required final String title,
      required final String message}) = _$CompleteCardModelImpl;

  factory _CompleteCardModel.fromJson(Map<String, dynamic> json) =
      _$CompleteCardModelImpl.fromJson;

  @override
  String get title;
  @override
  String get message;

  /// Create a copy of CompleteCardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompleteCardModelImplCopyWith<_$CompleteCardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
