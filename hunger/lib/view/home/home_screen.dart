import 'package:flutter/material.dart';
import 'package:hunger/res/component/my_drawer.dart';
import 'package:hunger/view/home/component/my_appbar.dart';
import 'package:hunger/view/tab/component/my_tab.dart';
import 'package:hunger/view/tab/screen/burger_tab.dart';
import 'package:hunger/view/tab/screen/donut_tab.dart';
import 'package:hunger/view/tab/screen/pancake_tab.dart';
import 'package:hunger/view/tab/screen/pizza_tab.dart';
import 'package:hunger/view/tab/screen/smoothie_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = const [
      MyTab(iconPath: 'assets/icons/donut.png'),
      MyTab(
        iconPath: 'assets/icons/burger.png',
      ),
      MyTab(
        iconPath: 'assets/icons/pancakes.png',
      ),
      MyTab(
        iconPath: 'assets/icons/pizza.png',
      ),
      MyTab(
        iconPath: 'assets/icons/smoothie.png',
      )
    ];

    return DefaultTabController(
      length: tabs.length,
      child: SafeArea(
        child: Scaffold(
          appBar: myAppBar(context),
          drawer: const MyDrawer(),
          body: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              //tab bar items
              TabBar(
                tabs: tabs,
              ),
              //tab bar screens
              const Expanded(
                child: TabBarView(children: [
                  //donut tab
                  DonutTab(),
                  //burger tab
                  BurgerTab(),
                  //pancake tab
                  PanCakeTab(),
                  //pizza tab
                  PizzaTab(),
                  //smoothie tab
                  SmoothieTab()
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
