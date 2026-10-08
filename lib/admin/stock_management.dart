import 'package:flutter/material.dart';
import '../components/admin/touch_slider.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';

class StockManagementPage extends StatefulWidget {
  const StockManagementPage({super.key});

  @override
  State<StockManagementPage> createState() => _StockManagementPageState();
}

class _StockManagementPageState extends State<StockManagementPage> {
  String search = '';

  // The bar decides how low the stock has to be before it is called low.
  double lowLimit = 20;

  // A working copy of the sample list, so the count can be changed while the
  // app is running.
  final List<Map<String, dynamic>> items =
      List<Map<String, dynamic>>.from(SampleData.stock);

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Color statusColor(String status) {
    if (status == 'Out of Stock') return ColorResources.danger;
    if (status == 'Low Stock') return ColorResources.warning;
    return ColorResources.success;
  }

  /// Works out the status again after the count changed.
  void refreshStatus(Map<String, dynamic> item) {
    final value = item['stock'] as int;

    item['status'] = value == 0
        ? 'Out of Stock'
        : (value < lowLimit ? 'Low Stock' : 'In Stock');
  }

  /// Opens a dialog and changes the count of one item.
  void editCount(Map<String, dynamic> item) {
    final current = item['stock'];
    final controller = TextEditingController(text: '$current');

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: ColorResources.background,
          title: const Text('Update Stock'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${item['name']}'),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Sheets in stock'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final value = int.tryParse(controller.text.trim()) ?? 0;

                setState(() {
                  item['stock'] = value;
                  refreshStatus(item);
                });

                Navigator.pop(dialogContext);
                showMessage('${item['name']} now has $value sheets.');
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  /// Adds or removes ten sheets with one tap, from inside the expanded part.
  void changeBy(Map<String, dynamic> item, int step) {
    setState(() {
      final value = (item['stock'] as int) + step;
      item['stock'] = value < 0 ? 0 : value;
      refreshStatus(item);
    });
  }

  /// The +10 and -10 buttons. They sit in the card itself, so they are always
  /// visible without opening anything.
  Widget buildCountButtons(Map<String, dynamic> item) {
    final count = item['stock'] as int;

    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: count == 0
                ? null
                : () {
                    changeBy(item, -10);
                    showMessage('${item['name']} reduced to ${count - 10}.');
                  },
            icon: const Icon(Icons.remove, size: 18),
            label: const Text('10'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              changeBy(item, 10);
              showMessage('${item['name']} now has ${count + 10}.');
            },
            icon: const Icon(Icons.add, size: 18),
            label: const Text('10'),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorResources.primary,
              foregroundColor: ColorResources.white,
            ),
          ),
        ),
      ],
    );
  }

  /// The box that opens when a stock item is tapped.
  Widget buildDetails(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: ColorResources.border),
          const SizedBox(height: 8),

          Row(
            children: [
              Text(
                'Item id: ${item['id']}',
                style: const TextStyle(
                  fontSize: 12,
                  color: ColorResources.lightText,
                ),
              ),
              const Spacer(),
              Text(
                '${item['unit']}',
                style: const TextStyle(
                  fontSize: 12,
                  color: ColorResources.lightText,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // A small bar that shows how full the stock is.
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: ((item['stock'] as int) / 100).clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: ColorResources.background,
              color: statusColor('${item['status']}'),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => editCount(item),
              icon: const Icon(Icons.edit_outlined, size: 18),
              label: const Text('Type a new count'),
            ),
          ),
        ],
      ),
    );
  }

  Widget stockCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorResources.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorResources.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${item['id']}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: ColorResources.primary,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item['name']}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.heading,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item['brand']}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: ColorResources.lightText,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${item['stock']} ${item['unit']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorResources.primary,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: ColorResources.background,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ColorResources.border),
                ),
                child: Text(
                  '${item['status']}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: statusColor('${item['status']}'),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // The +10 and -10 buttons are always visible.
          buildCountButtons(item),

          // ExpansionTile opens the extra details of the item.
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              title: const Text(
                'More details',
                style: TextStyle(
                  fontSize: 12,
                  color: ColorResources.primary,
                ),
              ),
              children: [buildDetails(item)],
            ),
          ),
        ],
      ),
    );
  }

  /// The bar that sets the low stock limit. Touching anywhere jumps the
  /// handle to that spot and shows the value above it.
  Widget buildFilterBox() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorResources.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Low stock limit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorResources.heading,
                ),
              ),
              const Spacer(),
              // The two small buttons are easier than fine dragging.
              IconButton(
                tooltip: 'Less',
                onPressed: lowLimit <= 5
                    ? null
                    : () => setLowLimit(lowLimit - 5),
                icon: const Icon(Icons.remove_circle_outline),
              ),
              IconButton(
                tooltip: 'More',
                onPressed: lowLimit >= 50
                    ? null
                    : () => setLowLimit(lowLimit + 5),
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),

          const SizedBox(height: 18),

          TouchSlider(
            value: lowLimit,
            min: 5,
            max: 50,
            suffix: 'sheets',
            onChanged: setLowLimit,
          ),
        ],
      ),
    );
  }

  /// Keeps the new limit and works out the status of every item again.
  void setLowLimit(double value) {
    setState(() {
      lowLimit = value.clamp(5, 50);
      for (final item in items) {
        refreshStatus(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // where() filters the sample list, the same way it would filter live data.
    final visible = items.where((item) {
      final name = '${item['name']}'.toLowerCase();
      final brand = '${item['brand']}'.toLowerCase();
      return name.contains(search) || brand.contains(search);
    }).toList();

    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: const Text('Stock Management'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search Stock',
                  prefixIcon: Icon(Icons.search, color: ColorResources.primary),
                ),
                onChanged: (value) {
                  setState(() {
                    search = value.trim().toLowerCase();
                  });
                },
              ),
            ),

            buildFilterBox(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${visible.length} items shown',
                  style: const TextStyle(color: ColorResources.text),
                ),
              ),
            ),

            Expanded(
              child: visible.isEmpty
                  ? const Center(
                      child: Text(
                        'No stock item found.',
                        style: TextStyle(color: ColorResources.text),
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(16),
                      children: visible.map(stockCard).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}