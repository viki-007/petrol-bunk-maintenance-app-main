import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petrol_bunk_maintainence/database/stock_bd.dart';

class AddStock extends StatelessWidget {
  const AddStock({super.key});
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Map<String, String>> mymap = {};
    mymap[0] = {"data": "Product Brand"};
    mymap[1] = {"data": "Count"};
    mymap[2] = {"data": "Barcode Id"};

    final _formKey = GlobalKey<FormState>();

    List<Widget> formList = [
      Container(
        padding:
            EdgeInsets.only(top: Get.height * 0.05, left: Get.width * 0.15),
        child: Text(
          "Add the products",
          style: TextStyle(color: Colors.black, fontSize: Get.height * 0.05),
        ),
      ),
      Container(
        padding: EdgeInsets.only(
            top: Get.height * 0.05,
            left: Get.width * 0.05,
            right: Get.width * 0.05),
        child: Row(
          children: [
            SizedBox(
                width: Get.width * 0.3, child: const Text("Product Brand")),
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  mymap[0]!["value"] = value.toString();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Value',
                ),
              ),
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(
            top: Get.height * 0.05,
            left: Get.width * 0.05,
            right: Get.width * 0.05),
        child: Row(
          children: [
            SizedBox(width: Get.width * 0.3, child: const Text("Count")),
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  mymap[1]!["value"] = value.toString();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Value',
                ),
              ),
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(
            top: Get.height * 0.05,
            left: Get.width * 0.05,
            right: Get.width * 0.05),
        child: Row(
          children: [
            SizedBox(
                width: Get.width * 0.3,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(""),
                )),
            // Expanded(
            //   child: TextFormField(
            //     onChanged: (value) {
            //       mymap[2]!["value"] = value.toString();
            //     },
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return 'Please enter some text';
            //       }
            //       return null;
            //     },
            //     decoration: const InputDecoration(
            //       border: OutlineInputBorder(),
            //       labelText: 'Value',
            //     ),
            //   ),
            // )
          ],
        ),
      ),
      SizedBox(height: Get.height * 0.05),
      Container(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, // background (button) color
              foregroundColor: Colors.white, // foreground (text) color
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                Map<String, String> formdata = {};
                mymap.forEach((key, value) {
                  formdata[mymap[key]!["data"]
                      .toString()
                      .split(" ")
                      .join("_")] = mymap[key]!["value"].toString();
                });

                var response = StockDB().putInDB(formdata);
                log(response.toString());
                Get.back();
              }
            },
            child: const Text("Submit")),
      ),
    ].obs;

    Widget rowAdd(int x) {
      return Row(
        children: [
          Expanded(
            child: TextFormField(
              onChanged: (value) {
                mymap[x]!["data"] = value.toString();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Data',
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              onChanged: (value) {
                mymap[x]!["value"] = value.toString();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Value',
              ),
            ),
          )
        ],
      );
    }

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
          title: Text("Add the products"),
          centerTitle: true,
          shadowColor: Colors.black,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              mymap[formList.length - 1] = {};
              formList.insert(formList.length - 1, rowAdd(formList.length - 1));
            }),
        body: SafeArea(
            child: Form(
                key: _formKey,
                child: Obx(() => ListView(
                      children: formList,
                    )))));
  }
}
