import 'package:flutter/material.dart';
import '../components/guest_page.dart';
import '../guest/browse_products.dart';
import '../resources/color_resources.dart';
import 'my_orders.dart';

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
              style: TextStyle(color: ColorResources.text),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorResources.primary,
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
                color: ColorResources.lightText,
              ),
            ),

            SizedBox(height: 24),

            Icon(
              Icons.check_circle,
              size: 76,
              color: ColorResources.primary,
            ),

            SizedBox(height: 20),

            Text(
              'Order Placed Successfully!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: ColorResources.heading,
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
                color: ColorResources.text,
              ),
            ),

            SizedBox(height: 32),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorResources.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorResources.border),
              ),
              child: Column(
                children: [
                  detailRow('ORDER ID', '#ORD-98765'),

                  Divider(color: ColorResources.border),

                  SizedBox(height: 12),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/club_prime.png',
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
                                color: ColorResources.heading,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '1 Sheet',
                              style: TextStyle(color: ColorResources.text),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '₹4,640.00',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ColorResources.primary,
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
                backgroundColor: ColorResources.button,
                foregroundColor: ColorResources.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyOrdersPage(),
                  ),
                );
              },
              icon: Icon(Icons.local_shipping_outlined),
              label: Text('My Orders'),
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorResources.primary,
                side: BorderSide(color: ColorResources.primary),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 12),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BrowseProductsPage(),
                  ),
                );
              },
              child: Text(
                'Continue Shopping',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorResources.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}