import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<LocationBuilder>(locationBuilder);
    on<LoadingBuilder>(loadingBuilder);
    on<SearchedDetails>(searchedDetails);
    on<AllDetails>(allDetails);
    on<LoadingWidgetEvent>(loadingWidgetEvent);
    on<NoNetwoekEvent>(noNetwoekEvent);
    on<LoginLoadingEvent>(loginLoadingEvent);
    on<FilteredDetails>(filteredDetails);
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

  FutureOr<void> loadingWidgetEvent(
      LoadingWidgetEvent event, Emitter<DetailsState> emit) async {
    emit(LoadingWidgetState());
    await Future.delayed(const Duration(seconds: 2));
    emit(AllDetailsState());
  }

  FutureOr<void> noNetwoekEvent(
      NoNetwoekEvent event, Emitter<DetailsState> emit) async {
    emit(NoNetwoekEventState(istrue: true));
    await Future.delayed(const Duration(seconds: 2));
    emit(NoNetwoekEventState(istrue: false));
  }

  FutureOr<void> loginLoadingEvent(
      LoginLoadingEvent event, Emitter<DetailsState> emit) async {
    emit(LoginLoadingEventState(istrue: true));
    await Future.delayed(const Duration(seconds: 2));
    emit(LoginLoadingEventState(istrue: false));
  }

  FutureOr<void> filteredDetails(
      FilteredDetails event, Emitter<DetailsState> emit) {
    print(event.details);
    emit(FilteredDetailsState(details: event.details));
  }
}
