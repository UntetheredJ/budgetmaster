import 'package:budgetmaster/models/inversion.dart';
import 'package:budgetmaster/models/pago_periodico.dart';
import 'package:budgetmaster/models/ingreso.dart';
import 'package:budgetmaster/models/usuario.dart';
import 'package:budgetmaster/models/familia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budgetmaster/db/ControllerGastoEspontaneo.dart';
import 'package:budgetmaster/db/ControllerPagoPeriodico.dart';
import 'package:budgetmaster/db/ControllerInversion.dart';
import 'package:budgetmaster/db/ControllerIngreso.dart';
import 'package:budgetmaster/db/ControllerFamilia.dart';
import 'package:budgetmaster/screens/service.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class family extends StatefulWidget {
  final Usuario usuario;

  const family({Key? key, required this.usuario})
      : super(key: key);

  @override
  _Family createState() => _Family();
}

class _Family extends State<family>{
  //Familia
  List<Familia> familias = [];
  var familiaSeleccionada = null;
  var idFamilia = "";
  var gastosFamilia = 0;
  var ingresosFamilia = 0;

  Future<void> listarFamilias () async {
    List<Familia> listaF = await listarFamilia(widget.usuario.id_usuario);
    setState(() {
      familias = listaF;
    });
  }

  @override
  void initState() {
    super.initState();
    listarFamilias();
  }

  // Validacion
  final _formKey = GlobalKey<FormState>();

  //Calculos
  late List<PagoPeriodico> listPagoPeriodico;
  late List<Inversion> listInversion;
  late List<Ingreso> listIngreso;

  bool _isLoading = false;

  // Formato
  final currencyFormat = NumberFormat.simpleCurrency(locale: "es_US");

  // Agregar Gasto
  var descripcionGasto = TextEditingController();
  var valorGasto = TextEditingController();
  DateTime fecha_gasto = DateTime.now();

  // Notificacion
  Random random =  Random();

