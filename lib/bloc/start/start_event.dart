part of 'bloc.dart';

abstract class StartEvent {}


/// _LoadEvent - это событие будет вызываться внутри StartBloc, и "из вне" оно вызываться не должно, по этому будет приватным
class _LoadEvent extends StartEvent {
  final int percentLoad;

  _LoadEvent({@required this.percentLoad});
}

class _CompleteStartEvent extends StartEvent {}

/// Пусть это событие будет публичным, т.е. может вызваться вне блока
class SetStartEvent extends StartEvent {
  final String text;

  SetStartEvent({this.text});
}