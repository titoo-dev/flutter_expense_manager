import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';
import 'package:get/get.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: controller.ktabPages,
        controller: controller.tabController,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: controller.handlePressFloatingActionButton,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: GetBuilder<HomeController>(
          id: 'bottom_navbar',
          builder: (state) {
            return BottomNavigationBar(
              items: state.bottomNavbarItems,
              onTap: controller.handleOnTapBottomNavbar,
              currentIndex: state.tabController.index,
            );
          }),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: TextButton(
          child: GetBuilder<HomeController>(
              id: 'capital',
              builder: (state) {
                return Text("${state.myAccount.compute()}Ar",
                    style:
                        const TextStyle(color: Colors.black87, fontSize: 18));
              }),
          onPressed: controller.handlePressAmount,
        ),
      ),
    );
  }
}
