part of 'bloc.dart';

/// StartBloc - это наш "управляющий" блок.
/// Для него должны быть определены: события StartEvent и состнояния StartState.

class StartBloc extends Bloc<StartEvent, StartState> {
  /// При использовании шаблона из библиотеки bloc необходимо переопределить: initialState и mapEventToState.
  /// initialState - тут мы задаем базовое состояние блока, с которым он будет создан.
  @override
  StartState get initialState => LoadStartState(percentLoad: 0);

  /// В конструкторе блока инициализируем событие начала загрузки
  StartBloc() {
    add(_LoadEvent(percentLoad: 0));
  }

  /// mapEventToState - обрабатывает входящие событие и при необходимости меняет состоняие блока
  @override
  Stream<StartState> mapEventToState(StartEvent event) async* {
    if (event is _LoadEvent) {
      /// Если загрузка не завершена
      if (event.percentLoad < 100) {
        /// Вызовим событие с задержкой в 1 секунду для обновления состояния
        Future.delayed(const Duration(seconds: 1)).then((_){
          add(_LoadEvent(percentLoad: event.percentLoad + 10));
        });

        /// Тут мы создаем новое состояние для блока StartBloc
        yield LoadStartState(percentLoad: event.percentLoad);
      } else {
        /// Но если загрузка завершена, то мы запустим событие CompleteStartEvent,
        /// которое в свою очередь поменяет состояние на CompleteStartState
        add(_CompleteStartEvent());
      }
    } else if (event is _CompleteStartEvent) {
      yield CompleteStartState();
    } else if (event is SetStartEvent) {
      print('new event SetStartEvent, $event');
      yield SetStartState(text: event.text);
    }
  }
}
