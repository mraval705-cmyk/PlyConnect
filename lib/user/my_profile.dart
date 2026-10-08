import 'package:flutter/material.dart';
import '../components/guest_page.dart';
import '../resources/color_resources.dart';
import '../guest/welcome.dart';
import '../resources/sample_data.dart';
import 'change_password.dart';
import 'edit_address.dart';
import 'edit_profile.dart';
import 'my_orders.dart';
import 'wishlist.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Waits for the opened page to close and then refreshes this screen, so a
  /// change made in Edit Profile or Edit Address is shown here at once.
  Future<void> openPage(Widget page) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );

    if (mounted) {
      setState(() {});
    }
  }

  String get firstLetter {
    final name = SampleData.nameText;
    if (name.isEmpty) return '?';
    return name[0].toUpperCase();
  }

  Widget information(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: ColorResources.lightText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorResources.border),
      ),
      child: child,
    );
  }

  /// Takes the visitor back to the Welcome screen and clears the pages that
  /// were opened before it, so the back button does not return here.
  void logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomePage(),
      ),
      (route) => false,
    );
  }

  Widget menuItem(IconData icon, String title, Widget? page) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: ColorResources.primary),
      title: Text(
        title,
        style: const TextStyle(color: ColorResources.heading),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: ColorResources.lightText,
      ),
      onTap: () {
        if (title == 'Logout') {
          logout();
        } else if (page == null) {
          showMessage('$title will be connected later.');
        } else {
          openPage(page);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GuestPage(
      title: 'My Profile',
      selectedIndex: 4,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),

            // There is no photo yet, so the first letter of the name is
            // shown inside a circle instead.
            Center(
              child: Container(
                width: 96,
                height: 96,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorResources.background,
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorResources.border, width: 2),
                ),
                child: Text(
                  firstLetter,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.primary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Arjun Sharma',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorResources.primary,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'arjun.sharma@email.com',
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorResources.text),
            ),

            const SizedBox(height: 6),

            const Text(
              '+91 98765 43210',
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorResources.text),
            ),

            const SizedBox(height: 24),

            card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
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
                        onPressed: () => openPage(const EditProfilePage()),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(color: ColorResources.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  information('FULL NAME', SampleData.nameText),
                  information('MOBILE NUMBER', '+91 ${SampleData.mobileText}'),
                  information('EMAIL ADDRESS', SampleData.emailText),
                ],
              ),
            ),

            const SizedBox(height: 20),

            card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Delivery Address',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ColorResources.primary,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => openPage(const EditAddressPage()),
                        child: const Text(
                          'Edit Address',
                          style: TextStyle(color: ColorResources.primary),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ColorResources.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      SampleData.addressText,
                      style: const TextStyle(
                        height: 1.6,
                        color: ColorResources.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            card(
              Column(
                children: [
                  menuItem(
                    Icons.favorite_border,
                    'My Wishlist',
                    const WishlistPage(),
                  ),
                  const Divider(height: 1, color: ColorResources.border),
                  menuItem(
                    Icons.receipt_long_outlined,
                    'My Orders',
                    const MyOrdersPage(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            card(
              Column(
                children: [
                  menuItem(
                    Icons.lock_outline,
                    'Change Password',
                    const ChangePasswordPage(),
                  ),
                  const Divider(height: 1, color: ColorResources.border),
                  menuItem(Icons.logout, 'Logout', null),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}