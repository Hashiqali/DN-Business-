import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<AddExicutiveLoading>(addExicutiveLoadingState);
    on<AdminNoNetworkEvent>(adminNoNetworkEvent);
    on<AdminDeleteLoading>(adminDeleteLoading);
  }

  FutureOr<void> addExicutiveLoadingState(
      AddExicutiveLoading event, Emitter<AdminState> emit) async {
    emit(AddExicutiveLoadingState(istrue: true));
    await Future.delayed(const Duration(milliseconds: 1500));
    emit(AddExicutiveLoadingState(istrue: false));
  }

  FutureOr<void> adminNoNetworkEvent(
      AdminNoNetworkEvent event, Emitter<AdminState> emit) async {
    emit(AdminNoNetworkEventState(istrue: true));
    await Future.delayed(const Duration(seconds: 2));
    emit(AdminNoNetworkEventState(istrue: false));
  }

  FutureOr<void> adminDeleteLoading(
      AdminDeleteLoading event, Emitter<AdminState> emit) async {
    emit(AdminDeleteLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(AllExixutiveDetailsState());
  }
}
