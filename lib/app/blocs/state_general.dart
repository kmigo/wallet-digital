// ignore_for_file: overridden_fields

import 'package:equatable/equatable.dart';

abstract class BaseState<T> extends Equatable {
  final T? data;
  const BaseState({this.data});
}


class StateSuccess<T> extends BaseState {
  @override
  final T? data;
  const StateSuccess({ this.data}):super(data: data);
  
  @override

  List<Object?> get props => [data];
}

class StateIdle extends BaseState {
  @override

  List<Object?> get props => [];
}

class StateLoading extends BaseState {
  @override
  List<Object?> get props => [];
}

class StateError extends BaseState {
  final String? message;
  const StateError({this.message});
  
  @override
  List<Object?> get props => [message];
}