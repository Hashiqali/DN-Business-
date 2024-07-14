part of 'details_bloc.dart';

@immutable
sealed class DetailsEvent {}

class LocationBuilder extends DetailsEvent {}

class LoadingBuilder extends DetailsEvent {}

class SearchedDetails extends DetailsEvent {
final  List details;

  SearchedDetails({required this.details});
}
class AllDetails extends DetailsEvent {


  AllDetails();
}
