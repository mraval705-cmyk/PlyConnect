import 'package:flutter/material.dart';
import '../resources/app_colors.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget menuCard(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Material(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          leading: Icon(
            icon,
            color: AppColors.primary,
            size: 28,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.heading,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: AppColors.lightText,
          ),
          onTap: () {
            showMessage(
              context,
              '$title will be connected later.',
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
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
              showMessage(
                context,
                'Admin Profile will be connected later.',
              );
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
                color: AppColors.heading,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'Manage your plywood shop operations.',
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: AppColors.text,
              ),
            ),

            SizedBox(height: 24),

            menuCard(
              context,
              'Manage Products',
              Icons.inventory_2_outlined,
            ),
            menuCard(
              context,
              'Categories',
              Icons.category_outlined,
            ),
            menuCard(
              context,
              'Brands',
              Icons.business_outlined,
            ),
            menuCard(
              context,
              'Stock',
              Icons.inventory_outlined,
            ),
            menuCard(
              context,
              'Customers',
              Icons.people_outline,
            ),
            menuCard(
              context,
              'Orders',
              Icons.receipt_long_outlined,
            ),
            menuCard(
              context,
              'Logout',
              Icons.logout,
            ),
          ],
        ),
      ),
    );
  }
}