  //Actualizar Datos
  var actualizar_Descripcion = TextEditingController();
  var actualizar_Valor = TextEditingController();
  DateTime actualizar_fecha = DateTime.now();

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
                                Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: const Text("Elegir Grupo",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black)),
                                ),
                                Container(
                                  height: 50,
                                  child: DropdownButton(
                                    value: familiaSeleccionada,
                                    items: familias.map((Familia familia) {
                                      return DropdownMenuItem(
                                        value: familia,
                                        child: Text(familia.nombre),
                                      );
                                    }).toList(),
                                    onChanged: (nuevaFamilia) {
                                      setState(() {
                                        familiaSeleccionada = nuevaFamilia!;
                                        idFamilia = familiaSeleccionada.id_familia;
                                        gastosFamilia = familiaSeleccionada.gasto_total;
                                        ingresosFamilia = familiaSeleccionada.saldo_total;
                                      });
                                    },
                                  ),
                                ),
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
                                                if (idFamilia == "") {
                                                  return const AlertDialog(
                                                    title: Text(
                                                      "Error",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                    content: Text("No se ha seleccionado un grupo"),
                                                  );
                                                }  else {
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
                                                                  child: Text("Pago Periodico")),
                                                              DropdownMenuItem(
                                                                  value: 2,
                                                                  child: Text("Inversion")),
                                                            ],
                                                            onChanged: (value) {
                                                              if (value == 1) {
                                                                Navigator.of(context).pop();
                                                                mostrarRegistroGasto(1);
                                                              } else if (value == 2) {
                                                                Navigator.of(context).pop();
                                                                mostrarRegistroGasto(2);
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
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
                                          FutureBuilder<List<PagoPeriodico>>(
                                            future: listaPagoPeriodicoFamilia(idFamilia),
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
                                                                      actualizarGasto(2, pago.id_gasto);
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
                                                                                    _loadData();
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
                                            future: listaInversionFamilia(idFamilia),
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
                                                                    onPressed: () {
                                                                      actualizarGasto(3, inversion.id_gasto);
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
                                                                                  int valor = await eliminarInversion(inversion.id_gasto);
                                                                                  if(valor == 1) {
                                                                                    _loadData();
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
                                        "Total de Gastos:",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(10.0),
                                      child: Text(
                                        currencyFormat.format(gastosFamilia),
                                        style: const TextStyle(
                                            fontSize: 20, color: Color(0xFF7B1FA2)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10.0),
                                      child: const Text(
                                        "Total de Ingresos:",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(10.0),
                                      child: Text(
                                        currencyFormat.format(ingresosFamilia),
                                        style: const TextStyle(
                                            fontSize: 20, color: Color(0xFF7B1FA2)),
                                      ),
                                    ),
                                  ],
                                ),
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
    calcularDatos(listPagoPeriodico, listInversion);
  }

  mostrarRegistroGasto(int tipo) {
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
            content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      const Text(
                        "Descripcion:",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: descripcionGasto,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Descripcion",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor complete este campo';
                          } else if (value.length > 12) {
                            return 'El tamaño de la cadena es muy grande';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const Text(
                        "Valor:",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: valorGasto,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Valor",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor complete este campo';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 5,
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
                          fecha_gasto = (await seleccionarFecha())!;
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
                            if (_formKey.currentState!.validate()) {
                              String descripcion = descripcionGasto.text;
                              int valor_pago = int.parse(valorGasto.text);
                              var valor;
                              if (tipo == 1) {
                                valor = await agregarPagoPeriodicoFamilia(
                                    idFamilia,
                                    descripcion,
                                    valor_pago,
                                    fecha_gasto);
                              } else if (tipo == 2) {
                                valor = await agregarInversionFamilia(
                                    idFamilia,
                                    descripcion,
                                    valor_pago,
                                    fecha_gasto);
                              }
                              if (valor == 1) {
                                Navigator.of(context).pop();
                                _loadData();
                                mostrarDialogoAceptado();
                              } else {
                                Navigator.of(context).pop();
                                mostrarDialogoError();
                              }
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
                )
            )
        );
      },
    );
  }

  actualizarGasto(int tipo, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Actualizar datos de gasto",
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
                  icon:  const Icon(Icons.article, size: 18),
                  label: const Text('Descripcion'),
                  onPressed: () {showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: const Text("Descripcion:", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                      content: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
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
                                  controller: actualizar_Descripcion,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    labelText: "Descripcion",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor complete este campo';
                                    }  else if (value.length > 12) {
                                      return 'El tamaño de la cadena es muy grande';
                                    }else {
                                      return null;
                                    }
                                  },
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
                                      if(_formKey.currentState!.validate()) {
                                        var valor;
                                        String descripcion = actualizar_Descripcion.text;
                                        if (tipo == 2) {
                                          valor = await actualizarDescripcionPagoPeriodico(id, descripcion);
                                        } else if (tipo == 3) {
                                          valor = await actualizarDescripcionInversion(id, descripcion);
                                        }
                                        if (valor == 1) {
                                          Navigator.of(context).pop();
                                          _loadData();
                                          mostrarDialogoAceptado();
                                        } else {
                                          Navigator.of(context).pop();
                                          mostrarDialogoError();
                                        }
                                      }
                                    },
                                    child: const Text(
                                      "Actualizar descripcion",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    );
                  });},
                ),
                ElevatedButton.icon(
                  icon:  const Icon(Icons.paid, size: 18),
                  label: const Text('Valor'),
                  onPressed: () {showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: const Text("Valor:", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                      content: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: ListBody(
                              children: [
                                const Text(
                                  "Ingresar el nuevo valor",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.purple,
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                TextFormField(
                                  controller: actualizar_Valor,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: "Valor",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor complete este campo';
                                    } else {
                                      return null;
                                    }
                                  },
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
                                      if(_formKey.currentState!.validate()) {
                                        var valor;
                                        int total =  int.parse(actualizar_Valor.text);
                                        if (tipo == 1) {
                                          valor = await actualizarValorGastoEspontaneo(id, total);
                                        } else if (tipo == 2) {
                                          valor = await actualizarValorPagoPeriodico(id, total);
                                        } else if (tipo == 3) {
                                          valor = await actualizarValorInversion(id, total);
                                        } else if (tipo == 4) {
                                          valor = await actualizarValorIngreso(id, total);
                                        }
                                        if (valor == 1) {
                                          Navigator.of(context).pop();
                                          _loadData();
                                          mostrarDialogoAceptado();
                                        } else {
                                          Navigator.of(context).pop();
                                          mostrarDialogoError();
                                        }
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
                          )
                      ),
                    );
                  });},
                ),
                ElevatedButton.icon(
                  icon:  const Icon(Icons.event, size: 18),
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
                                actualizar_fecha = (await seleccionarFecha())!;
                              },
                              child: const Text('Seleccionar Fecha'),
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              height: 45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.purple
                              ),
                              child: MaterialButton(
                                onPressed: () async {
                                  var valor;
                                  if (tipo == 1) {
                                    valor = await actualizarFechaGastoEspontaneo(id, actualizar_fecha);
                                  } else if (tipo == 2) {
                                    valor = await actualizarFechaPagoPeriodico(id, actualizar_fecha);
                                  } else if (tipo == 3) {
                                    valor = await actualizarFechaInversion(id, actualizar_fecha);
                                  } else if (tipo == 4) {
                                    valor = await actualizarFechaIngreso(id, actualizar_fecha);
                                  }
                                  if (valor == 1) {
                                    Navigator.of(context).pop();
                                    _loadData();
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

  calcularDatos(List<PagoPeriodico> listPagoPeriodico, List<Inversion> listInversion) {
    if (familiaSeleccionada != "") {
      int ingresos = 0;
      for (var miembro in familiaSeleccionada.miembros) {
        //ingresos = ingresos + miembro.saldo_total;
        debugPrint(miembro);
      }
    }

  }

}