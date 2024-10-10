
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:emart_app/view/cart_screen/cart_screen.dart';
import 'package:emart_app/view/category_screen/category_screen.dart';
import 'package:emart_app/view/home_screen/home_screen.dart';
import 'package:emart_app/view/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(HomeController());

    var navbaritem = [
      BottomNavigationBarItem(icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(icon: Image.asset(icCategories, width: 26), label: categories),
      BottomNavigationBarItem(icon: Image.asset(icCart, width: 26), label: cart),
      BottomNavigationBarItem(icon: Image.asset(icProfile, width: 26), label: account)    
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(child: navBody.elementAt(controller.currentNavIndex.value))),
        ],
      ),
      bottomNavigationBar: Obx(()=>
        BottomNavigationBar(
          selectedItemColor: redColor,
          selectedLabelStyle: const TextStyle(fontFamily: semibold), 
          currentIndex: controller.currentNavIndex.value,
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          onTap: (value){
            controller.currentNavIndex.value = value;
          },
          items: navbaritem),
      ),
    );
  }
} 