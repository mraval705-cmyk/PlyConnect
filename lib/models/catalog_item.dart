/// OOP demonstration for the syllabus (Unit 1: inheritance and override).
///
/// [CatalogItem] is the base class. Every item in the shop is a
/// CatalogItem. Plywood and Veneer behave slightly differently, so they get
/// their own classes that inherit from it and override one method.
library;

/// Base class — the common shape of anything the shop sells.
class CatalogItem {
  final String name;
  final String brand;
  final double price;

  const CatalogItem({
    required this.name,
    required this.brand,
    required this.price,
  });

  /// The text shown on the card. The child classes override this, which is
  /// called polymorphism — one method, different answers.
  String get label => name;

  /// Every item has a stock count.
  int get stock => 0;
}

/// A plywood sheet. It is sold by thickness.
class PlywoodProduct extends CatalogItem {
  final String thickness;
  final int sheetsInStock;

  const PlywoodProduct({
    required super.name,
    required super.brand,
    required super.price,
    required this.thickness,
    this.sheetsInStock = 0,
  });

  /// Overridden to also show the thickness.
  @override
  String get label => '$name • $thickness';

  /// Overridden to show the real sheet count.
  @override
  int get stock => sheetsInStock;

  /// Extra behaviour that only plywood has. This is why inheritance helps —
  /// the child can add things the parent does not know about.
  String get grade {
    if (thickness.contains('19')) {
      return 'BWP Marine';
    }
    if (thickness.contains('12')) {
      return 'MR Grade';
    }
    return 'Commercial';
  }
}

/// A decorative veneer. It is sold by finish and measured in area.
class VeneerProduct extends CatalogItem {
  final String finish;
  final double squareFeet;

  const VeneerProduct({
    required super.name,
    required super.brand,
    required super.price,
    required this.finish,
    this.squareFeet = 0,
  });

  /// Overridden to show the finish instead of nothing.
  @override
  String get label => '$name • $finish';

  /// Overridden because veneer is measured in area, not sheets.
  @override
  int get stock => squareFeet.round();
}