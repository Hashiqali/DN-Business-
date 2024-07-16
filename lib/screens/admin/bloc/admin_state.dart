part of 'admin_bloc.dart';

@immutable
sealed class AdminState {}

final class AdminInitial extends AdminState {}

class AddExicutiveLoadingState extends AdminState {
 
 final bool istrue;
  AddExicutiveLoadingState({required this.istrue});
}

class AdminNoNetworkEventState extends AdminState {
 final bool istrue;

  AdminNoNetworkEventState({required this.istrue});
}
class AdminDeleteLoadingState extends AdminState{}

class AllExixutiveDetailsState extends AdminState {}