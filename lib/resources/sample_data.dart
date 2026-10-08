/// Sample data for the whole app.
///
/// Right now nothing is connected to a server. Every screen reads from the
/// lists in this one file, so the app looks complete while it is still
/// running on sample values. When the database is added later, only these
/// lists need to be replaced by Firestore calls.
library;

class SampleData {
  // ---------------------------------------------------------------- products

  static final List<Map<String, dynamic>> products = [
    {
      'id': 'P001',
      'name': '18mm Commercial Ply',
      'brand': 'CENTURYPLY',
      'category': 'Commercial',
      'thickness': '18mm',
      'price': 120,
      'feature': 'Termite Resistant',
      'image': 'assets/images/commercial.png',
      'description':
          'Standard utility grade plywood for furniture and interior work.',
    },
    {
      'id': 'P002',
      'name': 'BWP Marine Ply',
      'brand': 'GREENPLY',
      'category': 'Marine',
      'thickness': '19mm',
      'price': 145,
      'feature': 'Waterproof',
      'image': 'assets/images/bwp_marine.png',
      'description':
          'Boiling Water Proof marine grade plywood for high moisture areas.',
    },
    {
      'id': 'P003',
      'name': 'Club Prime Board',
      'brand': 'CENTURYPLY',
      'category': 'Marine',
      'thickness': '19mm',
      'price': 155,
      'feature': 'Termite Proof',
      'image': 'assets/images/club_prime.png',
      'description':
          'Premium marine plywood with lifetime termite resistance.',
    },
    {
      'id': 'P004',
      'name': 'HDHMR Board',
      'brand': 'ACTION TESA',
      'category': 'HDHMR',
      'thickness': '12mm',
      'price': 88,
      'feature': 'Moisture Resistant',
      'image': 'assets/images/hdhmr.png',
      'description':
          'High density moisture resistant board for wet area furniture.',
    },
    {
      'id': 'P005',
      'name': 'Premium Birch Ply',
      'brand': 'SARDA PLYWOOD',
      'category': 'Birch',
      'thickness': '16mm',
      'price': 210,
      'feature': 'Multi-layer',
      'image': 'assets/images/birch.png',
      'description':
          'Fine finish imported birch plywood used for premium furniture.',
    },
    {
      'id': 'P006',
      'name': 'Green Gold BWP',
      'brand': 'GREENPLY',
      'category': 'Marine',
      'thickness': '18mm',
      'price': 138,
      'feature': 'Boiling Water Proof',
      'image': 'assets/images/green_gold.png',
      'description':
          'Reliable BWP plywood with a smooth, sanded face for all jobs.',
    },
    {
      'id': 'P007',
      'name': 'Decorative Lacquer Ply',
      'brand': 'KITPLY',
      'category': 'Decorative',
      'thickness': '12mm',
      'price': 165,
      'feature': 'Lacquer Finished',
      'image': 'assets/images/birch.png',
      'description':
          'Pre-finished decorative plywood for furniture and wall panels.',
    },
    {
      'id': 'P008',
      'name': 'Blockboard Standard',
      'brand': 'ACTION TESA',
      'category': 'Blockboard',
      'thickness': '18mm',
      'price': 95,
      'feature': 'Core Block',
      'image': 'assets/images/commercial.png',
      'description':
          'Blockboard with a solid core, used for doors and shelving.',
    },
    {
      'id': 'P009',
      'name': 'Natural Teak Veneer',
      'brand': 'SARDA PLYWOOD',
      'category': 'Veneers',
      'thickness': '6mm',
      'price': 72,
      'feature': 'Natural Grain',
      'image': 'assets/images/club_prime.png',
      'description':
          'Natural wood veneer for surface finishing on plywood.',
    },
  ];

  // -------------------------------------------------------------- categories

