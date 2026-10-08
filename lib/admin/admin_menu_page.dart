import 'package:flutter/material.dart';
import '../resources/color_resources.dart';
import 'local_products.dart';
import 'manage_brands.dart';
import 'manage_categories.dart';
import 'manage_customers.dart';
import 'manage_orders.dart';
import 'manage_products.dart';
import 'reports_page.dart';
import 'stock_management.dart';

/// The manage section of the admin area, kept on its own page so that the
/// dashboard only has the numbers and the warnings on it.
class AdminMenuPage extends StatelessWidget {
  const AdminMenuPage({super.key});

  void openPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// One big tile. The icon sits in a coloured square so the row looks
  /// designed rather than a plain list line.
  Widget tile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Widget page,
  ) {
    return InkWell(
      onTap: () => openPage(context, page),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorResources.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorResources.border),
          boxShadow: [
            BoxShadow(
              color: ColorResources.primary.withAlpha(12),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorResources.background,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: ColorResources.primary, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: ColorResources.heading,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: ColorResources.lightText,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: ColorResources.lightText,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: const Text('Manage Shop'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'CATALOGUE',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1,
              color: ColorResources.lightText,
            ),
          ),
          const SizedBox(height: 12),

          tile(
            context,
            'Products',
            'Add, edit and remove what the shop sells',
            Icons.inventory_2_outlined,
            const ManageProductsPage(),
          ),
          tile(
            context,
            'Local Products',
            'Register items on the phone with Load and Save',
            Icons.save_outlined,
            const LocalProductsPage(),
          ),
          tile(
            context,
            'Categories',
            'How the shop groups its products',
            Icons.category_outlined,
            const ManageCategoriesPage(),
          ),
          tile(
            context,
            'Brands',
            'The brands the shop sells from',
            Icons.business_outlined,
            const ManageBrandsPage(),
          ),
          tile(
            context,
            'Stock',
            'How many sheets are left of each product',
            Icons.inventory_outlined,
            const StockManagementPage(),
          ),

          const SizedBox(height: 10),
          const Text(
            'PEOPLE AND ORDERS',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1,
              color: ColorResources.lightText,
            ),
          ),
          const SizedBox(height: 12),

          tile(
            context,
            'Customers',
            'Everyone who has made an account',
            Icons.people_outline,
            const ManageCustomersPage(),
          ),
          tile(
            context,
            'Orders',
            'Confirm and update every order',
            Icons.receipt_long_outlined,
            const ManageOrdersPage(),
          ),

          const SizedBox(height: 10),
          const Text(
            'REPORTS',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1,
              color: ColorResources.lightText,
            ),
          ),
          const SizedBox(height: 12),

          tile(
            context,
            'Sales Report',
            'Revenue, best sellers and order counts',
            Icons.bar_chart,
            const ReportsPage(),
          ),
        ],
      ),
    );
  }
}