import 'package:flutter/material.dart';

import '../../../add_expense/presentation/screen/add_expense.dart';
import '../components/bottom_navigation.dart';
import '../components/home_layout_body.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeLayoutBody(currentIndex: 0),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: 0,
        onTap: (index) {},
        onAddTap: () {
          _navigateToAddExpense(context);
        },
      ),
    );
  }

  void _navigateToAddExpense(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => AddExpenseScreen()));
  }
}
