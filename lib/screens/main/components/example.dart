import 'package:flutter/material.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

/// This example shows the basic usage of the [StickyGroupedListView].

List<Element> _elements = <Element>[
  Element(DateTime(2022, 6, 25, 8), 'Se han salvado 30 platos este mes',
      Icons.food_bank_outlined),
  Element(
      DateTime(2022, 6, 26, 12),
      'El producto "Manzana" ha sido entregado correctamente',
      Icons.delivery_dining),
  Element(
      DateTime(2022, 6, 27, 12),
      'Se sugiere priorizar el plato "Sopa de mariscos" para evitar una pérdida de productos durante los siguientes 15 días',
      Icons.emoji_objects_rounded),
  Element(
      DateTime(2022, 6, 27, 13),
      'El plato "Lasana" es el de mayor ventas este mes',
      Icons.insights_rounded),
  Element(
      DateTime(2022, 6, 27, 14),
      'Se sugiere priorizar el plato "Falafel" para evitar una pérdida de productos durante los siguientes 45 días',
      Icons.emoji_objects_rounded),
  Element(
      DateTime(2022, 6, 29, 12),
      'El proveedor "Fruver" informa que el producto "Coliflor" no esta disponible',
      Icons.info_outline),
  Element(
      DateTime(2022, 6, 25, 20),
      'Se debe actualizar el inventario para los platos de comida rápida',
      Icons.no_food),
  Element(
      DateTime(2022, 6, 27, 15),
      'Se sugiere priorizar el plato "Lasana" para evitar una pérdida de productos durante los siguientes 20 días',
      Icons.emoji_objects_rounded),
  Element(
      DateTime(2022, 6, 29, 12),
      'El proveedor "Fruver" informa que el producto "Kiwi" no esta disponible',
      Icons.info_outline),
  Element(
      DateTime(2022, 6, 27, 13),
      'El plato "Sopa de Mariscos" es el de mayor ventas este mes',
      Icons.insights_rounded),
  Element(DateTime(2022, 6, 24, 18),
      'El producto "Leche" esta pronto a agotarse', Icons.crisis_alert_sharp),
  Element(DateTime(2022, 6, 24, 9), 'Se ha actualizado el inventario',
      Icons.system_update_tv),
];

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones keep food'),
      ),
      body: StickyGroupedListView<Element, DateTime>(
        elements: _elements,
        order: StickyGroupedListOrder.ASC,
        groupBy: (Element element) => DateTime(
          element.date.year,
          element.date.month,
          element.date.day,
        ),
        groupComparator: (DateTime value1, DateTime value2) =>
            value2.compareTo(value1),
        itemComparator: (Element element1, Element element2) =>
            element1.date.compareTo(element2.date),
        floatingHeader: true,
        groupSeparatorBuilder: _getGroupSeparator,
        itemBuilder: _getItem,
      ),
    );
  }

  Widget _getGroupSeparator(Element element) {
    return SizedBox(
      height: 50,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            color: Colors.blue[300],
            border: Border.all(
              color: Colors.blue[300]!,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${element.date.day}. ${element.date.month}, ${element.date.year}',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getItem(BuildContext ctx, Element element) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: SizedBox(
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Icon(element.icon),
          title: Text(element.name),
          trailing: Text('${element.date.hour}:00'),
        ),
      ),
    );
  }
}

class Element {
  DateTime date;
  String name;
  IconData icon;

  Element(this.date, this.name, this.icon);
}
