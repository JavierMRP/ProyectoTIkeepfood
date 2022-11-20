import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Platos",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          StorageInfoCard(
            svgSrc: "../assets/images/ensalada-cesar.png",
            title: "Ensalada César",
            amountOfFiles: "30 Ventas al mes",
            numOfFiles: 40,
          ),
          StorageInfoCard(
            svgSrc: "../assets/images/sopa-de-mariscos-cantonesa.png",
            title: "Sopa de mariscos",
            amountOfFiles: "15 Ventas al mes",
            numOfFiles: 50,
          ),
          StorageInfoCard(
            svgSrc: "../assets/images/falafel.png",
            title: "Falafel",
            amountOfFiles: "43 Ventas al mes",
            numOfFiles: 28,
          ),
          StorageInfoCard(
            svgSrc: "../assets/images/lasana.png",
            title: "Lasana",
            amountOfFiles: "45 Ventas al mes",
            numOfFiles: 140,
          ),
        ],
      ),
    );
  }
}
