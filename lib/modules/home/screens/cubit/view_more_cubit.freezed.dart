// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view_more_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ViewMoreState {
  AsyncState<List<FRestaurant>> get restaurants =>
      throw _privateConstructorUsedError;
  AsyncState<List<FFood>> get foods => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ViewMoreStateCopyWith<ViewMoreState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViewMoreStateCopyWith<$Res> {
  factory $ViewMoreStateCopyWith(
          ViewMoreState value, $Res Function(ViewMoreState) then) =
      _$ViewMoreStateCopyWithImpl<$Res, ViewMoreState>;
  @useResult
  $Res call(
      {AsyncState<List<FRestaurant>> restaurants,
      AsyncState<List<FFood>> foods});

  $AsyncStateCopyWith<List<FRestaurant>, $Res> get restaurants;
  $AsyncStateCopyWith<List<FFood>, $Res> get foods;
}

/// @nodoc
class _$ViewMoreStateCopyWithImpl<$Res, $Val extends ViewMoreState>
    implements $ViewMoreStateCopyWith<$Res> {
  _$ViewMoreStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restaurants = null,
    Object? foods = null,
  }) {
    return _then(_value.copyWith(
      restaurants: null == restaurants
          ? _value.restaurants
          : restaurants // ignore: cast_nullable_to_non_nullable
              as AsyncState<List<FRestaurant>>,
      foods: null == foods
          ? _value.foods
          : foods // ignore: cast_nullable_to_non_nullable
              as AsyncState<List<FFood>>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AsyncStateCopyWith<List<FRestaurant>, $Res> get restaurants {
    return $AsyncStateCopyWith<List<FRestaurant>, $Res>(_value.restaurants,
        (value) {
      return _then(_value.copyWith(restaurants: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AsyncStateCopyWith<List<FFood>, $Res> get foods {
    return $AsyncStateCopyWith<List<FFood>, $Res>(_value.foods, (value) {
      return _then(_value.copyWith(foods: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ViewMoreStateCopyWith<$Res>
    implements $ViewMoreStateCopyWith<$Res> {
  factory _$$_ViewMoreStateCopyWith(
          _$_ViewMoreState value, $Res Function(_$_ViewMoreState) then) =
      __$$_ViewMoreStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AsyncState<List<FRestaurant>> restaurants,
      AsyncState<List<FFood>> foods});

  @override
  $AsyncStateCopyWith<List<FRestaurant>, $Res> get restaurants;
  @override
  $AsyncStateCopyWith<List<FFood>, $Res> get foods;
}

/// @nodoc
class __$$_ViewMoreStateCopyWithImpl<$Res>
    extends _$ViewMoreStateCopyWithImpl<$Res, _$_ViewMoreState>
    implements _$$_ViewMoreStateCopyWith<$Res> {
  __$$_ViewMoreStateCopyWithImpl(
      _$_ViewMoreState _value, $Res Function(_$_ViewMoreState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restaurants = null,
    Object? foods = null,
  }) {
    return _then(_$_ViewMoreState(
      restaurants: null == restaurants
          ? _value.restaurants
          : restaurants // ignore: cast_nullable_to_non_nullable
              as AsyncState<List<FRestaurant>>,
      foods: null == foods
          ? _value.foods
          : foods // ignore: cast_nullable_to_non_nullable
              as AsyncState<List<FFood>>,
    ));
  }
}

/// @nodoc

class _$_ViewMoreState extends _ViewMoreState {
  const _$_ViewMoreState(
      {this.restaurants = const AsyncState.loading(),
      this.foods = const AsyncState.loading()})
      : super._();

  @override
  @JsonKey()
  final AsyncState<List<FRestaurant>> restaurants;
  @override
  @JsonKey()
  final AsyncState<List<FFood>> foods;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ViewMoreStateCopyWith<_$_ViewMoreState> get copyWith =>
      __$$_ViewMoreStateCopyWithImpl<_$_ViewMoreState>(this, _$identity);
}

abstract class _ViewMoreState extends ViewMoreState {
  const factory _ViewMoreState(
      {final AsyncState<List<FRestaurant>> restaurants,
      final AsyncState<List<FFood>> foods}) = _$_ViewMoreState;
  const _ViewMoreState._() : super._();

  @override
  AsyncState<List<FRestaurant>> get restaurants;
  @override
  AsyncState<List<FFood>> get foods;
  @override
  @JsonKey(ignore: true)
  _$$_ViewMoreStateCopyWith<_$_ViewMoreState> get copyWith =>
      throw _privateConstructorUsedError;
}
