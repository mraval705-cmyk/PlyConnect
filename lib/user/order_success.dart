import 'package:flutter/material.dart';
import '../components/guest_page.dart';
import '../resources/app_colors.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget detailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: AppColors.text),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GuestPage(
      title: 'Order Successful',
      selectedIndex: 3,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'DEMO PREVIEW — no actual order submitted',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.lightText,
              ),
            ),

            SizedBox(height: 24),

            Icon(
              Icons.check_circle,
              size: 76,
              color: AppColors.primary,
            ),

            SizedBox(height: 20),

            Text(
              'Order Placed Successfully!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.heading,
              ),
            ),

            SizedBox(height: 12),

            Text(
              'Thank you for your order. Your order '
              'has been successfully placed.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: AppColors.text,
              ),
            ),

            SizedBox(height: 32),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  detailRow('ORDER ID', '#ORD-98765'),

                  Divider(color: AppColors.border),

                  SizedBox(height: 12),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/wishlist_product.png',
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Club Prime Plywood',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.heading,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '1 Sheet',
                              style: TextStyle(color: AppColors.text),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '₹4,640.00',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  detailRow('Payment Method', 'Cash on Delivery'),
                  detailRow('Order Date', 'October 24, 2023'),
                  detailRow('Estimated Delivery', 'October 27, 2023'),
                ],
              ),
            ),

            SizedBox(height: 28),

            ElevatedButton.icon(
              onPressed: () {
                showMessage(
                  context,
                  'Invoice generation is not connected yet.',
                );
              },
              icon: Icon(Icons.receipt_long_outlined),
              label: Text('View Invoice'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: () {
                showMessage(
                  context,
                  'My Orders will be connected later.',
                );
              },
              icon: Icon(Icons.local_shipping_outlined),
              label: Text('My Orders'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(color: AppColors.primary),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 12),

            TextButton(
              onPressed: () {
                showMessage(
                  context,
                  'Home will be connected later.',
                );
              },
              child: Text(
                'Continue Shopping',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}