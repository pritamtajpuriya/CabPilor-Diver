part of 'application_bloc.dart';

abstract class ApplicationEvent extends Equatable {
  const ApplicationEvent();

  @override
  List<Object> get props => [];
}

class AppInitial extends ApplicationEvent {}

class SetupApplication extends ApplicationEvent {}
