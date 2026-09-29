import 'package:flutter/material.dart';
import '../components/guest_page.dart';
import '../resources/color_resources.dart';
import 'order_success.dart';

class PaymentPage extends StatefulWidget {
  final int quantity;

  const PaymentPage({
    super.key,
    this.quantity = 1,
  }) : assert(quantity > 0);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String paymentMethod = 'Cash on Delivery';

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget paymentOption(String title, IconData icon) {
    final selected = paymentMethod == title;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? ColorResources.primary : ColorResources.border,
          width: selected ? 2 : 1,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: Icon(icon, color: ColorResources.primary),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorResources.heading,
          ),
        ),
        subtitle: title == 'Cash on Delivery'
            ? Text(
                'RECOMMENDED',
                style: TextStyle(
                  fontSize: 10,
                  color: ColorResources.lightText,
                ),
              )
            : Text(
                'Demo option — gateway not connected',
                style: TextStyle(
                  fontSize: 11,
                  color: ColorResources.lightText,
                ),
              ),
        trailing: Icon(
          selected
              ? Icons.radio_button_checked
              : Icons.radio_button_unchecked,
          color: ColorResources.primary,
        ),
        onTap: () {
          setState(() {
            paymentMethod = title;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = 4640 * widget.quantity;

    return GuestPage(
      title: 'Payment Method',
      selectedIndex: 3,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 12),

            Text(
              'ORDER SUMMARY',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorResources.lightText,
              ),
            ),

            SizedBox(height: 12),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorResources.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorResources.border),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/payment_product.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
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
                        SizedBox(height: 8),
                        Text(
                          'Quantity: ${widget.quantity} '
                          '${widget.quantity == 1 ? 'Sheet' : 'Sheets'}',
                          style: TextStyle(color: ColorResources.lightText),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '₹${total.toStringAsFixed(2)}',
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
            ),

            SizedBox(height: 32),

            Text(
              'SELECT PAYMENT OPTION',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorResources.lightText,
              ),
            ),

            SizedBox(height: 16),

            paymentOption(
              'Cash on Delivery',
              Icons.payments_outlined,
            ),

            paymentOption(
              'Razorpay',
              Icons.credit_card,
            ),

            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorResources.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorResources.border),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Total Amount',
                          style: TextStyle(color: ColorResources.text),
                        ),
                      ),
                      Text(
                        '₹${total.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorResources.primary,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Payment Mode',
                          style: TextStyle(color: ColorResources.text),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          paymentMethod,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorResources.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),

            ElevatedButton(
              onPressed: () {
                if (paymentMethod == 'Razorpay') {
                  showMessage(
                    'Razorpay is not connected. No payment was made.',
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderSuccessPage(),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorResources.primary,
                foregroundColor: ColorResources.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Confirm Order'),
            ),

            SizedBox(height: 12),

            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorResources.primary,
                side: BorderSide(color: ColorResources.border),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Back'),
            ),

            SizedBox(height: 16),

            Text(
              'Demo screen — no order or payment is submitted.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: ColorResources.lightText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}