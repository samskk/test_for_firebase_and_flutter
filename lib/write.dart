// ignore_for_file: avoid_print

import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WriteExamples extends StatefulWidget {
  const WriteExamples({Key? key}) : super(key: key);

  @override
  _WriteExamplesState createState() => _WriteExamplesState();
}

class _WriteExamplesState extends State<WriteExamples> {
  final database = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    final dailyspecialRef = database.child('/dailySpecial');
    return Scaffold(
      appBar: AppBar(
        title: const Text('wirte examples'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    dailyspecialRef
                        .set({'description': 'vanilla latte', 'price': 4.9})
                        .then((_) => print("Special of day has been written"))
                        .catchError((error) => print('you got an error'));
                  },
                  child: const Text('simple set')),
              ElevatedButton(
                  onPressed: () async {
                    await dailyspecialRef.set({
                      'description': 'vanilla latte',
                      'price': 5.0
                    }).catchError((error) => print('you got an error'));
                    print("Special of day has been written");
                  },
                  child: const Text('simple set with await')),
              ElevatedButton(
                  onPressed: () async {
                    await dailyspecialRef
                        .update({'inentory': 99, 'price': 5.0}).catchError(
                            (error) => print('you got an error'));
                    print("Special of day has been written");
                  },
                  child: const Text('simple set with await with update')),
              ElevatedButton(
                  // ignore: duplicate_ignore
                  onPressed: () async {
                    try {
                      await database.update({
                        'dailySpecial/price': 99.0,
                        'someOtherSpecial/price': 5.0
                      });
                    } on Exception catch (e) {
                      print('you got an error$e');
                    }
                  },
                  child: const Text('multipath update')),
              ElevatedButton(
                  onPressed: () {
                    final nextOrder = <String, dynamic>{
                      'description': getRandomDrink(),
                      'price': Random().nextInt(800) / 100.0,
                      'customer': getRandomName(),
                      'time': DateTime.now().microsecondsSinceEpoch,
                    };
                    database
                        .child('orders')
                        .push()
                        .set(nextOrder)
                        .then((_) => print('Drink has been written!'))
                        .catchError(
                            (error) => print('you got an error $error'));
                  },
                  child: const Text('Append a drink order'))
            ],
          ),
        ),
      ),
    );
  }
}

String getRandomDrink() {
  final drinkList = [
    'latte',
    'cappuccino',
    'macchiato',
    'cortado',
    'Mocha',
    'drip coffee',
    'cold brew',
    'Espresso',
    'Vanilla latte',
    'Unicorn froppe',
  ];
  return drinkList[Random().nextInt(drinkList.length)];
}

String getRandomName() {
  final customerName = [
    'Sam',
    'Arthur',
    'Jeessia',
    'Rachel',
    'Vivian',
    'Todd',
    'Morgan',
    'Peter',
    'David',
    'Sumit',
  ];
  return customerName[Random().nextInt(customerName.length)];
}
