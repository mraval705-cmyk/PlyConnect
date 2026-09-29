import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/guest_page.dart';
import '../guest/welcome.dart';
import '../login.dart';
import '../resources/color_resources.dart';
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
  bool isLoading = true;

  // These hold whatever we managed to read from Firebase.
  String userName = '';
  String userEmail = '';
  String userMobile = '';
  String userAddress = '';

  // isGuest is true when nobody is logged in. Only then do we show the
  // sample data, the same way a real shop app shows a preview to a guest.
  bool isGuest = false;
  bool isLoggedIn = false;

  // Sample values shown only while browsing as a guest.
  static const String guestName = 'Arjun Sharma';
  static const String guestEmail = 'arjun.sharma@email.com';
  static const String guestMobile = '+91 98765 43210';
  static const String guestAddress =
      '123, 4th Floor, Hemkunt Tower, Nehru Place,\n'
      'New Delhi - 110019';

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  // Reads the signed in user's email from Firebase Authentication and the
  // name, mobile and address from the "users" collection in Firestore.
  Future<void> loadUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      setState(() {
        isLoading = false;
        isGuest = true;
        isLoggedIn = false;
      });
      return;
    }

    userEmail = currentUser.email ?? '';

    try {
      final document = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      final data = document.data();

      if (data != null) {
        userName = '${data['name'] ?? ''}';
        userMobile = '${data['mobile'] ?? ''}';
        userAddress = '${data['address'] ?? ''}';
      }
    } catch (error) {
      // If Firestore is not reachable the email alone is still shown.
      userName = '';
      userMobile = '';
      userAddress = '';
    }

    if (!mounted) {
      return;
    }

    setState(() {
      isLoading = false;
      isGuest = false;
      isLoggedIn = true;
    });
  }

  // Real apps show the first letter of the name when there is no photo yet.
  String get nameFirstLetter {
    if (userName.isEmpty) {
      return 'P';
    }
    return userName[0].toUpperCase();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void openPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Waits for the page to close and then reads the data again, so any change
  // made on that page is shown here straight away.
  Future<void> openPageAndRefresh(Widget page) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );

    await loadUser();
  }

  // Signs the user out of Firebase and takes them back to the Welcome screen.
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      if (!mounted) {
        return;
      }
      showMessage('Could not log out. $error');
      return;
    }

    if (!mounted) {
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomePage(),
      ),
      (route) => false,
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
    IconData icon,
    String title,
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

  // Shown when the visitor is browsing without an account. The sample data is
  // clearly marked so nobody thinks it is a real order.
  Widget guestView() {
    return Column(
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
          guestName,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ColorResources.primary,
          ),
        ),

        SizedBox(height: 8),

        Text(
          guestEmail,
          textAlign: TextAlign.center,
          style: TextStyle(color: ColorResources.text),
        ),

        SizedBox(height: 6),

        Text(
          guestMobile,
          textAlign: TextAlign.center,
          style: TextStyle(color: ColorResources.text),
        ),

        SizedBox(height: 10),

        Text(
          'Guest preview — sample data',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: ColorResources.lightText,
          ),
        ),

        SizedBox(height: 24),

        card(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorResources.primary,
                ),
              ),
              SizedBox(height: 12),
              information('FULL NAME', guestName),
              information('MOBILE NUMBER', guestMobile),
              information('EMAIL ADDRESS', guestEmail),
            ],
          ),
        ),

        SizedBox(height: 20),

        card(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivery Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorResources.primary,
                ),
              ),
              SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ColorResources.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  guestAddress,
                  style: TextStyle(
                    height: 1.6,
                    color: ColorResources.text,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            ).then((value) {
              // Come back to this screen and reload after a login.
              loadUser();
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorResources.button,
            foregroundColor: ColorResources.buttonText,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Login to See Your Details',
            style: TextStyle(fontSize: 18),
          ),
        ),

        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GuestPage(
      title: 'My Profile',
      selectedIndex: 4,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: ColorResources.primary,
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (isGuest)
                    guestView()
                  else ...[
                    SizedBox(height: 12),

                    // A logged in user has no photo yet, so the first letter
                    // of the name is shown inside a circle instead.
                    Center(
                      child: Container(
                        width: 96,
                        height: 96,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorResources.background,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ColorResources.border,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          nameFirstLetter,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: ColorResources.primary,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    Text(
                      userName.isEmpty ? 'PlyConnect User' : userName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.primary,
                      ),
                    ),

                    SizedBox(height: 8),

                    if (userEmail.isNotEmpty)
                      Text(
                        userEmail,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorResources.text),
                      ),

                    if (userMobile.isNotEmpty) ...[
                      SizedBox(height: 6),
                      Text(
                        '+91 $userMobile',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorResources.text),
                      ),
                    ],

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
                                  openPageAndRefresh(EditProfilePage());
                                },
                                child: Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    color: ColorResources.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          information(
                            'FULL NAME',
                            userName.isEmpty ? 'Not given' : userName,
                          ),
                          information(
                            'MOBILE NUMBER',
                            userMobile.isEmpty
                                ? 'Not given'
                                : '+91 $userMobile',
                          ),
                          information(
                            'EMAIL ADDRESS',
                            userEmail.isEmpty ? 'Not given' : userEmail,
                          ),
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
                                    color: ColorResources.primary,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  openPageAndRefresh(EditAddressPage());
                                },
                                child: Text(
                                  'Edit Address',
                                  style: TextStyle(
                                    color: ColorResources.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12),

                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: ColorResources.background,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              userAddress.isEmpty
                                  ? 'No delivery address saved yet.'
                                  : userAddress,
                              style: TextStyle(
                                height: 1.6,
                                color: ColorResources.text,
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
                            Icons.favorite_border,
                            'My Wishlist',
                            WishlistPage(),
                          ),
                          Divider(height: 1, color: ColorResources.border),
                          menuItem(
                            Icons.receipt_long_outlined,
                            'My Orders',
                            MyOrdersPage(),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    card(
                      Column(
                        children: [
                          menuItem(
                            Icons.lock_outline,
                            'Change Password',
                            ChangePasswordPage(),
                          ),
                          Divider(height: 1, color: ColorResources.border),
                          menuItem(
                            Icons.logout,
                            'Logout',
                            null,
                          ),
                        ],
                      ),
                    ),
                  ],

                  SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
