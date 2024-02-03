import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petrol_bunk_maintainence/database/stock_bd.dart';

class DropdownContainer extends StatelessWidget {
  const DropdownContainer({super.key, required this.s});
  final Map<dynamic, dynamic> s;

  @override
  Widget build(BuildContext context) {
    var k = false.obs;

    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: Get.width * 0.06, vertical: Get.height * 0.01),
        width: Get.width * 0.8,
        child: Obx(
          () => Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.03,
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        width: 2,
                        style: BorderStyle.solid)),
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.005),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(s['Product Brand']),
                    Text(s['Count']),
                    if (k.value)
                      IconButton(
                        icon: const Icon(CupertinoIcons.chevron_up_circle),
                        onPressed: () {
                          k.value = !k.value;
                        },
                      )
                    else
                      IconButton(
                        icon: const Icon(CupertinoIcons.chevron_down_circle),
                        onPressed: () {
                          k.value = !k.value;
                        },
                      )
                  ],
                ),
              ),
              if (k.value)
                Column(
                  children: s.keys
                          .toList()
                          .map((e) => Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                        style: BorderStyle.solid)),
                                padding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.003,
                                    horizontal: Get.width * 0.009),
                                margin:
                                    EdgeInsets.only(bottom: Get.height * 0.006),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: Get.width * 0.4,
                                        child: Text(e.toString())),
                                    SizedBox(
                                        width: Get.width * 0.4,
                                        child: Text(s[e.toString()].toString(),
                                            textAlign: TextAlign.end))
                                  ],
                                ),
                              ))
                          .toList() +
                      [
                        Container(
                            child: IconButton(
                                onPressed: () {
                                  StockDB().deleteByID( s["doc_id"] );
                                },
                                icon: const Icon(CupertinoIcons.delete)))
                      ],
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ));
  }
}
