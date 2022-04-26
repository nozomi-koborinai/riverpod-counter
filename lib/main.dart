import 'package:counter_riverpod/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) =>
                Text(ref.watch(titleProvider))),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer(
                builder: ((context, ref, child) =>
                    Text(ref.watch(messageProvider)))),
            Consumer(
                builder: ((context, ref, child) => Text(
                      ref.watch(countProvider.state).state.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    ))),
          ],
        ),
      ),
      floatingActionButton: Consumer(
        builder: ((context, ref, child) => FloatingActionButton(
              onPressed: () => ref.read(countProvider.state).state++,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            )),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
