import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class FuelStockController extends GetxController {
  TextEditingController addDiesel = TextEditingController();
  TextEditingController addPetrol = TextEditingController();
  TextEditingController addOil = TextEditingController();
  
  TextEditingController cDiesel = TextEditingController();
  TextEditingController cPetrol = TextEditingController();
  TextEditingController cOil = TextEditingController();
  TextEditingController yesterdaysales = TextEditingController();
  TextEditingController todaysales = TextEditingController();
}
