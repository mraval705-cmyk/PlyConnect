
/// A customer order, kept as an object instead of loose values.
class OrderModel {
  final String orderId;
  final String customerName;
  final String productName;
  final double total;
  final int quantity;
  final String status;
  final String date;

  const OrderModel({
    required this.orderId,
    required this.customerName,
    required this.productName,
    required this.total,
    required this.quantity,
    required this.status,
    required this.date,
  });

  /// Turns a Firestore document into an OrderModel.
  factory OrderModel.fromMap(Map<String, dynamic> data) {
    return OrderModel(
      orderId: '${data['orderId'] ?? ''}',
      customerName: '${data['customerName'] ?? 'Guest'}',
      productName: '${data['name'] ?? ''}',
      total: (data['total'] is num)
          ? (data['total'] as num).toDouble()
          : double.tryParse('${data['total']}') ?? 0,
      quantity: (data['quantity'] is num)
          ? (data['quantity'] as num).toInt()
          : int.tryParse('${data['quantity']}') ?? 1,
      status: '${data['status'] ?? 'Pending'}',
      date: '${data['date'] ?? ''}',
    );
  }

  /// How far along the order is, from 0 to 3. Used for the progress bar.
  int get step {
    switch (status) {
      case 'Pending':
        return 0;
      case 'Confirmed':
      case 'Processing':
        return 1;
      case 'Shipped':
        return 2;
      case 'Delivered':
        return 3;
      default:
        return 0;
    }
  }

  /// A short description of where the order is right now.
  String get statusLine {
    switch (status) {
      case 'Pending':
        return 'Waiting for the shop to confirm';
      case 'Confirmed':
        return 'Confirmed by the shop';
      case 'Processing':
        return 'Being prepared';
      case 'Shipped':
        return 'On the way';
      case 'Delivered':
        return 'Delivered';
      default:
        return status;
    }
  }
}