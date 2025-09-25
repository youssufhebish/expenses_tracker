import 'package:flutter/material.dart';

import '../../../home/presentation/screen/home_screen.dart';

class HomeLayoutBody extends StatelessWidget {

  const HomeLayoutBody({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const HomeScreen(), 
      Container(), // Statistics tab -> Currency Exchange
      Container(), // Calendar tab
      Container(), // Profile tab
    ];

    return IndexedStack(index: currentIndex, children: tabs);
  }
}
