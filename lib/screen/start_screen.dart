import '../bloc/start/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      /// create: оздаем блок StartBloc
      create: (_) => StartBloc(),
      /// BlocBuilder - позволяет связать нас с нужным блоком, и выводить виджеты в зависимости от текущего сотояния блока
      /// здесь должны быть чистые функции, т.е. при одинаковом состоянии блока должен быть один и тот же результат
      /// <StartBloc, StartState> - такая конструкция указывает какой блок ищется по контексту
      child: BlocBuilder<StartBloc, StartState>(
      /// builder: обязателен для построения виджета
      /// будет вызывать перестроение при создании нового state блока StartBloc
      builder: (BuildContext context, StartState state) {
        if (state is LoadStartState) {
          /// выше мы явно определили что текущее состояние LoadStartState - это значит что для этого состояния
          /// мы можем получить значение percentLoad и вывести нужный виджет
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(
                  value: state.percentLoad > 0 ? state.percentLoad / 100 : null,
                ),
              ),
              Text('Loaded: ${state.percentLoad}%'),
            ],
          );
        } else if (state is CompleteStartState) {
          /// Состояние CompleteStartState - это состояние после загрузки
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('App is loaded, state is CompleteStartState, set state and text:'),
              Center(child: FlatButton(
                child: Text('set bloc state'),
                color: Colors.blue,
                onPressed: () {
                  /// Здесь блок StartBloc ищется по контексту, и ему передается событие SetStartEvent
                  BlocProvider.of<StartBloc>(context).add(SetStartEvent(text: 'new state and new text'));
                },
              ),),
            ],
          );
        } else if (state is SetStartState) {
          return Center(
            child: Text('State is SetStartState, text: ${state.text}'),
          );
        } else {
          /// Каких либо других состояний для StartBloc кроме тех что есть выше не предусмотренно, но мы обязаны
          /// таким или другим явным способом вернуть виджет а не null
          return Container(
            child: Text('Error state StartBloc undefined.'),
          );
        }
      },
    ),);
  }
}
