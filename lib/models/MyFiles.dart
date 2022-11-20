import 'package:keepfood/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Platos salvados",
    numOfFiles: 1328,
    svgSrc: "../assets/images/organic-food.png",
    totalStorage: "90%",
    color: primaryColor,
    percentage: 90,
  ),
  CloudStorageInfo(
    title: "Platos vendidos",
    numOfFiles: 1328,
    svgSrc: "../assets/images/sales.png",
    totalStorage: "60%",
    color: Color(0xFFFFA113),
    percentage: 60,
  ),
  CloudStorageInfo(
    title: "Productos Gastados",
    numOfFiles: 1328,
    svgSrc: "../assets/images/diet.png",
    totalStorage: "40%",
    color: Color(0xFFA4CDFF),
    percentage: 40,
  ),
  CloudStorageInfo(
    title: "Productos Salvados",
    numOfFiles: 5328,
    svgSrc: "../assets/images/vegetarian.png",
    totalStorage: "89%",
    color: Color(0xFF007EE5),
    percentage: 89,
  ),
];

List charts = [
  CloudStorageInfo(
    title: "Ensalada César",
    numOfFiles: 1328,
    svgSrc: ".//assets/icons/Documents.svg",
    totalStorage: "1.9GB",
    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Google Drive",
    numOfFiles: 1328,
    svgSrc: "assets/icons/google_drive.svg",
    totalStorage: "2.9GB",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "One Drive",
    numOfFiles: 1328,
    svgSrc: "assets/icons/one_drive.svg",
    totalStorage: "1GB",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "Documents",
    numOfFiles: 5328,
    svgSrc: "assets/icons/drop_box.svg",
    totalStorage: "7.3GB",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];
