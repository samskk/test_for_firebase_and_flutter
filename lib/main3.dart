// ignore_for_file: avoid_print

import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'common_components.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          //primarySwatch: Colors.blue,
          ),
      home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('yo have an error! ${snapshot.error.toString()}');
              return const Text("something went worng!");
            } else if (snapshot.hasData) {
              return const MyHomePage(title: 'Flutter Demo Home Page');
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseReference root=FirebaseDatabase.instance.reference();
  int _counter = 0;
  bool testing = true;
  final myController = TextEditingController();

  void _incrementCounter() {
    DatabaseReference _testRef =
        root.child("test/test");
    _testRef.set("Hello world ${Random().nextInt(100)}",);
    setState(() {
      _counter++;
      //_firedata = 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            
            const Icon(Icons.add),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
                helperText: '',
                hintText: 'sam',
                focusColor: Colors.red,
                fillColor: Colors.green,
                hoverColor: Colors.orange,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildSingleCheckbox(CheckboxState checkbox) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          checkbox.title,
          style: const TextStyle(fontSize: 20),
        ),
        activeColor: checkbox.activeColor,
        value: checkbox.value,
        onChanged: (value) => setState(() => checkbox.value = value!),
      );
}
