import 'package:flutter/material.dart';

import 'counter_bloc.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', key: UniqueKey(),),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    print("-----widget tree-----");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder(
                stream: counterBloc.counterStream,
                initialData: 0,
                builder: (context, snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: Wrap(
        spacing: 10,
        children: [
          FloatingActionButton(
            onPressed: () {
              counterBloc.counterEventSink.add(CounterActions.RESET);
            },
            tooltip: 'Reset',
            child: Icon(Icons.loop),
          ),
          FloatingActionButton(
            onPressed: () {
              counterBloc.counterEventSink.add(CounterActions.DECREMENT);
            },
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: () {
              counterBloc.counterEventSink.add(CounterActions.INCREMENT);
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          )
        ],
      ),
    );

  }

  @override
  void dispose() {
    counterBloc.dispose();
    super.dispose();

  }
}