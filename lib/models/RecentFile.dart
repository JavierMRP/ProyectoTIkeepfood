import 'package:flutter/foundation.dart';

class RecentFile {
  final String? icon, title, dateExpire, provider, category;
  final int? amount;
  final double? price;

  RecentFile(
      {this.icon,
      this.title,
      this.dateExpire,
      this.amount,
      this.provider,
      this.price,
      this.category});
}

List demoRecentFiles = [
  RecentFile(
      icon: "../assets/images/apple.png",
      title: "Manzana",
      dateExpire: "2023-03-01",
      provider: "fruver",
      amount: 3,
      price: 5000.0,
      category: "Frutas y Verduras"),
  RecentFile(
      icon: "../assets/images/bread.png",
      title: "Pan",
      dateExpire: "2023-03-01",
      provider: "fruver",
      amount: 3,
      price: 5000.0,
      category: "Panadería y Pastelería"),
  RecentFile(
      icon: "../assets/images/cauliflower.png",
      title: "Coliflor",
      dateExpire: "2023-03-01",
      provider: "fruver",
      amount: 3,
      price: 5000.0,
      category: "Frutas y Verduras"),
  RecentFile(
      icon: "../assets/images/fruit.png",
      title: "Naranja",
      dateExpire: "2023-03-01",
      provider: "fruver",
      amount: 3,
      price: 5000.0,
      category: "Frutas y Verduras"),
  RecentFile(
      icon: "../assets/images/kiwi.png",
      title: "Kiwi",
      dateExpire: "2023-03-01",
      provider: "fruver",
      amount: 3,
      category: "Frutas y Verduras",
      price: 5000.0),
  RecentFile(
      icon: "../assets/images/tomato.png",
      title: "Tomate",
      dateExpire: "2023-03-01",
      provider: "fruver",
      category: "Frutas y Verduras",
      amount: 3,
      price: 5000.0),
  RecentFile(
      icon: "../assets/images/milk-bottle.png",
      title: "Leche",
      dateExpire: "2023-03-01",
      category: "Lacteos, Huevos y regrigerados",
      provider: "fruver",
      amount: 3,
      price: 5000.0),
];
