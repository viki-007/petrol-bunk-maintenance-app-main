import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:petrol_bunk_maintainence/controllers/calculator_controller.dart';
import 'package:petrol_bunk_maintainence/controllers/fuel_stock_controller.dart';
import 'package:petrol_bunk_maintainence/database/current_fuel_stock_db.dart';
import 'package:petrol_bunk_maintainence/database/daily_fuel_register.dart';

class Globalval {
  static var pet = "3160";
  static var die = "799";
  static var oi = "146";
}

class FuelStockDisplay extends StatelessWidget {
  FuelStockDisplay({super.key});

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  var x = {};

  CurrentFuelStockDB currentFuelStockDB = CurrentFuelStockDB();
  DailyFuelRegsiter dailyFuelRegsiter = DailyFuelRegsiter();
  var fuelStockController = Get.put(FuelStockController());
  var y = {};
  var z = {};
  getFuelData() async {
    x = await currentFuelStockDB.getDataFromDB();
    y = await dailyFuelRegsiter.getFuelDB();
    z = await dailyFuelRegsiter.getTodaySales();
    fuelStockController.yesterdaysales.text = y["grand_total"].toString();
    fuelStockController.todaysales.text = z["grand_total"].toString();
    fuelStockController.cPetrol.text = x["petrol"].toString();
    fuelStockController.cDiesel.text = x["diesel"].toString();
    fuelStockController.cOil.text = x["oil"].toString();
    if (int.parse(Globalval.pet) <= 500) {
      Get.dialog(AlertDialog(
        title: Text("Update the product"),
        content: Text(
            'The stock of petrol is low (only ${Globalval.pet} remaining)'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              // do something here
              Get.back();
            },
          ),
        ],
      ));
    }
    if (int.parse(Globalval.die) <= 500) {
      Get.dialog(AlertDialog(
        title: Text("Update the product"),
        content: Text(
            'The stock of diesel is low (only ${Globalval.die} remaining)'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              // do something here
              Get.back();
            },
          ),
        ],
      ));
    }
    if (int.parse(Globalval.oi) <= 100) {
      Get.dialog(AlertDialog(
        title: Text("Update the product"),
        content:
            Text('The stock of oil is low (only ${Globalval.oi} remaining)'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              // do something here
              Get.back();
            },
          ),
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    getFuelData();
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 236, 211, 209),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 154, 45, 45),
          title: Text("Total fuel display"),
          centerTitle: true,
          shadowColor: Colors.black,
          actions: [
            IconButton(
              onPressed: _signOut,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: SafeArea(
            child: ListView(children: [
          Container(
            padding: EdgeInsets.only(
                top: Get.height * 0.01, bottom: Get.height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Stock of Fuels",
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 1,
            thickness: 1,
          ),
          Container(
              child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(Get.width * 0.08),
                child: Column(
                  children: [
                    TextField(
                      controller: fuelStockController.cPetrol,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.04,
                            vertical: Get.height * 0.01),
                        counterText: 'petrol balance',
                        // hintText: "Enter the todays petrol balance"
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    TextField(
                      controller: fuelStockController.cDiesel,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.04,
                            vertical: Get.height * 0.01),
                        counterText: ' Diesel balance',
                        // hintText: "Enter the todays diesel balance"
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    TextField(
                      controller: fuelStockController.cOil,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.04,
                            vertical: Get.height * 0.01),
                        counterText: 'oil balance',
                        // hintText: "Enter the todays oil balance"
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    TextField(
                      controller: fuelStockController.yesterdaysales,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.04,
                            vertical: Get.height * 0.01),
                        counterText: "Yesterday's sales",
                        // hintText: "Enter the todays oil balance"
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    TextField(
                      controller: fuelStockController.todaysales,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.04,
                            vertical: Get.height * 0.01),
                        counterText: "Today's sales",
                        // hintText: "Enter the todays oil balance"
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
            ],
          )),
          SizedBox(
            height: Get.height * 0.04,
          ),
          Divider(
            color: Colors.grey,
            height: 1,
            thickness: 1,
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Color.fromARGB(255, 154, 46, 46), // background (button) color
              foregroundColor: Colors.white, // foreground (text) color
            ),
            onPressed: () {
              _showAlertDialog(
                  context, fuelStockController, currentFuelStockDB);
            },
            child: const Text('Update'),
          ),
        ])));
  }
}

void _showAlertDialog(
    BuildContext context,
    FuelStockController fuelStockController,
    CurrentFuelStockDB currentFuelStockDB) {
  AlertDialog alert = AlertDialog(
    title: Text("Add stock"),
    content: Container(
      color: Color.fromARGB(255, 234, 224, 223),
      height: Get.height * 0.4,
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.04,
          ),
          // Text(
          //   "Total petrol sold :",
          //   textAlign: TextAlign.right,
          // ),
          TextField(
            controller: fuelStockController.addPetrol,
            decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
                counterText: 'Petrol',
                hintText: "Add petrol to the stock"),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          // Text(
          //   "Total diesel sold (in rupees):",
          //   textAlign: TextAlign.right,
          // ),
          TextField(
            // controller: calculatorController.todayOil,
            controller: fuelStockController.addDiesel,
            decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
                counterText: 'stock',
                hintText: "Add diesel to the stock"),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          // Text(
          //   "Total amount :",
          //   textAlign: TextAlign.right,
          // ),
          TextField(
            controller: fuelStockController.addOil,
            decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
                counterText: 'oil',
                hintText: "Add oil to the stock"),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ],
      ),
    ),
    actions: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Color.fromARGB(255, 227, 80, 80), // background (button) color
          foregroundColor: Colors.white, // foreground (text) color
        ),
        onPressed: () async {
          String petrol_s = fuelStockController.addPetrol.text;
          String diesel_s = fuelStockController.addDiesel.text;
          String oil_s = fuelStockController.addOil.text;
          int petrol = int.parse(petrol_s);
          int diesel = int.parse(diesel_s);
          int oil = int.parse(oil_s);
          await currentFuelStockDB.addFuelStock(petrol, diesel, oil);
          Get.back();
        },
        child: Text("Update"),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Color.fromARGB(255, 227, 80, 80), // background (button) color
          foregroundColor: Colors.white, // foreground (text) color
        ),
        onPressed: () {
          Get.back();
        },
        child: Text("Cancel"),
      ),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

  //           style: ElevatedButton.styleFrom(
  //             backgroundColor:
  //                 Color.fromARGB(255, 154, 46, 46), // background (button) color
  //             foregroundColor: Colors.white, // foreground (text) color
  //           ),
  //           onPressed: () {
  //             // int petrolCost =
  //           },
  //           child: const Text('Update'),
  //         ),