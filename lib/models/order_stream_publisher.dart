import 'package:firebase_database/firebase_database.dart';
import 'package:medical_erp/models/order.dart';

class OrderStreamPblisher {
  final _database = FirebaseDatabase.instance.reference();
  Stream<List<Order>> getOrderSteram() {
    final orderStream = _database.child('orders').onValue;
    final streamToPublish = orderStream.map((event) {
      final orderMap = Map<String, dynamic>.from(event.snapshot.value);
      final orderList = orderMap.entries.map((element) {
        return Order.fromRTDB(Map<String, dynamic>.from(element.value));
      }).toList();
      return orderList;
    });
    return streamToPublish;
  }
}
