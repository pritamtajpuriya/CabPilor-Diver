import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/di/locator.dart';
import '../auth/auth_bloc.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(ApplicationInitial()) {
    on<SetupApplication>(_applicationSetup);
  }

  _applicationSetup(SetupApplication event, Emitter<ApplicationState> emit) {
    getInstance<AuthBloc>().add((AuthCheck()));

    emit(ApplicationCompleted());
    // print state to console
  }

  void startApplication() {}
}
