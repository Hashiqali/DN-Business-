part of 'admin_bloc.dart';

@immutable
sealed class AdminEvent {}

class AddExicutiveLoading extends AdminEvent {}

class AdminNoNetworkEvent extends AdminEvent {}
class AdminDeleteLoading extends AdminEvent {}

