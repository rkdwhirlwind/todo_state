import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

Stream<Event> appEventTransformer<Event>(
  Stream<Event> events,
EventMapper<Event> mapper,
){
  debugPrint('appEventTransformer');
  return events;
}