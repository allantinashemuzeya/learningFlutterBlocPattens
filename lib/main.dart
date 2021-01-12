import 'package:flutter/material.dart';
import 'package:flutter_bloc_patterns/counter_bloc.dart';

import 'counter_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('You have pushed the button this many times'),
          StreamBuilder(
              stream: _counterBloc.counterStream,
              initialData: 0,
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.headline4,
                );
              })
        ],
      )),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        FloatingActionButton(
          onPressed: () => {
            _counterBloc.eventSink.add(CounterAction.Reset),
          },
          tooltip: 'Reset',
          child: Icon(Icons.loop),
        ),
        SizedBox(width: 10),
        FloatingActionButton(
          onPressed: () => {
            _counterBloc.eventSink.add(CounterAction.Decrement),
          },
          tooltip: 'Decrement',
          child: Icon(Icons.remove),
        ),
        SizedBox(width: 10),
        FloatingActionButton(
          onPressed: () => {
            _counterBloc.eventSink.add(CounterAction.Increment),
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        SizedBox(width: 10),
        // FloatingActionButton(
        // onPressed: () => _bloc.counterEventSink.add(DecrementEvent()),
        // tooltip: 'Decrement',
        // child: Icon(Icons.remove),
        // ),
      ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