  static final List<Map<String, dynamic>> categories = [
    {
      'id': 'C001',
      'name': 'MR Grade',
      'description': 'Moisture Resistant grade plywood',
    },
    {
      'id': 'C002',
      'name': 'BWR Grade',
      'description': 'Boiling Water Resistant grade',
    },
    {
      'id': 'C003',
      'name': 'BWP Grade',
      'description': 'Boiling Water Proof marine grade',
    },
    {
      'id': 'C004',
      'name': 'Commercial Plywood',
      'description': 'Standard utility grade plywood',
    },
  ];

  // ------------------------------------------------------------------ brands

  static final List<Map<String, dynamic>> brands = [
    {
      'id': 'B001',
      'name': 'Greenply',
      'description':
          'Premium quality plywood and veneers with eco-friendly certifications.',
      'image': 'assets/images/green_gold.png',
    },
    {
      'id': 'B002',
      'name': 'CenturyPly',
      'description':
          'Industry leader in durable plywood, laminates and decorative veneers.',
      'image': 'assets/images/bwp_marine.png',
    },
    {
      'id': 'B003',
      'name': 'Kitply',
      'description':
          'Heritage brand known for high-grade marine plywood and industrial work.',
      'image': 'assets/images/marine.png',
    },
    {
      'id': 'B004',
      'name': 'Austin Plywood',
      'description':
          'Specialized hardwood plywood and architectural veneers for interiors.',
      'image': 'assets/images/birch.png',
    },
  ];

  // ------------------------------------------------------------------ orders

  static final List<Map<String, dynamic>> orders = [
    {
      'id': 'O001',
      'orderId': 'ORD-98765',
      'userId': 'U001',
      'customerName': 'Arjun Sharma',
      'date': '28 Sep 2026',
      'status': 'Delivered',
      'name': 'Club Prime Board',
      'brand': 'CENTURYPLY',
      'thickness': '19mm',
      'quantity': 1,
      'total': 4960.0,
      'image': 'assets/images/club_prime.png',
    },
    {
      'id': 'O002',
      'orderId': 'ORD-98766',
      'userId': 'U002',
      'customerName': 'Priya Verma',
      'date': '29 Sep 2026',
      'status': 'Pending',
      'name': 'BWP Marine Ply',
      'brand': 'GREENPLY',
      'thickness': '19mm',
      'quantity': 2,
      'total': 9280.0,
      'image': 'assets/images/bwp_marine.png',
    },
    {
      'id': 'O003',
      'orderId': 'ORD-98767',
      'userId': 'U003',
      'customerName': 'Rahul Singh',
      'date': '30 Sep 2026',
      'status': 'Processing',
      'name': 'Premium Birch Ply',
      'brand': 'SARDA PLYWOOD',
      'thickness': '16mm',
      'quantity': 3,
      'total': 20160.0,
      'image': 'assets/images/birch.png',
    },
    {
      'id': 'O004',
      'orderId': 'ORD-98768',
      'userId': 'U001',
      'customerName': 'Arjun Sharma',
      'date': '01 Oct 2026',
      'status': 'Confirmed',
      'name': 'HDHMR Board',
      'brand': 'ACTION TESA',
      'thickness': '12mm',
      'quantity': 4,
      'total': 11264.0,
      'image': 'assets/images/hdhmr.png',
    },
  ];

  // ----------------------------------------------------------------- customers

  static final List<Map<String, dynamic>> customers = [
    {
      'id': 'U001',
      'name': 'Arjun Sharma',
      'email': 'arjun.sharma@email.com',
      'mobile': '9876543210',
      'joined': 'Aug 2026',
    },
    {
      'id': 'U002',
      'name': 'Priya Verma',
      'email': 'priya.verma@email.com',
      'mobile': '9811122334',
      'joined': 'Sep 2026',
    },
    {
      'id': 'U003',
      'name': 'Rahul Singh',
      'email': 'rahul.singh@email.com',
      'mobile': '9123456789',
      'joined': 'Jul 2026',
    },
    {
      'id': 'U004',
      'name': 'Neha Gupta',
      'email': 'neha.gupta@email.com',
      'mobile': '9988766554',
      'joined': 'Oct 2026',
    },
  ];

