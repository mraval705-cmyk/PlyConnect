import 'package:flutter/material.dart';
import '../components/admin/loading_ring.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';

class ManageCustomersPage extends StatefulWidget {
  const ManageCustomersPage({super.key});

  @override
  State<ManageCustomersPage> createState() => _ManageCustomersPageState();
}

class _ManageCustomersPageState extends State<ManageCustomersPage> {
  String search = '';

  final List<Map<String, dynamic>> customers =
      List<Map<String, dynamic>>.from(SampleData.customers);

  String initialOf(String name) {
    if (name.isEmpty) return '?';
    return name[0].toUpperCase();
  }

  /// How many sample orders belong to this customer, worked out with where.
  int orderCountOf(String userId) {
    return SampleData.orders.where((order) {
      return order['userId'] == userId;
    }).length;
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Pretends the list is being fetched, the way a real database call would
  /// take a moment. Later the same function will hold a Firestore query.
  Future<List<Map<String, dynamic>>> loadCustomers() {
    return Future<List<Map<String, dynamic>>>.delayed(
      const Duration(milliseconds: 500),
      () => customers,
    );
  }

  /// Called by RefreshIndicator when the list is pulled down.
  Future<void> reload() async {
    await loadCustomers();
    showMessage('Customer list refreshed.');
  }

  Widget customerCard(Map<String, dynamic> customer) {
    final userId = '${customer['id']}';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorResources.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorResources.background,
              shape: BoxShape.circle,
              border: Border.all(color: ColorResources.border),
            ),
            child: Text(
              initialOf('${customer['name']}'),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
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
                  '${customer['name']}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.heading,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${customer['email']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorResources.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '+91 ${customer['mobile']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorResources.lightText,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: ColorResources.background,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${orderCountOf(userId)} Orders',
                    style: const TextStyle(
                      fontSize: 11,
                      color: ColorResources.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            tooltip: 'Call customer',
            onPressed: () {
              showMessage('Calling will be connected later.');
            },
            icon: const Icon(
              Icons.call_outlined,
              color: ColorResources.primary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // where() filters the sample list, the same way it would filter live data.
    final visible = customers.where((customer) {
      final name = '${customer['name']}'.toLowerCase();
      final email = '${customer['email']}'.toLowerCase();
      final mobile = '${customer['mobile']}';
      return name.contains(search) ||
          email.contains(search) ||
          mobile.contains(search);
    }).toList();

    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: const Text('Manage Customers'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorResources.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorResources.border),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.people_outline,
                    color: ColorResources.primary,
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${customers.length}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: ColorResources.primary,
                          ),
                        ),
                        const Text(
                          'Total Customers',
                          style: TextStyle(color: ColorResources.text),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search Customer',
                  prefixIcon: Icon(
                    Icons.search,
                    color: ColorResources.primary,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    search = value.trim().toLowerCase();
                  });
                },
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              // FutureBuilder waits for the list before showing it. The data
              // is already there, so the wait is only a short moment to show
              // the loading ring, the same way live data would behave.
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: loadCustomers(),
                builder: (context, snapshot) {
                  // While the data is coming, the ring keeps turning.
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: LoadingRing());
                  }

                  final list = snapshot.data ?? customers;

                  return RefreshIndicator(
                    onRefresh: reload,
                    color: ColorResources.primary,
                    // Pulling the list down runs the same load again.
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: visible.isEmpty
                          ? const [
                              Padding(
                                padding: EdgeInsets.only(top: 60),
                                child: Center(
                                  child: Text(
                                    'No customer found.',
                                    style: TextStyle(
                                      color: ColorResources.text,
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          : list.map(customerCard).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}