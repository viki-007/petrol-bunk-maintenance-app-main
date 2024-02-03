import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petrol_bunk_maintainence/controllers/stock_db_controller.dart';
import 'package:petrol_bunk_maintainence/database/stock_bd.dart';
import '../../utils/components/stock_widget.dart';

class Stock extends StatelessWidget {
  Stock({super.key});
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  var count = 0.obs;

  getCount() async {
    count.value = await StockDB().getCountOfStock();
    // log(count.value.toString());
  }

  @override
  Widget build(BuildContext context) {
    getCount();
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 236, 211, 209),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: _signOut,
              icon: const Icon(Icons.logout),
            ),
          ],
          backgroundColor: Color.fromARGB(255, 154, 45, 45),
          title: Text("Stocks"),
          centerTitle: true,
          shadowColor: Colors.black,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Get.height * 0.01, bottom: Get.height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "List of products",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: Get.height * 0.05,
                  width: Get.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => Text(
                          "Number of products = ${count.value.toString()}")),
                    ],
                  )),
              SizedBox(
                height: Get.height * 0.8,
                width: Get.width,
                child: GetBuilder<StockDBController>(
                    init: StockDBController(),
                    builder: (controller) {
                      return ListView.builder(
                          itemCount: controller.data.length,
                          itemBuilder: (context, i) {
                            return DropdownContainer(s: controller.data[i]);
                          });
                    }),
              ),
            ],
          ),
        ));
  }
}