  // ------------------------------------------------------------------- stock

  static final List<Map<String, dynamic>> stock = [
    {
      'id': 'S001',
      'name': '18mm Commercial Ply',
      'brand': 'CENTURYPLY',
      'stock': 120,
      'unit': 'Sheets',
      'status': 'In Stock',
    },
    {
      'id': 'S002',
      'name': 'BWP Marine Ply',
      'brand': 'GREENPLY',
      'stock': 45,
      'unit': 'Sheets',
      'status': 'In Stock',
    },
    {
      'id': 'S003',
      'name': 'Club Prime Board',
      'brand': 'CENTURYPLY',
      'stock': 8,
      'unit': 'Sheets',
      'status': 'Low Stock',
    },
    {
      'id': 'S004',
      'name': 'HDHMR Board',
      'brand': 'ACTION TESA',
      'stock': 0,
      'unit': 'Sheets',
      'status': 'Out of Stock',
    },
    {
      'id': 'S005',
      'name': 'Premium Birch Ply',
      'brand': 'SARDA PLYWOOD',
      'stock': 14,
      'unit': 'Sheets',
      'status': 'Low Stock',
    },
  ];

  // ---------------------------------------------------------------- wishlist

  static final List<Map<String, dynamic>> wishlist = [
    {
      'id': 'W001',
      'name': 'Club Prime Board',
      'brand': 'CENTURYPLY',
      'category': 'Marine',
      'thickness': '19mm',
      'price': 155,
      'image': 'assets/images/club_prime.png',
    },
    {
      'id': 'W002',
      'name': 'Premium Birch Ply',
      'brand': 'SARDA PLYWOOD',
      'category': 'Birch',
      'thickness': '16mm',
      'price': 210,
      'image': 'assets/images/birch.png',
    },
    {
      'id': 'W003',
      'name': 'Green Gold BWP',
      'brand': 'GREENPLY',
      'category': 'Marine',
      'thickness': '18mm',
      'price': 138,
      'image': 'assets/images/green_gold.png',
    },
  ];

  // ------------------------------------------------------------- signed in user

  /// The signed-in user.
  ///
  /// It is `final` and not `const` on purpose. A `const` map cannot be
  /// changed, so saving the Edit Profile form would fail. Because this map
  /// stays in the same place, every screen reads the new value at once.
  static final Map<String, dynamic> currentUser = {
    'name': 'Arjun Sharma',
    'email': 'arjun.sharma@email.com',
    'mobile': '9876543210',
    'address':
        '123, 4th Floor, Hemkunt Tower, Nehru Place,\nNew Delhi - 110019',
  };

  /// The same user, one field at a time, so a screen can copy the value
  /// straight into a TextEditingController.
  static String get nameText => '${currentUser['name']}';

  static String get emailText => '${currentUser['email']}';

  static String get mobileText => '${currentUser['mobile']}';

  static String get addressText => '${currentUser['address']}';

  /// Saves the Edit Profile form into the same map.
  ///
  /// Only the fields that were passed are changed, so the Edit Address form
  /// does not empty the name.
  static void updateProfile({
    String? name,
    String? email,
    String? mobile,
    String? address,
  }) {
    if (name != null) currentUser['name'] = name;
    if (email != null) currentUser['email'] = email;
    if (mobile != null) currentUser['mobile'] = mobile;
    if (address != null) currentUser['address'] = address;
  }

  /// Products of one brand, used by the brand page.
  ///
  /// A product writes the brand in capitals while the brand list writes it in
  /// normal case, so both sides are lowered before comparing.
  static List<Map<String, dynamic>> productsOfBrand(String brand) {
    return products.where((item) {
      return '${item['brand']}'.toLowerCase() == brand.toLowerCase();
    }).toList();
  }

  /// Orders of one customer, used by the customer details page.
  static List<Map<String, dynamic>> ordersOfUser(String userId) {
    return orders.where((order) => order['userId'] == userId).toList();
  }
}