import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentNozzleReadingDB {
  final db = FirebaseFirestore.instance.collection("pump");

  getDataFromPump() async {
    var y = await db.doc("pump").get();
    return y.data();
  }

  addFuelStock(int Nozzle1, int Nozzle2, int Nozzle3, int Nozzle4, int Nozzle5,
      int Nozzle6, int Nozzle7, int Nozzle8, int Oil) async {
    int nozzle1 = Nozzle1;
    int nozzle2 = Nozzle2;
    int nozzle3 = Nozzle3;
    int nozzle4 = Nozzle4;
    int nozzle5 = Nozzle5;
    int nozzle6 = Nozzle6;
    int nozzle7 = Nozzle7;
    int nozzle8 = Nozzle8;
    int oil = Oil;
    await db.doc("pump").set({
      "nozzle1": nozzle1,
      "nozzle2": nozzle2,
      "nozzle3": nozzle1,
      "nozzle4": nozzle4,
      "nozzle5": nozzle5,
      "nozzle6": nozzle6,
      "nozzle7": nozzle7,
      "nozzle8": nozzle8,
      "oil": oil
    });
  }
}
