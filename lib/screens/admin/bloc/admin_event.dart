part of 'admin_bloc.dart';

@immutable
sealed class AdminEvent {}

class AddExicutiveLoading extends AdminEvent {}

class AdminNoNetworkEvent extends AdminEvent {}

class AdminDeleteLoading extends AdminEvent {}

class AdminTabChanger extends AdminEvent {}

class FilterDatas extends AdminEvent {
  final List details;
  final DateTime datetime;

  FilterDatas({required this.datetime, required this.details});
}

class ClearDetails extends AdminEvent {}
