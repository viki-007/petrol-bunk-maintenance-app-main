import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:petrol_bunk_maintainence/database/daily_fuel_register.dart';

class MyListController extends GetxController {
  var myDocuments = <QueryDocumentSnapshot>[].obs;

  @override
  void onInit() {
    super.onInit();
    FirebaseFirestore.instance
        .collection('daily_fuel_register')
        .snapshots()
        .listen((snapshot) {
      myDocuments.value = snapshot.docs;
    });
  }
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}

class ListDetails extends StatelessWidget {
  ListDetails({super.key});
  final MyListController controller = Get.put(MyListController());
  @override
  Widget build(BuildContext context) {
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
        title: Text("List Details"),
        centerTitle: true,
        shadowColor: Colors.black,
      ),
      body: Obx(() {
        if (controller.myDocuments.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.myDocuments.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data =
                controller.myDocuments[index].data() as Map<String, dynamic>;
            return ListTile(
                leading: Icon(Icons.car_repair),
                title: Text(data['date'] ?? ''),
                subtitle:
                    Text("Total sales : " + (data['grand_total']).toString()),
                trailing: Icon(Icons.more_vert));
          },
        );
      }),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:petrol_bunk_maintainence/database/daily_fuel_register.dart';

// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
  
// }
