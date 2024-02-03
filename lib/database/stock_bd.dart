import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class StockDB {
  final db = FirebaseFirestore.instance.collection("stock");

  deleteByID(String id) async {
    var x = db.doc(id).delete() ;
    log(x.toString());
  }

  getCountOfStock() async {
    var k =  await db.count().get();
    return k.count ;
  }

  getFromDB() async {
    var data = await db.get();

    List<dynamic> datalist = [];

    for (var element in data.docs) {
      var map = {};
      map["doc_id"] = element.id;
      element.data().forEach((key, value) => {
            if (value.toString().isNotEmpty)
              map[key.split("_").join(" ")] = value
            else
              map[key.split("_").join(" ")] = "No Data"
          });
      datalist.add(map);
    }

    return datalist;
  }

  putInDB(Map<String, String> data) async {
    db.add(data).then((value) {
      log(value.id.toString());
      return true;
    });
  }
}
