import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class TodayPriceDB {
    final db = FirebaseFirestore.instance.collection("today_price");

    getDataFromDB() async{
      var x = await db.doc("VFn16suseaxD613OOg18").get();
      return x.data();
    }

    updateFuelPrice(int petrolprice, int dieselprice, int oilprice) async {
   
    await db.doc("VFn16suseaxD613OOg18").set({
      "petrol": petrolprice,
      "diesel": dieselprice,
      "oil": oilprice,
    });
  }
}