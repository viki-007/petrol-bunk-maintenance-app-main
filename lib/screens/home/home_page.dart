import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:petrol_bunk_maintainence/screens/fuel_stock/fuel_stock_display.dart';
import 'package:petrol_bunk_maintainence/screens/list_all_data/list_all_data.dart';
import 'add_stock.dart';
import 'calculator.dart';
import 'stock.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;
    controller = PersistentTabController(initialIndex: 0);
    // // log(.toString()) ;
    // var val = {} ;
    // val = Get.arguments ?? {} ;
    // log(val.toString());
    List<Widget> buildScreens() {
      return [
        FuelStockDisplay(),
        Calculator(),
        Stock(),
        const AddStock(),
        ListDetails()
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.collections_solid),
          title: ("Fuel stock"),
          activeColorPrimary: Color.fromARGB(255, 154, 45, 45),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.equal_square_fill),
          title: ("Calculator"),
          activeColorPrimary: Color.fromARGB(255, 154, 45, 45),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.collections_solid),
          title: ("Stock"),
          activeColorPrimary: Color.fromARGB(255, 154, 45, 45),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.add_circled),
          title: ("Add Stock"),
          activeColorPrimary: Color.fromARGB(255, 154, 45, 45),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.arrow_down_square_fill),
          title: ("list details"),
          activeColorPrimary: Color.fromARGB(255, 154, 45, 45),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

    return Scaffold(
      body: PersistentTabView(
        context,
        controller: controller,
        screens: buildScreens(),
        items: navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1,
      ),
    );
  }
}
