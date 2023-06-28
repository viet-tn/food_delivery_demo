// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FNotification _$FNotificationFromJson(Map<String, dynamic> json) {
  return _FNotification.fromJson(json);
}

/// @nodoc
mixin _$FNotification {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get orderId => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get created => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FNotificationCopyWith<FNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FNotificationCopyWith<$Res> {
  factory $FNotificationCopyWith(
          FNotification value, $Res Function(FNotification) then) =
      _$FNotificationCopyWithImpl<$Res, FNotification>;
  @useResult
  $Res call(
      {String? id,
      String title,
      String body,
      String uid,
      String orderId,
      @TimestampConverter() DateTime created});
}

/// @nodoc
class _$FNotificationCopyWithImpl<$Res, $Val extends FNotification>
    implements $FNotificationCopyWith<$Res> {
  _$FNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? body = null,
    Object? uid = null,
    Object? orderId = null,
    Object? created = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FNotificationCopyWith<$Res>
    implements $FNotificationCopyWith<$Res> {
  factory _$$_FNotificationCopyWith(
          _$_FNotification value, $Res Function(_$_FNotification) then) =
      __$$_FNotificationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String title,
      String body,
      String uid,
      String orderId,
      @TimestampConverter() DateTime created});
}

/// @nodoc
class __$$_FNotificationCopyWithImpl<$Res>
    extends _$FNotificationCopyWithImpl<$Res, _$_FNotification>
    implements _$$_FNotificationCopyWith<$Res> {
  __$$_FNotificationCopyWithImpl(
      _$_FNotification _value, $Res Function(_$_FNotification) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? body = null,
    Object? uid = null,
    Object? orderId = null,
    Object? created = null,
  }) {
    return _then(_$_FNotification(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FNotification extends _FNotification {
  const _$_FNotification(
      {this.id,
      required this.title,
      required this.body,
      required this.uid,
      required this.orderId,
      @TimestampConverter() required this.created})
      : super._();

  factory _$_FNotification.fromJson(Map<String, dynamic> json) =>
      _$$_FNotificationFromJson(json);

  @override
  final String? id;
  @override
  final String title;
  @override
  final String body;
  @override
  final String uid;
  @override
  final String orderId;
  @override
  @TimestampConverter()
  final DateTime created;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FNotificationCopyWith<_$_FNotification> get copyWith =>
      __$$_FNotificationCopyWithImpl<_$_FNotification>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FNotificationToJson(
      this,
    );
  }
}

abstract class _FNotification extends FNotification {
  const factory _FNotification(
          {final String? id,
          required final String title,
          required final String body,
          required final String uid,
          required final String orderId,
          @TimestampConverter() required final DateTime created}) =
      _$_FNotification;
  const _FNotification._() : super._();

  factory _FNotification.fromJson(Map<String, dynamic> json) =
      _$_FNotification.fromJson;

  @override
  String? get id;
  @override
  String get title;
  @override
  String get body;
  @override
  String get uid;
  @override
  String get orderId;
  @override
  @TimestampConverter()
  DateTime get created;
  @override
  @JsonKey(ignore: true)
  _$$_FNotificationCopyWith<_$_FNotification> get copyWith =>
      throw _privateConstructorUsedError;
}
