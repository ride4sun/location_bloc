// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class LocationEvent<T> extends Equatable {
  const LocationEvent(this._type);

  factory LocationEvent.setUnitSystem({@required T unitSystem}) =
      SetUnitSystem<T>;

  factory LocationEvent.start() = Start<T>;

  factory LocationEvent.stop() = Stop<T>;

  final _LocationEvent _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(SetUnitSystem<T>) setUnitSystem,
      @required R Function(Start<T>) start,
      @required R Function(Stop<T>) stop}) {
    assert(() {
      if (setUnitSystem == null || start == null || stop == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _LocationEvent.SetUnitSystem:
        return setUnitSystem(this as SetUnitSystem);
      case _LocationEvent.Start:
        return start(this as Start);
      case _LocationEvent.Stop:
        return stop(this as Stop);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(SetUnitSystem<T>) setUnitSystem,
      @required FutureOr<R> Function(Start<T>) start,
      @required FutureOr<R> Function(Stop<T>) stop}) {
    assert(() {
      if (setUnitSystem == null || start == null || stop == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _LocationEvent.SetUnitSystem:
        return setUnitSystem(this as SetUnitSystem);
      case _LocationEvent.Start:
        return start(this as Start);
      case _LocationEvent.Stop:
        return stop(this as Stop);
    }
  }

  R whenOrElse<R>(
      {R Function(SetUnitSystem<T>) setUnitSystem,
      R Function(Start<T>) start,
      R Function(Stop<T>) stop,
      @required R Function(LocationEvent<T>) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _LocationEvent.SetUnitSystem:
        if (setUnitSystem == null) break;
        return setUnitSystem(this as SetUnitSystem);
      case _LocationEvent.Start:
        if (start == null) break;
        return start(this as Start);
      case _LocationEvent.Stop:
        if (stop == null) break;
        return stop(this as Stop);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(SetUnitSystem<T>) setUnitSystem,
      FutureOr<R> Function(Start<T>) start,
      FutureOr<R> Function(Stop<T>) stop,
      @required FutureOr<R> Function(LocationEvent<T>) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _LocationEvent.SetUnitSystem:
        if (setUnitSystem == null) break;
        return setUnitSystem(this as SetUnitSystem);
      case _LocationEvent.Start:
        if (start == null) break;
        return start(this as Start);
      case _LocationEvent.Stop:
        if (stop == null) break;
        return stop(this as Stop);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(SetUnitSystem<T>) setUnitSystem,
      FutureOr<void> Function(Start<T>) start,
      FutureOr<void> Function(Stop<T>) stop}) {
    assert(() {
      if (setUnitSystem == null && start == null && stop == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _LocationEvent.SetUnitSystem:
        if (setUnitSystem == null) break;
        return setUnitSystem(this as SetUnitSystem);
      case _LocationEvent.Start:
        if (start == null) break;
        return start(this as Start);
      case _LocationEvent.Stop:
        if (stop == null) break;
        return stop(this as Stop);
    }
  }

  @override
  List get props => const [];
}

@immutable
class SetUnitSystem<T> extends LocationEvent<T> {
  const SetUnitSystem({@required this.unitSystem})
      : super(_LocationEvent.SetUnitSystem);

  final T unitSystem;

  @override
  String toString() => 'SetUnitSystem(unitSystem:${this.unitSystem})';
  @override
  List get props => [unitSystem];
}

@immutable
class Start<T> extends LocationEvent<T> {
  const Start._() : super(_LocationEvent.Start);

  factory Start() {
    _instance ??= const Start._();
    return _instance;
  }

  static Start _instance;
}

@immutable
class Stop<T> extends LocationEvent<T> {
  const Stop._() : super(_LocationEvent.Stop);

  factory Stop() {
    _instance ??= const Stop._();
    return _instance;
  }

  static Stop _instance;
}
