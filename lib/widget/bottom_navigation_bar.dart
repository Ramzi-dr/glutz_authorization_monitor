import 'package:flutter/material.dart';

class BottomBar {
  final int selectedIndex;
  final String screenOne;
  final String screenTwo;
  final String screenThree;
  final IconData iconOne;
  final IconData iconTwo;
  final IconData iconThree;
  final String labelOne;
  final String labelTwo;
  final String labelThree;
  final Function onTap;
  final BuildContext context;
  
  late final pageList = [screenOne, screenTwo, screenThree];
  static int currentIndex = 1;

  BottomBar(
    this.onTap,
    this.context,
    this.selectedIndex,
    this.screenOne,
    this.screenTwo,
    this.screenThree,
    this.iconOne,
    this.iconTwo,
    this.iconThree,
    this.labelOne,
    this.labelTwo,
    this.labelThree,
  );

  BottomNavigationBar bottomBar() {
    return BottomNavigationBar(
      elevation: 6,
      onTap: (value) {
        onTap;
        print('value: $value');
        print('ontap: $onTap');
        Navigator.pushNamed(context, pageList[selectedIndex]);
      },
      currentIndex: selectedIndex,
      backgroundColor: const Color.fromARGB(95, 64, 255, 179),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(iconOne),
          label: labelOne,
        ),
        BottomNavigationBarItem(
          icon: Icon(iconTwo),
          label: labelTwo,
        ),
        BottomNavigationBarItem(
          icon: Icon(iconThree),
          label: labelThree,
        ),
      ],
    );
  }
}
