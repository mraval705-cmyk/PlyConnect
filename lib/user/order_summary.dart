import 'package:flutter/material.dart';
import '../components/guest_page.dart';
import '../resources/app_colors.dart';

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
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
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
                color: AppColors.text,
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: bold ? 18 : 14,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: AppColors.primary,
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
                  color: AppColors.lightText,
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
                            'assets/images/wishlist_product.png',
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
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'CenturyPly • 19 mm • 8 × 4 ft',
                                style: TextStyle(color: AppColors.text),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '₹145 / sq.ft',
                                style: TextStyle(color: AppColors.primary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),
                    Divider(color: AppColors.border),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Quantity',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.heading,
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
                          color: AppColors.primary,
                        ),
                        Text(
                          '$quantity',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.primary,
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
                          color: AppColors.primary,
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
                              color: AppColors.primary,
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
                            style: TextStyle(color: AppColors.primary),
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
                          color: AppColors.text,
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
                  color: AppColors.primary,
                ),
              ),

              SizedBox(height: 10),

              TextField(
                controller: instructionsController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Add delivery instructions (optional)',
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.border),
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
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 12),
                    priceRow(
                      'One Sheet (32 sq.ft)',
                      '₹${sheetPrice.toStringAsFixed(2)}',
                    ),
                    priceRow('Quantity', '$quantity'),
                    Divider(color: AppColors.border),
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
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  if (addressController.text.trim().isEmpty) {
                    showMessage('Please enter your delivery address.');
                    return;
                  }

                  showMessage(
                    'Total: ₹$total. Payment page will be connected later.',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
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
                  style: TextStyle(color: AppColors.text),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}