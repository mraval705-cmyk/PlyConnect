import 'package:flutter/material.dart';
import '../components/guest_page.dart';
import '../resources/app_colors.dart';

class ContactShopPage extends StatelessWidget {
  const ContactShopPage({super.key});

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget contactAction(
    BuildContext context,
    IconData icon,
    String label,
  ) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          showMessage(context, '$label will be connected later.');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.button,
          foregroundColor: AppColors.white,
          padding: EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          children: [
            Icon(icon),
            SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget information(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          color: AppColors.text,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.heading,
        ),
      ),
    );
  }

  Widget section(IconData icon, String title, Widget content) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GuestPage(
      title: 'Contact Shop',
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 100,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'PlyConnect Plywood Store',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.heading,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Contact us for product availability, '
                    'pricing and order confirmation.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                contactAction(context, Icons.call_outlined, 'Call Now'),
                SizedBox(width: 8),
                contactAction(context, Icons.mail_outline, 'Send Email'),
                SizedBox(width: 8),
                contactAction(
                  context,
                  Icons.message_outlined,
                  'Text Message',
                ),
              ],
            ),

            SizedBox(height: 20),

            Text(
              'Sample contact details from Figma',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.lightText,
              ),
            ),

            SizedBox(height: 8),

            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  information(
                    Icons.person_outline,
                    'Owner Name',
                    'Rajesh Kumar',
                  ),
                  Divider(height: 1, color: AppColors.border),
                  information(
                    Icons.phone_outlined,
                    'Mobile',
                    '+91 98765 43210',
                  ),
                  Divider(height: 1, color: AppColors.border),
                  information(
                    Icons.mail_outline,
                    'Email',
                    'contact@plyconnect.com',
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            section(
              Icons.access_time,
              'Working Hours',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Monday to Saturday',
                    style: TextStyle(color: AppColors.text),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '9:00 AM – 7:00 PM',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.heading,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Closed on Sundays & National Holidays',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            section(
              Icons.location_on_outlined,
              'Shop Address',
              Text(
                'Plot No. 45, Industrial Area, Phase 2,\n'
                'New Delhi - 110020',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: AppColors.text,
                ),
              ),
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}