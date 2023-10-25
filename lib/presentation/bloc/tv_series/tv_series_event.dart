import 'package:equatable/equatable.dart';

abstract class TVSeriesEvent extends Equatable {
  const TVSeriesEvent();

  @override
  List<Object> get props => [];
}

class OnTVSeriesChanged extends TVSeriesEvent {
  @override
  List<Object> get props => [];
}