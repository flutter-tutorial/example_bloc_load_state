part of 'bloc.dart';

/// StartState - базовое, абстрактное состояние StartBloc
/// Все последующие состояния должны быть унаследованы от него
abstract class StartState {}

/// LoadStartState - состояние загрузки
class LoadStartState extends StartState {
  final int percentLoad;/// Все параметры состояния должны быть неизменяемыми, т.е. final и определены в конструкторе

  ///@required - эта аннотация помогает укзать на то что данный параметр должен быть обязательно определен при создании этого состояния.
  LoadStartState({@required this.percentLoad});
}

/// Состояние после загрузки
class CompleteStartState extends StartState {}

/// Состояние по нажатию на кнопку
class SetStartState extends StartState {
  final String text;

  SetStartState({this.text});
}