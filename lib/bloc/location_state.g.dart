// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_state.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class LocationState<T> extends Equatable {
  const LocationState(this._type);

  factory LocationState.stoped() = Stoped<T>;

  factory LocationState.sendData({@required T location}) = SendData<T>;

  factory LocationState.error({@required String info, @required T results}) =
      Error<T>;

  final _LocationState _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(Stoped<T>) stoped,
      @required R Function(SendData<T>) sendData,
      @required R Function(Error<T>) error}) {
    assert(() {
      if (stoped == null || sendData == null || error == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _LocationState.Stoped:
        return stoped(this as Stoped);
      case _LocationState.SendData:
        return sendData(this as SendData);
      case _LocationState.Error:
        return error(this as Error);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(Stoped<T>) stoped,
      @required FutureOr<R> Function(SendData<T>) sendData,
      @required FutureOr<R> Function(Error<T>) error}) {
    assert(() {
      if (stoped == null || sendData == null || error == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _LocationState.Stoped:
        return stoped(this as Stoped);
      case _LocationState.SendData:
        return sendData(this as SendData);
      case _LocationState.Error:
        return error(this as Error);
    }
  }

  R whenOrElse<R>(
      {R Function(Stoped<T>) stoped,
      R Function(SendData<T>) sendData,
      R Function(Error<T>) error,
      @required R Function(LocationState<T>) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _LocationState.Stoped:
        if (stoped == null) break;
        return stoped(this as Stoped);
      case _LocationState.SendData:
        if (sendData == null) break;
        return sendData(this as SendData);
      case _LocationState.Error:
        if (error == null) break;
        return error(this as Error);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(Stoped<T>) stoped,
      FutureOr<R> Function(SendData<T>) sendData,
      FutureOr<R> Function(Error<T>) error,
      @required FutureOr<R> Function(LocationState<T>) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _LocationState.Stoped:
        if (stoped == null) break;
        return stoped(this as Stoped);
      case _LocationState.SendData:
        if (sendData == null) break;
        return sendData(this as SendData);
      case _LocationState.Error:
        if (error == null) break;
        return error(this as Error);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(Stoped<T>) stoped,
      FutureOr<void> Function(SendData<T>) sendData,
      FutureOr<void> Function(Error<T>) error}) {
    assert(() {
      if (stoped == null && sendData == null && error == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _LocationState.Stoped:
        if (stoped == null) break;
        return stoped(this as Stoped);
      case _LocationState.SendData:
        if (sendData == null) break;
        return sendData(this as SendData);
      case _LocationState.Error:
        if (error == null) break;
        return error(this as Error);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Stoped<T> extends LocationState<T> {
  const Stoped._() : super(_LocationState.Stoped);

  factory Stoped() {
    _instance ??= const Stoped._();
    return _instance;
  }

  static Stoped _instance;
}

@immutable
class SendData<T> extends LocationState<T> {
  const SendData({@required this.location}) : super(_LocationState.SendData);

  final T location;

  @override
  String toString() => 'SendData(location:${this.location})';
  @override
  List get props => [location];
}

@immutable
class Error<T> extends LocationState<T> {
  const Error({@required this.info, @required this.results})
      : super(_LocationState.Error);

  final String info;

  final T results;

  @override
  String toString() => 'Error(info:${this.info},results:${this.results})';
  @override
  List get props => [info, results];
}
