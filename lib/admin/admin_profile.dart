import 'package:flutter/material.dart';
import '../guest/welcome.dart';
import '../resources/color_resources.dart';
import 'edit_admin_profile.dart';
import 'manage_orders.dart';
import 'manage_products.dart';
import 'reports_page.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget information(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: ColorResources.lightText,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: ColorResources.heading,
            ),
          ),
        ],
      ),
    );
  }

  Widget card(Widget child) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorResources.border),
      ),
      child: child,
    );
  }

  Widget menuItem(
    BuildContext context,
    IconData icon,
    String title,
    String message,
    Widget? page, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: ColorResources.primary),
      title: Text(
        title,
        style: TextStyle(color: ColorResources.heading),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: ColorResources.lightText,
      ),
      onTap: () {
        if (onTap != null) {
          onTap();
        } else if (title == 'Logout') {
          logout(context);
        } else if (page == null) {
          showMessage(context, message);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
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

  /// A small form with two fields and a check that the new password matches.
  void openChangePassword(BuildContext context) {
    final first = TextEditingController();
    final second = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: ColorResources.background,
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: first,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: 'New password'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: second,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm password',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (first.text.length < 6) {
                  showMessage(
                    context,
                    'Password must be at least 6 letters.',
                  );
                  return;
                }

                if (first.text != second.text) {
                  showMessage(context, 'Both passwords are not the same.');
                  return;
                }

                Navigator.pop(dialogContext);
                showMessage(context, 'Password changed.');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorResources.primary,
                foregroundColor: ColorResources.white,
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: Text('Admin Profile'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 12),

              Center(
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/user_profile.png',
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: 16),

              Text(
                'Rajesh Kumar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorResources.primary,
                ),
              ),

              SizedBox(height: 8),

              Text(
                'admin@plyconnect.com',
                textAlign: TextAlign.center,
                style: TextStyle(color: ColorResources.text),
              ),

              SizedBox(height: 6),

              Container(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: ColorResources.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: ColorResources.border),
                  ),
                  child: Text(
                    'SHOP ADMINISTRATOR',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: ColorResources.primary,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24),

              card(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ColorResources.primary,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditAdminProfilePage(),
                              ),
                            );
                          },
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(color: ColorResources.primary),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    information('FULL NAME', 'Rajesh Kumar'),
                    information('MOBILE NUMBER', '+91 98765 43210'),
                    information('EMAIL ADDRESS', 'admin@plyconnect.com'),
                  ],
                ),
              ),

              SizedBox(height: 20),

              card(
                Column(
                  children: [
                    menuItem(
                      context,
                      Icons.inventory_2_outlined,
                      'Manage Products',
                      'Manage Products will be connected later.',
                      const ManageProductsPage(),
                    ),
                    Divider(height: 1, color: ColorResources.border),
                    menuItem(
                      context,
                      Icons.receipt_long_outlined,
                      'Manage Orders',
                      'Manage Orders will be connected later.',
                      const ManageOrdersPage(),
                    ),
                    Divider(height: 1, color: ColorResources.border),
                    menuItem(
                      context,
                      Icons.bar_chart_outlined,
                      'Sales Report',
                      'Sales Report will be connected later.',
                      const ReportsPage(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              card(
                Column(
                  children: [
                    menuItem(
                      context,
                      Icons.lock_outline,
                      'Change Password',
                      'Change Password will be connected later.',
                      null,
                      onTap: () => openChangePassword(context),
                    ),
                    Divider(height: 1, color: ColorResources.border),
                    menuItem(
                      context,
                      Icons.logout,
                      'Logout',
                      'Logout is not connected to authentication yet.',
                      null,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
