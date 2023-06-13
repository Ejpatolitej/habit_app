import 'package:flutter/material.dart';

class CommonFooterMenu {
  late BuildContext context;

  CommonFooterMenu(this.context);

  void changeScreen(int newScreen) {
    print('going to $newScreen');
    switch (newScreen) {
      case 0:
        Navigator.popAndPushNamed(context, '/habit_tracker');
        break;
      case 1:
        Navigator.popAndPushNamed(context, '/todo');
        break;
    }
  }

  BottomNavigationBar getFooterMenu(int index) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10),
      currentIndex: index,
      selectedItemColor: Colors.purple,
      showSelectedLabels: true,
      unselectedItemColor: const Color.fromARGB(255, 100, 10, 115),
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'Habits'),
        BottomNavigationBarItem(icon: Icon(Icons.check_box), label: 'To do'),
      ],
      onTap: (int index) {
        changeScreen(index);
      },
    );
  }
}