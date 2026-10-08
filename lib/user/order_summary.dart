import 'package:flutter/material.dart';
import '../components/guest_page.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';
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

  final int pricePerSquareFoot = 145;
  final int sheetArea = 32;

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
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

  Widget priceRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
          const SizedBox(width: 12),
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
    // The maths is done here, so the total always matches the quantity.
    final sheetPrice = pricePerSquareFoot * sheetArea;
    final total = sheetPrice * quantity;

    return GuestPage(
      title: 'Order Summary',
      selectedIndex: 3,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Club Prime Plywood',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ColorResources.primary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'CenturyPly • 19 mm • 8 × 4 ft',
                                style: TextStyle(color: ColorResources.text),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '₹145 / sq.ft',
                                style: TextStyle(color: ColorResources.primary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    Divider(color: ColorResources.border),

                    Row(
                      children: [
                        const Expanded(
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
                          icon: const Icon(Icons.remove_circle_outline),
                          color: ColorResources.primary,
                        ),
                        Text(
                          '$quantity',
                          style: const TextStyle(
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
                          icon: const Icon(Icons.add_circle_outline),
                          color: ColorResources.primary,
                        ),
                      ],
                    ),
                  ],
                ),
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
                            style: const TextStyle(color: ColorResources.primary),
                          ),
                        ),
                      ],
                    ),

                    if (editAddress)
                      TextFormField(
                        controller: addressController,
                        minLines: 2,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: 'Enter your delivery address',
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
                        style: const TextStyle(
                          height: 1.6,
                          color: ColorResources.text,
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Delivery Instructions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorResources.primary,
                ),
              ),

              const SizedBox(height: 10),

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
                    borderSide: const BorderSide(color: ColorResources.border),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              card(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Price Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
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

              const SizedBox(height: 28),

              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  if (addressController.text.trim().isEmpty) {
                    showMessage('Please enter your delivery address.');
                    return;
                  }

                  // The order is not sent anywhere yet, so the payment
                  // screen simply opens.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(
                        quantity: quantity,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.primary,
                  foregroundColor: ColorResources.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Continue to Payment'),
              ),

              const SizedBox(height: 8),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
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