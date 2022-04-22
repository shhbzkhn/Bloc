import 'dart:async';

enum CounterActions { INCREMENT, DECREMENT, RESET }

class CounterBloc {
  int _counter = 0;
  final _stateStreamController = StreamController<int>();

  StreamSink<int> get counterSink => _stateStreamController.sink;

  Stream<int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterActions>();

  StreamSink<CounterActions> get counterEventSink =>
      _eventStreamController.sink;

  Stream<CounterActions> get counterEventStream =>
      _eventStreamController.stream;

  CounterBloc() {
    counterEventStream.listen((event) {
      if (event == CounterActions.INCREMENT)
        _counter++;
      else if (event == CounterActions.DECREMENT)
        _counter--;
      else
        _counter = 0;

      counterSink.add(_counter);

    });
  }

  dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }




}