import 'package:flutter/material.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';

class StockManagementPage extends StatefulWidget {
  const StockManagementPage({super.key});

  @override
  State<StockManagementPage> createState() => _StockManagementPageState();
}

class _StockManagementPageState extends State<StockManagementPage> {
  String search = '';

  // The slider decides how low the stock has to be before it is called low.
  double lowLimit = 20;

  // When true only the items under the slider are shown.
  bool showOnlyLow = false;

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

          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () => changeBy(item, -10),
                icon: const Icon(Icons.remove),
                label: const Text('10'),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: () => changeBy(item, 10),
                icon: const Icon(Icons.add),
                label: const Text('10'),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => editCount(item),
                child: const Text('Edit'),
              ),
            ],
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

          // ExpansionTile opens the extra controls of the item.
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              title: const Text(
                'Update stock',
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

  /// The slider and the checkbox that filter the list.
  Widget buildFilterBox() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.all(16),
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
              Text(
                '${lowLimit.round()} sheets',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorResources.primary,
                ),
              ),
            ],
          ),

          // Slider chooses the limit.
          Slider(
            value: lowLimit,
            min: 5,
            max: 50,
            divisions: 9,
            label: '${lowLimit.round()} sheets',
            activeColor: ColorResources.primary,
            onChanged: (value) {
              setState(() {
                lowLimit = value;
                for (final item in items) {
                  refreshStatus(item);
                }
              });
            },
          ),

          // Checkbox shows only the items that need restocking.
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: showOnlyLow,
            activeColor: ColorResources.primary,
            title: const Text(
              'Show low stock only',
              style: TextStyle(fontSize: 13),
            ),
            onChanged: (value) {
              setState(() {
                showOnlyLow = value ?? false;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // where() filters the sample list, the same way it would filter live data.
    final visible = items.where((item) {
      final name = '${item['name']}'.toLowerCase();
      final brand = '${item['brand']}'.toLowerCase();
      final matchesSearch = name.contains(search) || brand.contains(search);

      final matchesLow = !showOnlyLow ||
          (item['stock'] as int) < lowLimit ||
          item['status'] == 'Out of Stock';

      return matchesSearch && matchesLow;
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