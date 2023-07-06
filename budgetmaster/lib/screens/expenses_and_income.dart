import 'package:budgetmaster/models/gasto_espontaneo.dart';
import 'package:budgetmaster/models/ingreso.dart';
import 'package:budgetmaster/models/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budgetmaster/db/supabaseConnection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:budgetmaster/functions.dart';
import 'package:budgetmaster/screens/service.dart';

class expenses_and_income extends StatefulWidget {
  final Usuario usuario;

  const expenses_and_income({Key? key, required this.usuario})
      : super(key: key);

  @override
  _Expenses_and_income createState() => _Expenses_and_income();
}

class _Expenses_and_income extends State<expenses_and_income> {
  // Iniciar instancia de base de datos
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient get cliente => _supabaseService.client;

  // Pago Periodico
  var descripcionPagoPeriodico = TextEditingController();
  var valorPagoPeriodico = TextEditingController();
  late DateTime fecha_pago_periodico;
  late DateTime fecha_vencimiento;

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

  @override
  Widget build(BuildContext context) {
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
                                      style: TextStyle(fontSize: 25, color: Colors.black)),
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
                                              title: const Text("Seleccionar tipo de Gasto",
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
                                                            child: Text("Pago Periodico")),
                                                        DropdownMenuItem(
                                                            value: 2,
                                                            child: Text("Gasto Espontaneo")),
                                                        DropdownMenuItem(
                                                            value: 3,
                                                            child: Text("Inversion")),
                                                      ],
                                                      onChanged: (value) {
                                                        if (value == 1) {
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
                                                                        "Fecha:",
                                                                        style: TextStyle(
                                                                            fontSize: 15,
                                                                            color: Colors.black,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      OutlinedButton(
                                                                        onPressed: () async {fecha_pago_periodico = (await seleccionarFecha())!;
                                                                        },
                                                                        child: const Text('Seleccionar Fecha'),
                                                                      ),
                                                                      const Text(
                                                                        "Fecha Vencimineto:",
                                                                        style: TextStyle(
                                                                            fontSize: 15,
                                                                            color: Colors.black,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      OutlinedButton(
                                                                        onPressed: () async {fecha_vencimiento = (await seleccionarFecha())!;
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
                                                                          onPressed:
                                                                              () async {
                                                                            String descripcion_pago_periodico = descripcionPagoPeriodico.text;
                                                                            int valor_pago_periodico = int.parse(valorPagoPeriodico.text);
                                                                            int valor = await agregarPagoPeriodicoUsuario(
                                                                                descripcion_pago_periodico,
                                                                                valor_pago_periodico,
                                                                                fecha_pago_periodico,
                                                                                fecha_vencimiento);
<<<<<<< Updated upstream
                                                                            if (valor == 1) {
=======

                                                                            await initNotifications();
                                                                            mostrarNotification(valor_pago_periodico ,'Recordatorio Pago', valorPagoPeriodico.text );
                                                                            if (valor ==
                                                                                1) {
>>>>>>> Stashed changes
                                                                              // ignore: use_build_context_synchronously
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return AlertDialog(
                                                                                    title: Text("Correcto"),
                                                                                    content: Text("Se ha agregado correctamente"),
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
                                                                            } else {
                                                                              // ignore: use_build_context_synchronously
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) {
                                                                                    return const AlertDialog(
                                                                                      title: Text("Error"),
                                                                                      content: SingleChildScrollView(
                                                                                        child: ListBody(
                                                                                          children: [
                                                                                            Text("No se pudo agregar")
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  });
                                                                            }
                                                                          },
                                                                          child: const Text(
                                                                            "Agregar Gasto",
                                                                            style:
                                                                                TextStyle(
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
                                                        } else if (value == 2) {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
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
                                                                        onPressed:
                                                                            () async {fecha_gasto_espontaneo = (await seleccionarFecha())!;
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
                                                                              descripcion_gasto_espontaneo,
                                                                              valor_gasto_espontaneo,
                                                                              fecha_gasto_espontaneo,
                                                                            );
                                                                            if (valor == 1) {
                                                                              // ignore: use_build_context_synchronously
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return AlertDialog(
                                                                                    title: Text("Correcto"),
                                                                                    content: Text("Se ha agregado correctamente"),
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
                                                                            } else {
                                                                              // ignore: use_build_context_synchronously
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) {
                                                                                    return const AlertDialog(
                                                                                      title: Text("Error"),
                                                                                      content: SingleChildScrollView(
                                                                                        child: ListBody(
                                                                                          children: [
                                                                                            Text("No se pudo agregar")
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  });
                                                                            }
                                                                          },
                                                                          child: const Text(
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
                                                        } else if (value == 3) {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
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
                                                                        onPressed:
                                                                            () async {fecha_inversion = (await seleccionarFecha())!;
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
                                                                              descripcion_inversion,
                                                                              valor_inversion,
                                                                              fecha_inversion,
                                                                            );
                                                                            if (valor == 1) {
                                                                              // ignore: use_build_context_synchronously
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return AlertDialog(
                                                                                    title: Text("Correcto"),
                                                                                    content: Text("Se ha agregado correctamente"),
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
                                                                            } else {
                                                                              // ignore: use_build_context_synchronously
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) {
                                                                                    return const AlertDialog(
                                                                                      title: Text("Error"),
                                                                                      content: SingleChildScrollView(
                                                                                        child: ListBody(
                                                                                          children: [
                                                                                            Text("No se pudo agregar")
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  });
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
                            SingleChildScrollView(
                              child: FutureBuilder<List<GastoEspontaneo>>(
                                future: listaGastoEspontaneo(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error al cargar los datos');
                                  } else {
                                    List<GastoEspontaneo> gastos = snapshot.data!;
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
                                        return DataRow(cells: [
                                          DataCell(
                                            Container(
                                              width: 5,
                                              height: 60,
                                              color: Colors.lightBlue,
                                              child: Text(""),
                                            ),
                                          ),
                                          DataCell(Column(
                                            children: [
                                              Text(
                                                gastoEspontaneo.descripcion,
                                                style:const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Row(
                                                children: [
                                                  Text("Espontaneo - "),
                                                  Text(
                                                    gastoEspontaneo.valor.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Color(0xFF7B1FA2)),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )),
                                          DataCell(Row(
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
                                                  icon: const Icon(Icons.edit,
                                                      color: Colors.white, size: 20),
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
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                        ]);
                                      }).toList(),
                                    );
                                  }
                                },
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
                                  child: const Text(
                                    "6.100.000",
                                    style: TextStyle(
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
                                                    child: const Text(
                                                        'Seleccionar Fecha'),
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
                                                          descripcion_ingreso,
                                                          valor_ingreso,
                                                          fecha_ingreso,
                                                        );
                                                        if (valor == 1) {
                                                          // ignore: use_build_context_synchronously
                                                          showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return AlertDialog(
                                                                title: Text("Correcto"),
                                                                content: Text("Se ha agregado correctamente"),
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
                                                        } else {
                                                          // ignore: use_build_context_synchronously
                                                          showDialog(
                                                              context: context,
                                                              builder: (BuildContextcontext) {
                                                                return const AlertDialog(
                                                                  title: Text("Error"),
                                                                  content: SingleChildScrollView(
                                                                    child:
                                                                    ListBody(
                                                                      children: [
                                                                        Text("No se pudo agregar")
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              });
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
                            SingleChildScrollView(
                              child: FutureBuilder<List<GastoEspontaneo>>(
                                  future: listaGastoEspontaneo(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error al cargar los datos');
                                    } else {
                                      List<GastoEspontaneo> gastos = snapshot.data!;
                                      return Text("HOla");
                                    };
                                  }),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Total:",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: const Text(
                                    "1.560.000",
                                    style: TextStyle(fontSize: 20, color: Color(0xFF7B1FA2)),
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

  Future<int> agregarPagoPeriodicoUsuario(String descripcion, int valor, DateTime fecha, DateTime vencimineto) async {
    String id = randomDigits(10);
    String fechaPostgres = convertDate(fecha);
    String fechaVenciminetoPostgres = convertDate(vencimineto);
    try {
      await cliente.from('pago_periodico').insert({
        'id_pago_periodico': id,
        'descripcion': descripcion,
        'valor': valor,
        'fecha_pago': fechaPostgres,
        'vencimiento': fechaVenciminetoPostgres,
        'id_usuario': widget.usuario.id_usario,
      });
      debugPrint("Correcto");
      return 1;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  Future<int> agregarGastoEspontaneoUsuario(String descripcion, int valor, DateTime fecha) async {
    String id = randomDigits(10);
    String fechaPostgres = convertDate(fecha);
    try {
      await cliente.from('gasto_espontaneo').insert({
        'id_gasto_espontaneo': id,
        'descripcion': descripcion,
        'valor': valor,
        'fecha': fechaPostgres,
        'id_usuario': widget.usuario.id_usario,
      });
      debugPrint("Correcto");
      return 1;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  Future<int> agregarInversionUsuario(String descripcion, int valor, DateTime fecha) async {
    String id = randomDigits(10);
    String fechaPostgres = convertDate(fecha);
    try {
      await cliente.from('inversion').insert({
        'id_inversion': id,
        'descripcion': descripcion,
        'valor': valor,
        'fecha': fechaPostgres,
        'id_usuario': widget.usuario.id_usario,
      });
      debugPrint("Correcto");
      return 1;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  Future<int> agregarIngreso(String descripcion, int valor, DateTime fecha) async {
    String id = randomDigits(10);
    String fechaPostgres = convertDate(fecha);
    try {
      await cliente.from('ingreso').insert({
        'id_ingreso': id,
        'descripcion': descripcion,
        'valor': valor,
        'fecha': fechaPostgres,
        'id_usuario': widget.usuario.id_usario,
      });
      debugPrint("Correcto");
      return 1;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  Future<List<GastoEspontaneo>> listaGastoEspontaneo() async {
    List<GastoEspontaneo> listaGastosEspontaneos = [];
    try {
      final data = await cliente
          .from('gasto_espontaneo')
          .select('id_gasto_espontaneo, descripcion, valor, fecha, id_usuario')
          .eq('id_usuario', widget.usuario.id_usario);
      if (data.isNotEmpty) {
        for(var i in data) {
          Map<String, dynamic> dato = i;
          GastoEspontaneo gasto = GastoEspontaneo(
            id_gasto_espontaneo: dato['id_gasto_espontaneo'],
            descripcion: dato['descripcion'],
            valor: dato['valor'],
            fecha: converDateTime(dato['fecha']),
            id_usuario: dato['id_usuario']
          );
          listaGastosEspontaneos.add(gasto);
        }
        debugPrint("Correcto");
        return listaGastosEspontaneos;
      } else {
        return listaGastosEspontaneos;
      }
    } catch (e) {
      debugPrint(e.toString());
      return listaGastosEspontaneos;
    }
  }

  Future<List<Ingreso>> listaIngresos() async {
    List<Ingreso> listaIngresos = [];
    try {
      final data = await cliente
          .from('ingresos')
          .select('id_ingreso, descripcion, valor, fecha, id_usuario')
          .eq('id_usuario', widget.usuario.id_usario);
      if (data.isNotEmpty) {
        for(var i in data) {
          Map<String, dynamic> dato = i;
          Ingreso ingreso = Ingreso(
              dato['id_ingreso'],
              dato['descripcion'],
              dato['valor'],
              converDateTime(dato['fecha']),
              dato['id_usuario']
          );
          listaIngresos.add(ingreso);
        }
        debugPrint("Correcto");
        return listaIngresos;
      } else {
        return listaIngresos;
      }
    } catch (e) {
      debugPrint(e.toString());
      return listaIngresos;
    }
  }

}
