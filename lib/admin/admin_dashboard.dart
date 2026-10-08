import 'package:flutter/material.dart';
import '../guest/welcome.dart';
import '../resources/color_resources.dart';
import 'admin_profile.dart';
import 'local_products.dart';
import 'manage_brands.dart';
import 'manage_categories.dart';
import 'manage_customers.dart';
import 'manage_orders.dart';
import 'manage_products.dart';
import 'stock_management.dart';

/// The first screen the admin sees after logging in.
///
/// It only holds the menu, so every part of the shop is one tap away.
class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void openPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// Sends the admin back to the Welcome screen and clears the pages that
  /// were opened before it, so the back button does not return here.
  void logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WelcomePage()),
      (route) => false,
    );
  }

  /// One row of the menu, with a coloured box on the left.
  Widget menuCard(
    BuildContext context,
    String title,
    IconData icon,
    Widget? page,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorResources.border),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        leading: Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorResources.background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: ColorResources.primary),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorResources.heading,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: ColorResources.lightText,
        ),
        onTap: () {
          if (title == 'Logout') {
            logout(context);
          } else if (page == null) {
            showMessage(context, '$title will be connected later.');
          } else {
            openPage(context, page);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
        actions: [
          IconButton(
            tooltip: 'Notifications',
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              showMessage(context, 'No new notifications.');
            },
          ),
          IconButton(
            tooltip: 'Admin Profile',
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => openPage(context, const AdminProfilePage()),
          ),
        ],
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            menuCard(
              context,
              'Manage Products',
              Icons.inventory_2_outlined,
              const ManageProductsPage(),
            ),
            menuCard(
              context,
              'Local Products',
              Icons.save_outlined,
              const LocalProductsPage(),
            ),
            menuCard(
              context,
              'Categories',
              Icons.category_outlined,
              const ManageCategoriesPage(),
            ),
            menuCard(
              context,
              'Brands',
              Icons.business_outlined,
              const ManageBrandsPage(),
            ),
            menuCard(
              context,
              'Stock',
              Icons.inventory_outlined,
              const StockManagementPage(),
            ),
            menuCard(
              context,
              'Customers',
              Icons.people_outline,
              const ManageCustomersPage(),
            ),
            menuCard(
              context,
              'Orders',
              Icons.receipt_long_outlined,
              const ManageOrdersPage(),
            ),
            menuCard(
              context,
              'Logout',
              Icons.logout,
              null,
            ),
          ],
        ),
      ),
    );
  }
}