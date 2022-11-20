import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:keepfood/models/RecentFile.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import '../../../constants.dart';
import 'package:keepfood/responsive.dart';

class RecentFiles extends StatefulWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

List<String> selected = [];

class _RecentFilesState extends State<RecentFiles> {
  final List<dynamic> list_products = demoRecentFiles;

  void _addProduct(RecentFile value) {
    setState(() {
      list_products.add(value);
    });
  }

  void _setViewForm() {
    setState(() {
      addProductForm(context);
    });
  }

  void _setViewUpdateForm(String name) {
    setState(() {
      updateProductForm(context, _searchRecentFileByName(name));
    });
  }

  RecentFile _searchRecentFileByName(String name) {
    RecentFile r = RecentFile();
    for (var i = 0; i < list_products.length; i++) {
      r = list_products[i];
      //print(r.title.toString() + "-" + name);
      if (r.title.toString() == name) {
        print(r);
        return r;
      }
    }
    return r;
  }

  void _deleteProducts() {
    setState(() {
      for (var i in selected) {
        var p = searchProductByName(i);
        list_products.removeAt(p);
      }
      selected = [];
    });
  }

  void _deleteProduct(name) {
    setState(() {
      var p = searchProductByName(name);
      list_products.removeAt(p);
    });
  }

  int searchProductByName(String name) {
    for (var i = 0; i < list_products.length; i++) {
      RecentFile r = list_products[i];
      //  print(r.title.toString() + "-" + name);
      if (r.title.toString() == name) {
        return i;
      }
    }
    return -1;
  }

