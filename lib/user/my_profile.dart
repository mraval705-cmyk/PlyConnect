import 'package:flutter/material.dart';
import '../components/guest_page.dart';
import '../resources/app_colors.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

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
              color: AppColors.lightText,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.heading,
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
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }

  Widget menuItem(
    BuildContext context,
    IconData icon,
    String title,
    String message,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: TextStyle(color: AppColors.heading),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.lightText,
      ),
      onTap: () {
        showMessage(context, message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GuestPage(
      title: 'My Profile',
      selectedIndex: 4,
      body: SingleChildScrollView(
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
              'Arjun Sharma',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'arjun.sharma@email.com',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.text),
            ),

            SizedBox(height: 6),

            Text(
              '+91 98765 43210',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.text),
            ),

            SizedBox(height: 10),

            Text(
              'Sample profile from Figma',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.lightText,
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
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          showMessage(
                            context,
                            'Edit Profile will be connected later.',
                          );
                        },
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  information('FULL NAME', 'Arjun Sharma'),
                  information('MOBILE NUMBER', '+91 98765 43210'),
                  information('EMAIL ADDRESS', 'arjun.sharma@email.com'),
                ],
              ),
            ),

            SizedBox(height: 20),

            card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Delivery Address',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          showMessage(
                            context,
                            'Address editing will be connected later.',
                          );
                        },
                        child: Text(
                          'Edit Address',
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '123, 4th Floor, Hemkunt Tower, Nehru Place,\n'
                      'New Delhi - 110019',
                      style: TextStyle(
                        height: 1.6,
                        color: AppColors.text,
                      ),
                    ),
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
                    Icons.favorite_border,
                    'My Wishlist',
                    'Wishlist will be connected later.',
                  ),
                  Divider(height: 1, color: AppColors.border),
                  menuItem(
                    context,
                    Icons.receipt_long_outlined,
                    'My Orders',
                    'My Orders will be connected later.',
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
                  ),
                  Divider(height: 1, color: AppColors.border),
                  menuItem(
                    context,
                    Icons.logout,
                    'Logout',
                    'Logout is not connected to authentication yet.',
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}