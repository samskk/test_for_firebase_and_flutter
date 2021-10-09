import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:medical_erp/models/daily_special.dart';
import 'package:medical_erp/models/order.dart';
import 'package:medical_erp/models/order_stream_publisher.dart';

class ReadExamples extends StatelessWidget {
  ReadExamples({Key? key}) : super(key: key);

//   @override
//   _ReadExamplesState createState() => _ReadExamplesState();
// }

// class _ReadExamplesState extends State<ReadExamples> {
  // String _displayText = 'Results go here';
  // String _displayTextOnce = 'Results go here single fetch only';

  final _database = FirebaseDatabase.instance.reference();
  //late StreamSubscription _dailySpecialStream;

  //   super.initState();
  // _activateListeners();
  // _performSinleFetch();
  //}

  // void _performSinleFetch() {
  //   _database.child('dailySpecial').get().then((snapshot) {
  //     final data = Map<String, dynamic>.from(snapshot.value);
  //     final dailySpecial = DailySpecial.fromRTDB(data);
  //     setState(() {
  //       _displayTextOnce = dailySpecial.fancyDescription();
  //     });
  //   });
  // }

  // void _activateListeners() {
  //   _dailySpecialStream =
  //       _database.child("dailySpecial").onValue.listen((event) {
  //     final data = Map<String, dynamic>.from(event.snapshot.value);
  //     final dailySpecial = DailySpecial.fromRTDB(data);
  //     setState(() {
  //       _displayText = dailySpecial.fancyDescription();
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read examples'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              StreamBuilder(
                  stream: _database.child('dailySpecial').onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final dailySpecial = DailySpecial.fromRTDB(
                          Map<String, dynamic>.from(
                              (snapshot.data! as Event).snapshot.value));
                      return Text(
                        dailySpecial.fancyDescription(),
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              // Text(
              //   _displayText,
              //   style: const TextStyle(
              //       fontSize: 18.0, fontWeight: FontWeight.w600),
              //   textAlign: TextAlign.center,
              // ),
              // Text(
              //   _displayTextOnce,
              //   style: const TextStyle(
              //       fontSize: 18.0, fontWeight: FontWeight.w600),
              //   textAlign: TextAlign.center,
              // ),
              const SizedBox(
                height: 50,
              ),
              StreamBuilder(
                stream: OrderStreamPblisher().getOrderSteram(),
                builder: (context, snapshot) {
                  final tilesList = <ListTile>[];
                  if (snapshot.hasData) {
                    final myOrders = snapshot.data as List<Order>;
                    tilesList.addAll(
                      myOrders.map((nextOrder) {
                        return ListTile(
                            leading: const Icon(Icons.local_cafe),
                            title: Text(nextOrder.description),
                            subtitle: Text(nextOrder.customerName));
                      }),
                    );
                  }
                  return Expanded(
                    child: ListView(
                      children: tilesList,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // void deactivate() {
  //   // _dailySpecialStream.cancel();
  //   super.deactivate();
  // }
}
