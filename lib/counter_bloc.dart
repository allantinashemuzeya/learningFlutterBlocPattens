// import 'dart:async';
//
// import 'package:flutter_bloc_patterns/counter_event.dart';
//
// //Bloc stands for Business Logic Component
// // this means that the business logic of the App should be separate from the UI
// // Bloc is used for state management.
//
// class CounterBloc {
//   int _counter = 0;
//
//   final _counterStateController = StreamController<int>();
//
//   StreamSink<int> get _inCounter => _counterStateController.sink;
//
// //  For state, exposing only a stream which outputs data
//   Stream<int> get counter => _counterStateController.stream;
//
//   final _counterEventController = StreamController<CounterEvent>();
//   // Fore events, exposing only a sink which is an input
//   Sink<CounterEvent> get counterEventSink => _counterEventController.sink;
//
//   CounterBloc(){
//     // Whenever there is a new event, we want to map it to a new state
//     _counterEventController.stream.listen(_mapEventToState);
//   }
//
//   void _mapEventToState(CounterEvent event){
//     if (event is IncrementEvent)
//       _counter++;
//     else
//       _counter--;
//
//     _inCounter.add(_counter);
//   }
//
//   void dispose(){
//     _counterStateController.close();
//     _counterEventController.close();
//   }
// }

import 'dart:async';

enum CounterAction{
  Increment,
  Decrement,
  Reset,
  NoEvent,
}

class CounterBloc {


int _counter = 0;
//  What goes in is called a SINK (input)
// What comes out is called Stream (State Stream Controller)

  final _stateStreamController = StreamController<int>.broadcast();

  StreamSink<int> get counterSink => _stateStreamController.sink; // input
  Stream<int> get counterStream => _stateStreamController.stream; // output

  final _eventStreamController = StreamController<CounterAction>.broadcast();

  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  Stream<CounterAction> get eventStream => _eventStreamController.stream;

  CounterBloc(){
    eventStream.listen((event)=>{
      if(event == CounterAction.Increment) _counter++
      else if(event == CounterAction.Decrement) _counter--
      else if(event == CounterAction.Reset) _counter = 0,

      counterSink.add(_counter)
    });
  }

  // Should always close streams to avoid memory leaks.
  void dispose(){
    _stateStreamController.close();
    _eventStreamController.close();
  }

}
