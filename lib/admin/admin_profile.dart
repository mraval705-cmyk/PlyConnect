import 'package:flutter/material.dart';
import '../resources/color_resources.dart';
import 'edit_admin_profile.dart';

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
    Widget? page,
  ) {
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
        if (page == null) {
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
                      null,
                    ),
                    Divider(height: 1, color: ColorResources.border),
                    menuItem(
                      context,
                      Icons.receipt_long_outlined,
                      'Manage Orders',
                      'Manage Orders will be connected later.',
                      null,
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
