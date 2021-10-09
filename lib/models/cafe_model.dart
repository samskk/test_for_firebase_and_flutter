import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:medical_erp/models/daily_special.dart';
import 'package:medical_erp/models/order.dart';

class CafeModel extends ChangeNotifier {
  DailySpecial? _dailySpecial;
  List<Order> _order = [];
  final _db = FirebaseDatabase.instance.reference();

  static const dailySpecialPath = 'dailySpecial';
  static const orderPath = 'orders';

  late StreamSubscription<Event> _dailySpecialStream;

  late StreamSubscription<Event> _orderStream;

  DailySpecial? get dailySpecial => _dailySpecial;
  List<Order> get order => _order;
  CafeModel() {
    _listenToDailySpecial();
    _listenToOrder();
  }
  void _listenToDailySpecial() {
    _dailySpecialStream = _db.child(dailySpecialPath).onValue.listen((event) {
      _dailySpecial = DailySpecial.fromRTDB(
          Map<String, dynamic>.from(event.snapshot.value));
      notifyListeners();
    });
  }

  void _listenToOrder() {
    _orderStream = _db.child(orderPath).onValue.listen((event) {
      final allOrders = Map<String, dynamic>.from(event.snapshot.value);
      _order = allOrders.values
          .map((orderAsJSON) =>
              Order.fromRTDB(Map<String, dynamic>.from(orderAsJSON)))
          .toList();
      notifyListeners();
    });
  }

  repriceDailySecial() {
    final newPrice = Random().nextInt(1000) / 100.0;
    _db.child(dailySpecialPath).update({'price': newPrice});
  }

  @override
  void dispose() {
    _orderStream.cancel();
    _dailySpecialStream.cancel();
    super.dispose();
  }
}
