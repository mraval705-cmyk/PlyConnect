import 'package:flutter/material.dart';
import '../guest/browse_products.dart';
import '../guest/home.dart';
import '../resources/color_resources.dart';
import '../user/my_orders.dart';
import '../user/my_profile.dart';
import '../user/wishlist.dart';

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

  // Used by every screen that shows the bottom navigation bar.
  void openPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: SafeArea(child: body),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex ?? 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorResources.background,
        selectedItemColor: selectedIndex == null
            ? ColorResources.text
            : ColorResources.primary,
        unselectedItemColor: ColorResources.text,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        onTap: (index) {
          if (index == 0) {
            openPage(context, const GuestHomePage());
          } else if (index == 1) {
            openPage(context, const BrowseProductsPage());
          } else if (index == 2) {
            openPage(context, const WishlistPage());
          } else if (index == 3) {
            openPage(context, const MyOrdersPage());
          } else {
            openPage(context, const MyProfilePage());
          }
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