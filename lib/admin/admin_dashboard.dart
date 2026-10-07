import 'package:flutter/material.dart';
import '../resources/color_resources.dart';
import 'manage_brands.dart';
import 'manage_categories.dart';
import 'manage_orders.dart';
import 'manage_products.dart';
import 'manage_customers.dart';
import 'local_products.dart';
import 'stock_management.dart';
import 'admin_profile.dart';

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

  Widget menuCard(
    BuildContext context,
    String title,
    IconData icon,
    Widget? page,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Material(
        color: ColorResources.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: ColorResources.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          leading: Icon(
            icon,
            color: ColorResources.primary,
            size: 28,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorResources.heading,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: ColorResources.lightText,
          ),
          onTap: () {
            if (page == null) {
              showMessage(
                context,
                '$title will be connected later.',
              );
            } else {
              openPage(context, page);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
        actions: [
          IconButton(
            tooltip: 'Notifications',
            icon: Icon(Icons.notifications_none),
            onPressed: () {
              showMessage(
                context,
                'Notifications will be connected later.',
              );
            },
          ),
          IconButton(
            tooltip: 'Admin Profile',
            icon: Icon(Icons.account_circle_outlined),
            onPressed: () {
              openPage(context, AdminProfilePage());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            SizedBox(height: 12),

            Text(
              'Welcome, Admin',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorResources.heading,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'Manage your plywood shop operations.',
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: ColorResources.text,
              ),
            ),

            SizedBox(height: 24),

            menuCard(
              context,
              'Manage Products',
              Icons.inventory_2_outlined,
              ManageProductsPage(),
            ),
            menuCard(
              context,
              'Categories',
              Icons.category_outlined,
              ManageCategoriesPage(),
            ),
            menuCard(
              context,
              'Brands',
              Icons.business_outlined,
              ManageBrandsPage(),
            ),
            menuCard(
              context,
              'Stock',
              Icons.inventory_outlined,
              StockManagementPage(),
            ),
            menuCard(
              context,
              'Customers',
              Icons.people_outline,
              ManageCustomersPage(),
            ),
            menuCard(
              context,
              'Orders',
              Icons.receipt_long_outlined,
              ManageOrdersPage(),
            ),
            menuCard(
              context,
              'Local Products',
              Icons.save_outlined,
              LocalProductsPage(),
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