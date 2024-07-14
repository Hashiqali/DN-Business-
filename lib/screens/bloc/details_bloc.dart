import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<LocationBuilder>(locationBuilder);
    on<LoadingBuilder>(loadingBuilder);
    on<SearchedDetails>(searchedDetails);
    on<AllDetails>(allDetails);
  }

  FutureOr<void> locationBuilder(
      LocationBuilder event, Emitter<DetailsState> emit) {
    emit(LocationBuilderState());
  }

  FutureOr<void> loadingBuilder(
      LoadingBuilder event, Emitter<DetailsState> emit) {
    emit(LoadingBuilderState());
  }

  FutureOr<void> searchedDetails(
      SearchedDetails event, Emitter<DetailsState> emit) {
    emit(SearchedDetailsState(details: event.details));
  }

  FutureOr<void> allDetails(AllDetails event, Emitter<DetailsState> emit) {
    emit(AllDetailsState());
  }
}
