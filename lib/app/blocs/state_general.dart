// ignore_for_file: overridden_fields

abstract class BaseState<T> {
  final T? data;
  BaseState({this.data});
}


class StateSuccess<T> extends BaseState {
  @override
  final T? data;
  StateSuccess({ this.data}):super(data: data);
}

class StateIdle extends BaseState {
}

class StateLoading extends BaseState {
}

class StateError extends BaseState {
  final String? message;
  StateError({this.message});
}