part of 'details_bloc.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {}

class LocationBuilderState extends DetailsState {}

class LoadingBuilderState extends DetailsState {}

class SearchedDetailsState extends DetailsState {
  final List details;

  SearchedDetailsState({required this.details});
}

class AllDetailsState extends DetailsState {
  AllDetailsState();
}

class LoadingWidgetState extends DetailsState {}

class NoNetwoekEventState extends DetailsState {
  final bool istrue;

  NoNetwoekEventState({required this.istrue});
}

class LoginLoadingEventState extends DetailsState {
  final bool istrue;

  LoginLoadingEventState({required this.istrue});
}

class FilteredDetailsState extends DetailsState {
  final List details;

  FilteredDetailsState({required this.details});
}