import 'package:flutter/material.dart';
import '../resources/app_colors.dart';

class GuestPage extends StatelessWidget {
  final String title;
  final Widget body;
  final int? selectedIndex;

  const GuestPage({
    super.key,
    required this.title,
    required this.body,
    this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
      ),
      body: SafeArea(child: body),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex ?? 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.background,
        selectedItemColor: selectedIndex == null
            ? AppColors.text
            : AppColors.primary,
        unselectedItemColor: AppColors.text,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        onTap: (index) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Navigation will be connected later.'),
            ),
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}