import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/guest_page.dart';
import '../resources/color_resources.dart';
import 'payment.dart';

class OrderSummaryPage extends StatefulWidget {
  const OrderSummaryPage({super.key});

  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  final _formKey = GlobalKey<FormState>();

  final addressController = TextEditingController(
    text: '123, 4th Floor, Hemkunt Tower, Nehru Place,\n'
        'New Delhi - 110019',
  );

  final instructionsController = TextEditingController();

  int quantity = 1;
  bool editAddress = false;
  bool isSaving = false;

  // Builds a readable order number such as ORD-48213.
  String makeOrderId() {
    return 'ORD-${DateTime.now().millisecondsSinceEpoch % 100000}';
  }

  String makeDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year;
    return '$day/$month/$year';
  }

  // Writes the order into the shared "orders" collection so that both the
  // customer and the shop owner can see it.
  Future<void> saveOrder() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      showMessage('Please login before placing an order.');
      return;
    }

    setState(() {
      isSaving = true;
    });

    final total = pricePerSquareFoot * sheetArea * quantity;

    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'orderId': makeOrderId(),
        'userId': currentUser.uid,
        'customerName': currentUser.displayName ?? currentUser.email ?? '',
        'name': 'Club Prime Plywood',
        'brand': 'CenturyPly',
        'thickness': '19 mm',
        'quantity': quantity,
        'total': total.toStringAsFixed(2),
        'address': addressController.text.trim(),
        'instructions': instructionsController.text.trim(),
        'status': 'Pending',
        'date': makeDate(),
        'image': 'assets/images/club_prime.png',
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        isSaving = false;
      });
      showMessage('Could not place the order. $error');
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      isSaving = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(quantity: quantity),
      ),
    );
  }

  final int pricePerSquareFoot = 145;
  final int sheetArea = 32;

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
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

  Widget priceRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: bold ? 18 : 14,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                color: ColorResources.text,
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: bold ? 18 : 14,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: ColorResources.primary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sheetPrice = pricePerSquareFoot * sheetArea;
    final total = sheetPrice * quantity;

    return GuestPage(
      title: 'Order Summary',
      selectedIndex: 3,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Demo order — sample product and address',
                style: TextStyle(
                  fontSize: 12,
                  color: ColorResources.lightText,
                ),
              ),

              SizedBox(height: 12),

              card(
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/club_prime.png',
                            width: 80,
                            height: 90,
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ColorResources.primary,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'CenturyPly • 19 mm • 8 × 4 ft',
                                style: TextStyle(color: ColorResources.text),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '₹145 / sq.ft',
                                style: TextStyle(color: ColorResources.primary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),
                    Divider(color: ColorResources.border),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Quantity',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorResources.heading,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Decrease quantity',
                          onPressed: quantity > 1
                              ? () {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              : null,
                          icon: Icon(Icons.remove_circle_outline),
                          color: ColorResources.primary,
                        ),
                        Text(
                          '$quantity',
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorResources.primary,
                          ),
                        ),
                        IconButton(
                          tooltip: 'Increase quantity',
                          onPressed: quantity < 99
                              ? () {
                                  setState(() {
                                    quantity++;
                                  });
                                }
                              : null,
                          icon: Icon(Icons.add_circle_outline),
                          color: ColorResources.primary,
                        ),
                      ],
                    ),
                  ],
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
                            'Delivery Address',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ColorResources.primary,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (editAddress &&
                                !_formKey.currentState!.validate()) {
                              return;
                            }

                            setState(() {
                              editAddress = !editAddress;
                            });
                          },
                          child: Text(
                            editAddress ? 'Save' : 'Edit Address',
                            style: TextStyle(color: ColorResources.primary),
                          ),
                        ),
                      ],
                    ),

                    if (editAddress)
                      TextFormField(
                        controller: addressController,
                        minLines: 2,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Enter your delivery address',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      )
                    else
                      Text(
                        addressController.text,
                        style: TextStyle(
                          height: 1.6,
                          color: ColorResources.text,
                        ),
                      ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              Text(
                'Delivery Instructions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorResources.primary,
                ),
              ),

              SizedBox(height: 10),

              TextField(
                controller: instructionsController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Add delivery instructions (optional)',
                  filled: true,
                  fillColor: ColorResources.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: ColorResources.border),
                  ),
                ),
              ),

              SizedBox(height: 24),

              card(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.primary,
                      ),
                    ),
                    SizedBox(height: 12),
                    priceRow(
                      'One Sheet (32 sq.ft)',
                      '₹${sheetPrice.toStringAsFixed(2)}',
                    ),
                    priceRow('Quantity', '$quantity'),
                    Divider(color: ColorResources.border),
                    priceRow(
                      'Total Amount',
                      '₹${total.toStringAsFixed(2)}',
                      bold: true,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28),

              ElevatedButton(
                onPressed: isSaving ? null : () {
                  if (!_formKey.currentState!.validate()) return;

                  if (addressController.text.trim().isEmpty) {
                    showMessage('Please enter your delivery address.');
                    return;
                  }

                  saveOrder();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.primary,
                  foregroundColor: ColorResources.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Continue to Payment'),
              ),

              SizedBox(height: 8),

              TextButton(
                onPressed: () {
                  showMessage(
                    'No order has been submitted. '
                    'Back navigation will be connected later.',
                  );
                },
                child: Text(
                  'Cancel Order',
                  style: TextStyle(color: ColorResources.text),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}