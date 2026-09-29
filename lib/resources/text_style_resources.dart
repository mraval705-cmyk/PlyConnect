import 'package:flutter/material.dart';
import 'color_resources.dart';

/// Every text style used in the app is written here and nowhere else.
///
/// If a font size has to be changed, change it only in this file.
class TextStyleResources {
  // Screen titles, for example "Login" or "Product Details"
  static const TextStyle screenTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: ColorResources.heading,
  );

  // Big title on welcome and signup screens
  static const TextStyle bigTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: ColorResources.heading,
  );

  // Section title inside a page
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: ColorResources.heading,
  );

  // Product or item name
  static const TextStyle itemName = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ColorResources.heading,
  );

  // Normal paragraph text
  static const TextStyle body = TextStyle(
    fontSize: 16,
    height: 1.5,
    color: ColorResources.text,
  );

  // Small helper text under a field
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: ColorResources.lightText,
  );

  // Brand name written above a product name
  static const TextStyle brand = TextStyle(
    fontSize: 10,
    color: ColorResources.lightText,
  );

  // Price text
  static const TextStyle price = TextStyle(
    fontWeight: FontWeight.bold,
    color: ColorResources.primary,
  );

  // Text on top of a filled button
  static const TextStyle buttonText = TextStyle(
    fontSize: 20,
    color: ColorResources.white,
  );
}
