import 'package:flutter/material.dart';
import '../components/admin/animated_number.dart';
import '../models/order_model.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';

/// Shows how the shop is doing. Every number is calculated from the sample
/// list with fold, where and sort.
class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  // The dates the admin picks for the report.
  DateTime fromDate = DateTime(2026, 1, 1);
  DateTime toDate = DateTime(2026, 12, 31);

  // Report can be split by brand or by category.
  String groupBy = 'Brand';

  // True when the whole date range is used.
  bool allDates = true;

  /// Opens the calendar and stores whichever end the admin is editing.
  Future<void> pickDate(bool isStart) async {
    final date = await showDatePicker(
      context: context,
      initialDate: isStart ? fromDate : toDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (date == null) return;

    setState(() {
      allDates = false;
      if (isStart) {
        fromDate = date;
      } else {
        toDate = date;
      }
    });
  }

  /// Turns "28 Sep 2026" into a real DateTime so it can be compared.
  DateTime readOrderDate(String text) {
    final parts = text.split(' ');

    if (parts.length < 3) {
      return DateTime(2026);
    }

    const months = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12,
    };

    final day = int.tryParse(parts[0]) ?? 1;
    final month = months[parts[1]] ?? 1;
    final year = int.tryParse(parts[2]) ?? 2026;

    return DateTime(year, month, day);
  }

  /// Total money of a list of orders, worked out with fold.
  double totalRevenue(List<Map<String, dynamic>> orderList) {
    return orderList.fold<double>(0, (sum, order) {
      final value = order['total'];
      if (value is num) {
        return sum + value.toDouble();
      }
      return sum + (double.tryParse('$value') ?? 0);
    });
  }

  /// Adds up the money of each brand or each category.
  Map<String, double> groupedMoney(List<Map<String, dynamic>> orderList) {
    final result = <String, double>{};

    for (final order in orderList) {
      final key = groupBy == 'Brand'
          ? '${order['brand']}'
          : '${order['category'] ?? 'General'}';

      final value = order['total'];
      final money = value is num ? value.toDouble() : 0;

      result[key] = (result[key] ?? 0) + money;
    }

    return result;
  }

  Widget buildHeader(double revenue, int orderCount) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [ColorResources.primary, ColorResources.button],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TOTAL REVENUE',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1,
              color: ColorResources.buttonText,
            ),
          ),
          const SizedBox(height: 10),
          AnimatedNumber(
            value: revenue,
            prefix: '₹',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: ColorResources.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'from $orderCount orders',
            style: const TextStyle(color: ColorResources.buttonText),
          ),
        ],
      ),
    );
  }

  Widget buildMiniStat(String label, int count) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorResources.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: ColorResources.lightText,
            ),
          ),
          const SizedBox(height: 8),
          AnimatedNumber(
            value: count.toDouble(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorResources.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBigOrder(OrderModel order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorResources.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorResources.heading,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  order.customerName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorResources.lightText,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '₹${order.total.toStringAsFixed(0)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorResources.primary,
            ),
          ),
        ],
      ),
    );
  }

  /// The date range picker row, using two showDatePicker calls.
  Widget buildDateRow() {
    String show(DateTime date) =>
        '${date.day}/${date.month}/${date.year}';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorResources.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Switch to turn the date filter on or off.
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: allDates,
            activeColor: ColorResources.primary,
            title: const Text(
              'All dates',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorResources.heading,
              ),
            ),
            subtitle: const Text(
              'Turn off to pick a range',
              style: TextStyle(fontSize: 12),
            ),
            onChanged: (value) {
              setState(() {
                allDates = value ?? true;
              });
            },
          ),

          if (!allDates) ...[
            const Divider(color: ColorResources.border),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => pickDate(true),
                    icon: const Icon(Icons.event),
                    label: Text('From ${show(fromDate)}'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => pickDate(false),
                    icon: const Icon(Icons.event_available),
                    label: Text('To ${show(toDate)}'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// The money of each brand or category, shown as a Table.
  Widget buildGroupTable(List<Map<String, dynamic>> orderList) {
    final money = groupedMoney(orderList);

    // sort the entries so the biggest earner is on top.
    final entries = money.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    if (entries.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'No orders in this date range.',
          style: TextStyle(color: ColorResources.text),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorResources.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dropdown chooses what the report is grouped by.
          DropdownButton<String>(
            value: groupBy,
            items: ['Brand', 'Category'].map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text('Group by $option'),
              );
            }).toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                groupBy = value;
              });
            },
          ),

          const SizedBox(height: 12),

          Table(
            border: TableBorder.all(color: ColorResources.border),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: ColorResources.background,
                ),
                children: [
                  Text(
                    groupBy,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Orders',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Money',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // One row for every brand or category that was found.
              ...entries.map((entry) {
                final count = orderList.where((order) {
                  final key = groupBy == 'Brand'
                      ? '${order['brand']}'
                      : '${order['category'] ?? 'General'}';
                  return key == entry.key;
                }).length;

                return TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        entry.key,
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        '$count',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        '₹${entry.value.toStringAsFixed(0)}',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: ColorResources.primary,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // where - first the date range the admin picked.
    final orderList = allDates
        ? SampleData.orders
        : SampleData.orders.where((order) {
            final date = readOrderDate('${order['date']}');
            return !date.isBefore(fromDate) && !date.isAfter(toDate);
          }).toList();

    final revenue = totalRevenue(orderList);

    // where - how many are still not delivered.
    final open =
        orderList.where((order) => order['status'] != 'Delivered').length;

    // where - orders above a certain value.
    final big = orderList.where((order) {
      final value = order['total'];
      return (value is num ? value.toDouble() : 0) > 15000;
    }).length;

    // map then sort then take - the biggest orders.
    final models = orderList.map((order) => OrderModel.fromMap(order)).toList()
      ..sort((a, b) => b.total.compareTo(a.total));

    // How much of the money the delivered orders account for.
    final deliveredMoney = orderList
        .where((order) => order['status'] == 'Delivered')
        .fold<double>(0, (sum, order) {
      final value = order['total'];
      return sum + (value is num ? value.toDouble() : 0);
    });

    final deliveredShare = revenue == 0 ? 0.0 : deliveredMoney / revenue * 100;

    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: const Text('Sales Report'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(revenue, orderList.length),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(child: buildMiniStat('OPEN ORDERS', open)),
                const SizedBox(width: 12),
                Expanded(child: buildMiniStat('BIG ORDERS', big)),
              ],
            ),

            const SizedBox(height: 16),

            buildDateRow(),

            const SizedBox(height: 16),

            buildGroupTable(orderList),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorResources.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorResources.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Delivered share',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorResources.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  AnimatedBar(
                    percent: deliveredShare / 100,
                    color: ColorResources.success,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${deliveredShare.toStringAsFixed(0)}% of the money is from delivered orders',
                    style: const TextStyle(
                      fontSize: 12,
                      color: ColorResources.text,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'BIGGEST ORDERS',
              style: TextStyle(
                fontSize: 11,
                letterSpacing: 1,
                color: ColorResources.lightText,
              ),
            ),
            const SizedBox(height: 12),

            ...models.take(5).map(buildBigOrder),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}