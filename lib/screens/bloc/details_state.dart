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
