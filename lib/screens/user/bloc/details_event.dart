part of 'details_bloc.dart';

@immutable
sealed class DetailsEvent {}

class LocationBuilder extends DetailsEvent {}

class LoadingBuilder extends DetailsEvent {}

class SearchedDetails extends DetailsEvent {
  final List details;

  SearchedDetails({required this.details});
}

class AllDetails extends DetailsEvent {
  AllDetails();
}

class NoNetwoekEvent extends DetailsEvent {
  final bool istrue;

  NoNetwoekEvent({required this.istrue});
}

class LoadingWidgetEvent extends DetailsEvent {
  final BuildContext context;
  final id;
  LoadingWidgetEvent({required this.context, required this.id});
}
class LoginLoadingEvent extends DetailsEvent {

  final bool istrue;

  LoginLoadingEvent({required this.istrue});

}