  addProductForm(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    Iterable<dynamic> lista = [];
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Nuevo Producto'),
            content: FastForm(
                formKey: formKey,
                onChanged: (value) {
                  // ignore: avoid_print
                  lista = value.values;
                  print('Form changed: ${value.values}');
                },
                children: [
                  FastFormSection(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    header: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Añadir Producto Formulario',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    children: [
                      FastTextField(
                        name: 'Nombre del producto',
                        labelText: 'Nombre',
                        placeholder: 'Nombre del producto',
                      ),
                      FastDateRangePicker(
                        name: 'Caducidad',
                        labelText: 'Vida útil',
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      ),
                      FastDropdown<String>(
                        name: 'Categoria',
                        labelText: 'Categoria',
                        items: [
                          'Despensa',
                          'Lacteos, Huevos y Regrigerados',
                          'Frutas y verduras',
                          'Pescados y mariscos',
                          'Platos preparados',
                          'Carne y Pollo',
                          'Pandería y Pastelería',
                          'Dulces y Postres',
                          'Pasabocas',
                          'Charcutería',
                          'Vinos y Licores',
                          'Bebidas'
                        ],
                        initialValue: 'Despensa',
                      ),
                      FastTextField(
                        name: 'precio',
                        labelText: 'Precio unitario',
                        placeholder: 'Precio',
                        inputFormatters: [
                          NumberTextInputFormatter(
                            integerDigits: 10,
                            decimalDigits: 2,
                            maxValue: '1000000000.00',
                            decimalSeparator: '.',
                            groupDigits: 3,
                            // groupSeparator: ',',
                            allowNegative: false,
                            overrideDecimalPoint: true,
                            insertDecimalPoint: false,
                            insertDecimalDigits: true,
                          ),
                        ],
                        keyboardType: TextInputType.number,
                      ),
                      FastTextField(
                        name: 'amount',
                        labelText: 'Cantidad',
                        placeholder: 'Cantidad de producto',
                        inputFormatters: [
                          NumberTextInputFormatter(
                            integerDigits: 10,
                            decimalDigits: 0,
                            maxValue: '1000000000.00',
                            groupDigits: 3,
                            allowNegative: false,
                            overrideDecimalPoint: false,
                            insertDecimalPoint: false,
                            insertDecimalDigits: false,
                          ),
                        ],
                        keyboardType: TextInputType.number,
                      ),
                      FastDropdown<String>(
                        name: 'Provider',
                        labelText: 'Proveedor',
                        items: [
                          'Fruver',
                          'Diana',
                          'Alpina',
                          'Colombina',
                          'Nutresa',
                          'Bavaria',
                          'Postobon',
                          'Colanta',
                          'Quala',
                        ],
                        initialValue: 'Fruver',
                      ),
                    ],
                  )
                ]),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  var regex = new RegExp(r",");
                  var lon = lista.toList()[1].toString().split(' ').length;
                  RecentFile product = RecentFile(
                      icon: "../assets/images/apple.png",
                      title: lista.toList()[0].toString(),
                      dateExpire: lista
                          .toList()[1]
                          .toString()
                          .split(' ')
                          .elementAt(lon - 2),
                      provider: lista.toList()[5].toString(),
                      amount:
                          int.parse(lista.toList()[4].replaceAll(regex, '')),
                      category: lista.toList()[2].toString(),
                      price: double.parse(
                          lista.toList()[3].replaceAll(regex, '')));
                  _addProduct(product);
                  Navigator.of(context).pop();
                },
                child: const Text('Agregar'),
              ),
              OutlinedButton(
                onPressed: () {
                  selected = [];
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              )
            ],
          );
        });
  }

  updateProductForm(BuildContext context, RecentFile file) {
    print(file.category.toString() + "implrime");
    final formKey = GlobalKey<FormState>();
    var pro = file.provider.toString();
    var cat = file.category.toString();
    Iterable<dynamic> lista = [];
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Actualizar Producto'),
            content: FastForm(
                formKey: formKey,
                onChanged: (value) {
                  // ignore: avoid_print
                  lista = value.values;
                  print('Form changed: ${value.values}');
                },
                children: [
                  FastFormSection(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    header: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Añadir Producto Formulario',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    children: [
                      FastTextField(
                        name: 'Nombre del producto',
                        labelText: 'Nombre',
                        placeholder: 'Nombre del producto',
                        initialValue: file.title.toString(),
                      ),
                      FastDateRangePicker(
                        name: 'Caducidad',
                        labelText: 'Vida útil',
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      ),
                      FastDropdown<String>(
                        name: 'Categoria',
                        labelText: 'Categoria',
                        items: [
                          'Despensa',
                          'Lacteos, Huevos y Regrigerados',
                          'Frutas y verduras',
                          'Pescados y mariscos',
                          'Platos preparados',
                          'Carne y Pollo',
                          'Pandería y Pastelería',
                          'Dulces y Postres',
                          'Pasabocas',
                          'Charcutería',
                          'Vinos y Licores',
                          'Bebidas'
                        ],
                        //       initialValue: cat,
                      ),
                      FastTextField(
                        name: 'precio',
                        labelText: 'Precio unitario',
                        placeholder: 'Precio',
                        initialValue: file.price.toString(),
                        inputFormatters: [
                          NumberTextInputFormatter(
                            integerDigits: 10,
                            decimalDigits: 2,
                            maxValue: '1000000000.00',
                            decimalSeparator: '.',
                            groupDigits: 3,
                            // groupSeparator: ',',
                            allowNegative: false,
                            overrideDecimalPoint: true,
                            insertDecimalPoint: false,
                            insertDecimalDigits: true,
                          ),
                        ],
                        keyboardType: TextInputType.number,
                      ),
                      FastTextField(
                        name: 'amount',
                        labelText: 'Cantidad',
                        initialValue: file.amount.toString(),
                        placeholder: 'Cantidad de producto',
                        inputFormatters: [
                          NumberTextInputFormatter(
                            integerDigits: 10,
                            decimalDigits: 0,
                            maxValue: '1000000000.00',
                            groupDigits: 3,
                            allowNegative: false,
                            overrideDecimalPoint: false,
                            insertDecimalPoint: false,
                            insertDecimalDigits: false,
                          ),
                        ],
                        keyboardType: TextInputType.number,
                      ),
                      FastDropdown<String>(
                        name: 'Provider',
                        labelText: 'Proveedor',
                        items: [
                          'Fruver',
                          'Diana',
                          'Alpina',
                          'Colombina',
                          'Nutresa',
                          'Bavaria',
                          'Postobon',
                          'Colanta',
                          'Quala',
                        ],
                        //initialValue: pro
                      ),
                    ],
                  )
                ]),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  _deleteProduct(file.title);
                  var regex = new RegExp(r",");
                  var lon = lista.toList()[1].toString().split(' ').length;
                  RecentFile product = RecentFile(
                      icon: "../assets/images/apple.png",
                      title: lista.toList()[0].toString(),
                      dateExpire: lista
                          .toList()[1]
                          .toString()
                          .split(' ')
                          .elementAt(lon - 2),
                      provider: lista.toList()[5].toString(),
                      amount:
                          int.parse(lista.toList()[4].replaceAll(regex, '')),
                      category: lista.toList()[2].toString(),
                      price: double.parse(
                          lista.toList()[3].replaceAll(regex, '')));
                  _addProduct(product);
                  Navigator.of(context).pop();
                },
                child: const Text('Agregar'),
              ),
              OutlinedButton(
                onPressed: () {
                  selected = [];
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: defaultPadding),
            Responsive(
              mobile: Row(children: [
                Spacer(),
                Row(children: [
                  ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      addProductForm(context);
                    },
                    icon: Icon(Icons.add),
                    label: Text("Añadir"),
                  ),
                  SizedBox(width: 2),
                  ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      if (selected.isNotEmpty) {
                        _setViewUpdateForm(selected.last);
                        selected = [];
                      }
                    },
                    icon: Icon(Icons.update),
                    label: Text("Actualizar"),
                  ),
                  SizedBox(width: 2),
                  ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      _deleteProducts();
                    },
                    icon: Icon(Icons.delete),
                    label: Text("Eliminar"),
                  ),
                ])
              ]),
              tablet: Row(children: [
                Row(children: [
                  Text(
                    "Productos",
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ]),
                Spacer(),
                Row(children: [
                  ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      addProductForm(context);
                    },
                    icon: Icon(Icons.add),
                    label: Text("Añadir"),
                  ),
                  SizedBox(width: 2),
                  ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      if (selected.isNotEmpty) {
                        _setViewUpdateForm(selected.last);
                        selected = [];
                      }
                    },
                    icon: Icon(Icons.update),
                    label: Text("Actualizar"),
                  ),
                  SizedBox(width: 2),
                  ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      _deleteProducts();
                    },
                    icon: Icon(Icons.delete),
                    label: Text("Eliminar"),
                  ),
                ])
              ]),
              desktop: Row(children: [
                Row(children: [
                  Text(
                    "Productos",
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ]),
                Spacer(),
                Row(children: [
                  ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      addProductForm(context);
                    },
                    icon: Icon(Icons.add),
                    label: Text("Añadir"),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      if (selected.isNotEmpty) {
                        _setViewUpdateForm(selected.last);
                        selected = [];
                      }
                    },
                    icon: Icon(Icons.update),
                    label: Text("Actualizar"),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      _deleteProducts();
                    },
                    icon: Icon(Icons.delete),
                    label: Text("Eliminar"),
                  ),
                ])
              ]),
            ),
            DataTable(
              columnSpacing: 2.0,
              columns: [
                DataColumn2(
                  label: Text("Nombre"),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text("Caducidad"),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text("Precio"),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text("Cantidad"),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text("Proveedor"),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text("Categoría"),
                  size: ColumnSize.S,
                ),
              ],
              rows: List.generate(
                list_products.length,
                (index) => recentFileDataRow(list_products[index]),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    onLongPress: () {
      selected.add(fileInfo.title.toString());
    },
    cells: [
      DataCell(
        Row(
          children: [
            Image.asset(
              fileInfo.icon!,
              height: 30,
              width: 30,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 4),
              child: Text(fileInfo.title!),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.dateExpire!)),
      DataCell(Text(r"$" + fileInfo.price!.toString())),
      DataCell(Text(fileInfo.amount!.toString())),
      DataCell(Text(fileInfo.provider!)),
      DataCell(Text(fileInfo.category!)),
    ],
  );
}
