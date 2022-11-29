import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/transformers.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
