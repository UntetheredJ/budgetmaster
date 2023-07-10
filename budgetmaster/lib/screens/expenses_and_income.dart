import 'package:budgetmaster/models/gasto_espontaneo.dart';
import 'package:budgetmaster/models/inversion.dart';
import 'package:budgetmaster/models/pago_periodico.dart';
import 'package:budgetmaster/models/ingreso.dart';
import 'package:budgetmaster/models/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budgetmaster/db/functionQuerie.dart';
import 'package:budgetmaster/screens/service.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class expenses_and_income extends StatefulWidget {
  final Usuario usuario;

  const expenses_and_income({Key? key, required this.usuario})
      : super(key: key);

  @override
  _Expenses_and_income createState() => _Expenses_and_income();
}

class _Expenses_and_income extends State<expenses_and_income> {
  //Calculos
  late List<GastoEspontaneo> listGastoEspontaneo;
  late List<PagoPeriodico> listPagoPeriodico;
  late List<Inversion> listInversion;
  late List<Ingreso> listIngreso;

  bool _isLoading = false;

  // Formato
  final currencyFormat = NumberFormat.simpleCurrency(locale: "es_US");

  // Pago Periodico
  var descripcionPagoPeriodico = TextEditingController();
  var valorPagoPeriodico = TextEditingController();
  late DateTime fecha_vencimiento;
  Random random =  Random();

  // Gasto Espontaneo
  var descripcionGastoEspontaneo = TextEditingController();
  var valorGastoEspontaneoo = TextEditingController();
  late DateTime fecha_gasto_espontaneo;

  // Inversion
  var descripcionInversion = TextEditingController();
  var valorInversion = TextEditingController();
  late DateTime fecha_inversion;

  // Ingreso
  var descripcionIngreso = TextEditingController();
  var valorIngreso = TextEditingController();
  late DateTime fecha_ingreso;

  //Actualizar Pago Periodico
  var actualizarDescripcionPagoPeriodico = TextEditingController();
  var actualizarValorPagoPeriodico = TextEditingController();
  late DateTime actualizar_fecha_vencimiento;

  // Gasto Espontaneo
  var ActualizarDescripcionGastoEspontaneo = TextEditingController();
  var ActualizarValorGastoEspontaneoo = TextEditingController();
  late DateTime actualizar_fecha_gasto_espontaneo;

  // Inversion

  // Ingreso

