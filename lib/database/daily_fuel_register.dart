import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DailyFuelRegsiter {
  final db = FirebaseFirestore.instance.collection("daily_fuel_register");
  getAllDoc() async {
    // QuerySnapshot querySnapshot = await db.get();
    // List<DocumentSnapshot> documentSnapshots = querySnapshot.docs;
    Stream<QuerySnapshot> stream = db.snapshots();
    // return documentSnapshots;
    return stream;
  }

// get the previous date sales
  getFuelDB() async {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));
    String date = yesterday.toString().substring(0, 10);
    var x = await db.doc(date).get();
    return x.data();
  }

  getTodaySales() async {
    DateTime now = DateTime.now();
    String date = now.toString().substring(0, 10);
    var x = await db.doc(date).get();
    return x.data();
  }

  addFuelD(
      int diesel_amount,
      int diesel_sold_in_lit,
      int grand_total,
      int oil_sold_amt,
      int oil_sold_in_lit,
      int petrol_sold_amt,
      int petrol_sold_in_lit,
      int petrol_rate,
      int diesel_rate,
      int oil_rate) async {
    DateTime dateToday = new DateTime.now();
    String date = dateToday.toString().substring(0, 10);
    log(grand_total.toString());
    await db.doc(date).set({
      "date": date,
      "diesel_sold_amt": diesel_amount,
      "diesel_sold_in_lit": diesel_sold_in_lit,
      "grand_total": grand_total,
      "oil_sold_amt": oil_sold_amt,
      "oil_sold_in_lit": oil_sold_in_lit,
      "petrol_sold_amt": petrol_sold_amt,
      "petrol_sold_in_lit": petrol_sold_in_lit
    });
  }

  updateDailyFuelRegister(
      int diesel_amount,
      int diesel_sold_in_lit,
      int grand_total,
      int oil_sold_amt,
      int oil_sold_in_lit,
      int petrol_sold_amt,
      int petrol_sold_in_lit) async {
    await db.doc("10-5-23").set({
      "diesel_sold_amt": diesel_amount,
      "diesel_sold_in_lit": diesel_sold_in_lit,
      "grand_total": grand_total,
      "oil_sold_amt": oil_sold_amt,
      "oil_sold_in_lit": oil_sold_in_lit,
      "petrol_sold_amt": petrol_sold_amt,
      "petrol_sold_in_lit": petrol_sold_in_lit
    });
  }
}
