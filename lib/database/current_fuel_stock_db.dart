import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentFuelStockDB {
  final db = FirebaseFirestore.instance.collection("current_fuel_stock");

  getDataFromDB() async {
    var x = await db.doc("GQcgorG1itxc6QUjRmBn").get();
    return x.data();
  }

  updateFuelStock(int petrol, int diesel, int oil) async {
    var x = await getDataFromDB();
    await db.doc("GQcgorG1itxc6QUjRmBn").set({
      "petrol": x["petrol"] - petrol,
      "diesel": x["diesel"] - diesel,
      "oil": x["oil"] - oil
    }).onError((e, _) => print("Error writing document: $e"));
  }

  addFuelStock(int petrol, int diesel, int oil) async {
    var x = await getDataFromDB();
    petrol = x["petrol"] + petrol;
    diesel = x["diesel"] + diesel;
    oil = x["oil"] + oil;
    await db
        .doc("GQcgorG1itxc6QUjRmBn")
        .set({"petrol": petrol, "diesel": diesel, "oil": oil});
  }
}