  @override
  Widget build(BuildContext context) {
    // Tamaño de pantalla
    final screenHeight = MediaQuery.of(context).size.height;
    final containerHeight = screenHeight*0.32;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7B1FA2),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Gastos e Ingresos",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            )),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData,
          child: SingleChildScrollView(
              child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10.0),
                                    child: const Text("Gastos",
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.black)),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10.0),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: const Color(0xFF7B1FA2),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                  "Seleccionar tipo de Gasto",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: [
                                                      DropdownButtonFormField(
                                                        icon: const Icon(Icons.menu),
                                                        items: const [
                                                          DropdownMenuItem(
                                                              value: 1,
                                                              child: Text("Gasto Espontaneo")),
                                                          DropdownMenuItem(
                                                              value: 2,
                                                              child: Text("Pago Periodico")),
                                                          DropdownMenuItem(
                                                              value: 3,
                                                              child: Text("Inversion")),
                                                        ],
                                                        onChanged: (value) {
                                                          if (value == 1) {
                                                            Navigator.of(context).pop();
                                                            mostrarRegistroGastoEspontaneo();
                                                          } else if (value == 2) {
                                                            Navigator.of(context).pop();
                                                            mostrarRegistroPagoPeriodico();
                                                          } else if (value == 3) {
                                                            Navigator.of(context).pop();
                                                            mostrarRegistroInversion();
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: const Text(
                                        '+',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: containerHeight,
                                child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        FutureBuilder<List<GastoEspontaneo>>(
                                          future: listaGastoEspontaneo(widget.usuario.id_usuario),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return Text('Error al cargar los datos');
                                            } else {
                                              List<GastoEspontaneo> gastos = snapshot.data!;
                                              listGastoEspontaneo = gastos;
                                              return DataTable(
                                                dividerThickness: 0,
                                                dataRowHeight: 70,
                                                headingRowHeight: 0,
                                                columnSpacing: 15,
                                                columns: const [
                                                  DataColumn(label: Text("")),
                                                  DataColumn(label: Text("")),
                                                  DataColumn(label: Text("")),
                                                ],
                                                rows: gastos.map((gastoEspontaneo) {
                                                  mostrarNotification(
                                                      random.nextInt(100),
                                                      'Recordatorio Pago',
                                                      '${gastoEspontaneo.descripcion} por un valor de ${gastoEspontaneo.valor}'
                                                  );
                                                  return DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                        width: screenWidth*0.01,
                                                        height: 60,
                                                        color: Colors.lightBlue,
                                                        child: Text(""),
                                                      ),
                                                    ),
                                                    DataCell(
                                                        Container(
                                                          width: screenWidth*0.6,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                gastoEspontaneo.descripcion,
                                                                style: const TextStyle(
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.bold),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text("Espontaneo - "),
                                                                  Text(
                                                                    currencyFormat.format(gastoEspontaneo.valor),
                                                                    style: const TextStyle(
                                                                        fontSize: 15,
                                                                        color: Color(0xFF7B1FA2)),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                    ),
                                                    DataCell(
                                                        Container(
                                                          width: screenWidth*0.35,
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                margin: const EdgeInsets.all(10.0),
                                                                height: 40,
                                                                width: 40,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(100),
                                                                  color: Colors.amber,
                                                                ),
                                                                child: IconButton(
                                                                  onPressed: () {
                                                                    actualizarGastoEspontaneo();
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons.edit,
                                                                      color: Colors.white,
                                                                      size: 20),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: const EdgeInsets.all(10.0),
                                                                height: 40,
                                                                width: 40,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(100),
                                                                  color: Colors.red,
                                                                ),
                                                                child: IconButton(
                                                                  onPressed: () {
                                                                    showDialog(
                                                                      context: context,
                                                                      builder: (BuildContext context) {
                                                                        return AlertDialog(
                                                                          title: Text("Validar"),
                                                                          content: Text("¿Esta seguro que desaa eliminar?"),
                                                                          actions: <Widget>[
                                                                            TextButton(
                                                                              child: Text("Si"),
                                                                              onPressed: () async {
                                                                                Navigator.pop(context);
                                                                                int valor = await eliminarGastoEspontaneoUsuario(gastoEspontaneo.id_gasto);
                                                                                if(valor == 1) {
                                                                                  mostrarDialogoAceptado();
                                                                                } else {
                                                                                  mostrarDialogoError();
                                                                                }
                                                                              },
                                                                            ),
                                                                            TextButton(
                                                                              child: Text("No"),
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  icon: const Icon(
                                                                    Icons.delete,
                                                                    color: Colors.white,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                    ),
                                                  ]);
                                                }).toList(),
                                              );
                                            }
                                          },
                                        ),
                                        FutureBuilder<List<PagoPeriodico>>(
                                          future: listaPagoPeriodico(widget.usuario.id_usuario),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return Text('Error al cargar los datos');
                                            } else {
                                              List<PagoPeriodico> pagos = snapshot.data!;
                                              listPagoPeriodico = pagos;
                                              return DataTable(
                                                dividerThickness: 0,
                                                dataRowHeight: 70,
                                                headingRowHeight: 0,
                                                columnSpacing: 15,
                                                columns: const [
                                                  DataColumn(label: Text("")),
                                                  DataColumn(label: Text("")),
                                                  DataColumn(label: Text("")),
                                                ],
                                                rows: pagos.map((pago) {
                                                  mostrarNotification(
                                                      random.nextInt(100),
                                                      'Recordatorio Pago',
                                                      '${pago.descripcion} por un valor de ${pago.valor}'
                                                  );
                                                  return DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                        width: screenWidth*0.01,
                                                        height: 60,
                                                        color: Colors.purple,
                                                        child: Text(""),
                                                      ),
                                                    ),
                                                    DataCell(
                                                        Container(
                                                          width: screenWidth*0.6,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                pago.descripcion,
                                                                style: const TextStyle(
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.bold),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text("Fijo - "),
                                                                  Text(
                                                                    currencyFormat.format(pago.valor),
                                                                    style: const TextStyle(
                                                                        fontSize: 15,
                                                                        color: Color(0xFF7B1FA2)),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                    ),
                                                    DataCell(
                                                        Container(
                                                          width: screenWidth*0.35,
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                margin: const EdgeInsets.all(10.0),
                                                                height: 40,
                                                                width: 40,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(100),
                                                                  color: Colors.amber,
                                                                ),
                                                                child: IconButton(
                                                                  onPressed: () {

                                                                  },
                                                                  icon: const Icon(
                                                                      Icons.edit,
                                                                      color: Colors.white,
                                                                      size: 20),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: const EdgeInsets.all(10.0),
                                                                height: 40,
                                                                width: 40,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(100),
                                                                  color: Colors.red,
                                                                ),
                                                                child: IconButton(
                                                                  onPressed: () {
                                                                    showDialog(
                                                                      context: context,
                                                                      builder: (BuildContext context) {
                                                                        return AlertDialog(
                                                                          title: Text("Validar"),
                                                                          content: Text("¿Esta seguro que desaa eliminar?"),
                                                                          actions: <Widget>[
                                                                            TextButton(
                                                                              child: Text("Si"),
                                                                              onPressed: () async {
                                                                                Navigator.pop(context);
                                                                                int valor = await eliminarPagoPeriodicoUsuario(pago.id_gasto);
                                                                                if(valor == 1) {
                                                                                  mostrarDialogoAceptado();
                                                                                } else {
                                                                                  mostrarDialogoError();
                                                                                }
                                                                              },
                                                                            ),
                                                                            TextButton(
                                                                              child: Text("No"),
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  icon: const Icon(
                                                                    Icons.delete,
                                                                    color: Colors.white,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                    ),
                                                  ]);
                                                }).toList(),
                                              );
                                            }
                                          },
                                        ),
                                        FutureBuilder<List<Inversion>>(
                                          future: listaInversion(widget.usuario.id_usuario),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return Text('Error al cargar los datos');
                                            } else {
                                              List<Inversion> inversiones = snapshot.data!;
                                              listInversion = inversiones;
                                              return DataTable(
                                                dividerThickness: 0,
                                                dataRowHeight: 70,
                                                headingRowHeight: 0,
                                                columnSpacing: 15,
                                                columns: const [
                                                  DataColumn(label: Text("")),
                                                  DataColumn(label: Text("")),
                                                  DataColumn(label: Text("")),
                                                ],
                                                rows: inversiones.map((inversion) {
                                                  mostrarNotification(
                                                      random.nextInt(100),
                                                      'Recordatorio Pago',
                                                      '${inversion.descripcion} por un valor de ${inversion.valor}'
                                                  );
                                                  return DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                        width: screenWidth*0.01,
                                                        height: 60,
                                                        color: Colors.green,
                                                        child: Text(""),
                                                      ),
                                                    ),
                                                    DataCell(
                                                        Container(
                                                          width: screenWidth*0.60,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                inversion.descripcion,
                                                                style: const TextStyle(
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.bold),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text("Inversion - "),
                                                                  Text(
                                                                    currencyFormat.format(inversion.valor),
                                                                    style: const TextStyle(
                                                                        fontSize: 15,
                                                                        color: Color(0xFF7B1FA2)),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )),
                                                    DataCell(
                                                        Container(
                                                          width: screenWidth*0.35,
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                margin: const EdgeInsets.all(10.0),
                                                                height: 40,
                                                                width: 40,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(100),
                                                                  color: Colors.amber,
                                                                ),
                                                                child: IconButton(
                                                                  onPressed: () {},
                                                                  icon: const Icon(
                                                                      Icons.edit,
                                                                      color: Colors.white,
                                                                      size: 20),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: const EdgeInsets.all(10.0),
                                                                height: 40,
                                                                width: 40,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(100),
                                                                  color: Colors.red,
                                                                ),
                                                                child: IconButton(
                                                                  onPressed: () {
                                                                    showDialog(
                                                                      context: context,
                                                                      builder: (BuildContext context) {
                                                                        return AlertDialog(
                                                                          title: Text("Validar"),
                                                                          content: Text("¿Esta seguro que desaa eliminar?"),
                                                                          actions: <Widget>[
                                                                            TextButton(
                                                                              child: Text("Si"),
                                                                              onPressed: () async {
                                                                                Navigator.pop(context);
                                                                                int valor = await eliminarInversion(inversion.id_gasto);
                                                                                if(valor == 1) {
                                                                                  mostrarDialogoAceptado();
                                                                                } else {
                                                                                  mostrarDialogoError();
                                                                                }
                                                                              },
                                                                            ),
                                                                            TextButton(
                                                                              child: Text("No"),
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  icon: const Icon(
                                                                    Icons.delete,
                                                                    color: Colors.white,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                    ),
                                                  ]);
                                                }).toList(),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    )
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10.0),
                                    child: const Text(
                                      "Total:",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10.0),
                                    child: Text(
                                      currencyFormat.format(widget.usuario.total_gastos),
                                      style: const TextStyle(
                                          fontSize: 20, color: Color(0xFF7B1FA2)),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10.0),
                                    child: const Text("Ingresos",
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.black)),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10.0),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: const Color(0xFF7B1FA2),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        mostrarRegistroIngreso();
                                      },
                                      icon: const Text(
                                        '+',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: containerHeight,
                                child: SingleChildScrollView(
                                  child: FutureBuilder<List<Ingreso>>(
                                      future: listaIngresos(widget.usuario.id_usuario),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text('Error al cargar los datos');
                                        } else {
                                          List<Ingreso> ingresos = snapshot.data!;
                                          listIngreso = ingresos;
                                          return DataTable(
                                            dividerThickness: 0,
                                            dataRowHeight: 70,
                                            headingRowHeight: 0,
                                            columnSpacing: 15,
                                            columns: const [
                                              DataColumn(label: Text("")),
                                              DataColumn(label: Text("")),
                                              DataColumn(label: Text("")),
                                            ],
                                            rows: ingresos.map((ingreso) {
                                              return DataRow(cells: [
                                                DataCell(
                                                  Container(
                                                    width: screenWidth*0.01,
                                                    height: 60,
                                                    color: Colors.purple,
                                                    child: Text(""),
                                                  ),
                                                ),
                                                DataCell(
                                                    Container(
                                                      width: screenWidth*0.6,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            ingreso.descripcion,
                                                            style: const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          Text(
                                                            currencyFormat.format(ingreso.valor),
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                color: Color(0xFF7B1FA2)),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                ),
                                                DataCell(
                                                    Container(
                                                      width: screenWidth*0.35,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets.all(10.0),
                                                            height: 40,
                                                            width: 40,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(100),
                                                              color: Colors.amber,
                                                            ),
                                                            child: IconButton(
                                                              onPressed: () {},
                                                              icon: const Icon(
                                                                Icons.edit,
                                                                color: Colors.white,
                                                                size: 20,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: const EdgeInsets.all(
                                                                10.0),
                                                            height: 40,
                                                            width: 40,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(100),
                                                              color: Colors.red,
                                                            ),
                                                            child: IconButton(
                                                              onPressed: () {
                                                                showDialog(
                                                                  context: context,
                                                                  builder: (BuildContext context) {
                                                                    return AlertDialog(
                                                                      title: Text("Validar"),
                                                                      content: Text("¿Esta seguro que desaa eliminar?"),
                                                                      actions: <Widget>[
                                                                        TextButton(
                                                                          child: Text("Si"),
                                                                          onPressed: () async {
                                                                            Navigator.pop(context);
                                                                            int valor = await eliminarIngreso(ingreso.id_ingreso);
                                                                            if(valor == 1) {
                                                                              mostrarDialogoAceptado();
                                                                            } else {
                                                                              mostrarDialogoError();
                                                                            }
                                                                          },
                                                                        ),
                                                                        TextButton(
                                                                          child: Text("No"),
                                                                          onPressed: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              icon: const Icon(
                                                                Icons.delete,
                                                                color: Colors.white,
                                                                size: 20,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                ),
                                              ]);
                                            }).toList(),
                                          );
                                        }
                                      }),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10.0),
                                    child: const Text(
                                      "Total:",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10.0),
                                    child: Text(
                                      currencyFormat.format(widget.usuario.total_ingresos),
                                      style: const TextStyle(
                                          fontSize: 20, color: Color(0xFF7B1FA2)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                      )
                  )
              )
          ),
        )
      ),
    );
  }

  Future<DateTime?> seleccionarFecha() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
  }

  mostrarDialogoAceptado() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Correcto"),
          content: Text("La operacion se ejecuto correctamente"),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                _loadData();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  mostrarDialogoError(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("Ocurrio un error en la operacion"),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
    calcularDatos(listGastoEspontaneo, listPagoPeriodico, listInversion, listIngreso);
  }

  mostrarRegistroPagoPeriodico() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
          const Text(
            "Ingresar datos",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content:
          SingleChildScrollView(
            child:
            ListBody(
              children: [
                const Text(
                  "Descripcion:",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
                TextFormField(
                  controller: descripcionPagoPeriodico,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Descripcion",
                    border: OutlineInputBorder(),
                  ),
                ),
                const Text(
                  "Valor:",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: valorPagoPeriodico,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Valor",
                    border: OutlineInputBorder(),
                  ),
                ),
                const Text(
                  "Fecha Vencimineto:",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                OutlinedButton(
                  onPressed: () async {
                    fecha_vencimiento = (await seleccionarFecha())!;
                  },
                  child: const Text('Seleccionar Fecha'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.purple),
                  child: MaterialButton(
                    onPressed: () async {
                      String descripcion_pago_periodico = descripcionPagoPeriodico.text;
                      int valor_pago_periodico = int.parse(valorPagoPeriodico.text);
                      int valor = await agregarPagoPeriodicoUsuario(
                          widget.usuario.id_usuario,
                          descripcion_pago_periodico,
                          valor_pago_periodico,
                          fecha_vencimiento);
                      await initNotifications();
                      mostrarNotification(
                          valor_pago_periodico,
                          'Recordatorio Pago',
                          valorPagoPeriodico.text);
                      if (valor == 1) {
                        Navigator.of(context).pop();
                        mostrarDialogoAceptado();
                      } else {
                        Navigator.of(context).pop();
                        mostrarDialogoError();
                      }
                    },
                    child:
                    const Text(
                      "Agregar Gasto",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  mostrarRegistroGastoEspontaneo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Ingresar datos",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Text(
                  "Descripcion:",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: descripcionGastoEspontaneo,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Descripcion",
                    border: OutlineInputBorder(),
                  ),
                ),
                const Text(
                  "Valor:",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: valorGastoEspontaneoo,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Valor",
                    border: OutlineInputBorder(),
                  ),
                ),
                const Text(
                  "Fecha:",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                OutlinedButton(
                  onPressed: () async {
                    fecha_gasto_espontaneo = (await seleccionarFecha())!;
                  },
                  child: const Text('Seleccionar Fecha'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.purple),
                  child: MaterialButton(
                    onPressed: () async {
                      String descripcion_gasto_espontaneo = descripcionGastoEspontaneo.text;
                      int valor_gasto_espontaneo = int.parse(valorGastoEspontaneoo.text);
                      int valor = await agregarGastoEspontaneoUsuario(
                        widget.usuario.id_usuario,
                        descripcion_gasto_espontaneo,
                        valor_gasto_espontaneo,
                        fecha_gasto_espontaneo,
                      );
                      if (valor == 1) {
                        Navigator.of(context).pop();
                        mostrarDialogoAceptado();
                      } else {
                        Navigator.of(context).pop();
                        mostrarDialogoError();
                      }
                    },
                    child:
                    const Text(
                      "Agregar Gasto",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  mostrarRegistroInversion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Ingresar datos",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content:
          SingleChildScrollView(
            child:
            ListBody(
              children: [
                const Text(
                  "Descripcion:",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: descripcionInversion,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Descripcion",
                    border: OutlineInputBorder(),
                  ),
                ),
                const Text(
                  "Valor:",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: valorInversion,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Valor",
                    border: OutlineInputBorder(),
                  ),
                ),
                const Text(
                  "Fecha:",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                OutlinedButton(
                  onPressed: () async {
                    fecha_inversion = (await seleccionarFecha())!;
                  },
                  child: const Text('Seleccionar Fecha'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.purple),
                  child: MaterialButton(
                    onPressed: () async {
                      String descripcion_inversion = descripcionInversion.text;
                      int valor_inversion = int.parse(valorInversion.text);
                      int valor = await agregarInversionUsuario(
                        widget.usuario.id_usuario,
                        descripcion_inversion,
                        valor_inversion,
                        fecha_inversion,
                      );
                      if (valor == 1) {
                        Navigator.of(context).pop();
                        mostrarDialogoAceptado();
                      } else {
                        Navigator.of(context).pop();
                        mostrarDialogoError();
                      }
                    },
                    child:
                    const Text(
                      "Agregar Gasto",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  mostrarRegistroIngreso() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Ingresar datos",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Text(
                  "Descripcion:",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: descripcionIngreso,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Descripcion",
                    border: OutlineInputBorder(),
                  ),
                ),
                const Text(
                  "Valor:",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: valorIngreso,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Valor",
                    border: OutlineInputBorder(),
                  ),
                ),
                const Text(
                  "Fecha:",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                OutlinedButton(
                  onPressed: () async {
                    fecha_ingreso = (await seleccionarFecha())!;
                  },
                  child: const Text('Seleccionar Fecha'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.purple),
                  child: MaterialButton(
                    onPressed: () async {
                      String descripcion_ingreso = descripcionIngreso.text;
                      int valor_ingreso = int.parse(valorIngreso.text);
                      int valor = await agregarIngreso(
                        widget.usuario.id_usuario,
                        descripcion_ingreso,
                        valor_ingreso,
                        fecha_ingreso,
                      );
                      if (valor == 1) {
                        Navigator.of(context).pop();
                        mostrarDialogoAceptado();
                      } else {
                        Navigator.of(context).pop();
                        mostrarDialogoError();
                      }
                    },
                    child: const Text(
                      "Agregar Ingreso",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  actualizarGastoEspontaneo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Actualizar datos de gasto esponteneo",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ElevatedButton.icon(
                  icon:  const Icon(Icons.person_outline_sharp, size: 18),
                  label: const Text('Descripcion'),
                  onPressed: () {showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: const Text("Nombre:", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            const Text(
                              "Ingresar nueva descripcion",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.purple,
                              ),
                            ),
                            const SizedBox(height: 20,),
                            TextFormField(
                              controller: ActualizarDescripcionGastoEspontaneo,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: "Descripcion",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              height: 45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.purple),
                              child: MaterialButton(
                                onPressed: () async {
                                  int valor = 1;
                                  if (valor == 1) {
                                    Navigator.of(context).pop();
                                    mostrarDialogoAceptado();
                                  } else {
                                    Navigator.of(context).pop();
                                    mostrarDialogoError();
                                  }
                                },
                                child: const Text(
                                  "Actializar descripcion",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });},
                ),
                ElevatedButton.icon(
                  icon:  const Icon(Icons.person_outline_sharp, size: 18),
                  label: const Text('Valor'),
                  onPressed: () {showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: const Text("Valor:", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            const Text(
                              "Ingresar el nueva valor",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.purple,
                              ),
                            ),
                            const SizedBox(height: 20,),
                            TextFormField(
                              controller: actualizarDescripcionPagoPeriodico,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: "Valor",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              height: 45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.purple),
                              child: MaterialButton(
                                onPressed: () async {
                                  int valor = 1;
                                  if (valor == 1) {
                                    Navigator.of(context).pop();
                                    mostrarDialogoAceptado();
                                  } else {
                                    Navigator.of(context).pop();
                                    mostrarDialogoError();
                                  }
                                },
                                child: const Text(
                                  "Actualizar Valor",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });},
                ),
                ElevatedButton.icon(
                  icon:  const Icon(Icons.person_outline_sharp, size: 18),
                  label: const Text('Fecha'),
                  onPressed: () {showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: const Text("Fecha:", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            const Text(
                              "Ingresar nueva fecha",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.purple,
                              ),
                            ),
                            const SizedBox(height: 20,),
                            OutlinedButton(
                              onPressed: () async {
                                fecha_ingreso = (await seleccionarFecha())!;
                              },
                              child: const Text('Seleccionar Fecha'),
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              height: 45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.purple),
                              child: MaterialButton(
                                onPressed: () async {
                                  int valor = 1;
                                  if (valor == 1) {
                                    Navigator.of(context).pop();
                                    mostrarDialogoAceptado();
                                  } else {
                                    Navigator.of(context).pop();
                                    mostrarDialogoError();
                                  }
                                },
                                child: const Text(
                                  "Actualizar fecha",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });},
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  calcularDatos(List<GastoEspontaneo> listGastoEspontaneo, List<PagoPeriodico> listPagoPeriodico, List<Inversion> listInversion, List<Ingreso> listIngreso,) {
    int sumaGasto = listGastoEspontaneo.fold(0, (previousValue, element) {
      return previousValue + element.valor;
    });
    sumaGasto = listPagoPeriodico.fold(sumaGasto, (previousValue, element) {
      return previousValue + element.valor;
    });
    sumaGasto = listInversion.fold(sumaGasto, (previousValue, element) {
      return previousValue + element.valor;
    });
    int sumaIngresos = listIngreso.fold(0, (previousValue, element) {
      return previousValue + element.valor;
    });
    int saldoTotal = sumaIngresos-sumaGasto;
    widget.usuario.total_gastos = sumaGasto;
    widget.usuario.total_ingresos = sumaIngresos;
    widget.usuario.saldo_total =saldoTotal;
    actualizarGastos(widget.usuario.id_usuario, sumaGasto);
    actualizarIngresos(widget.usuario.id_usuario, sumaIngresos);
    actualizarSaldoTotal(widget.usuario.id_usuario, saldoTotal);
  }

}