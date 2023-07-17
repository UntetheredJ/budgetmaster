import 'dart:math';

import 'package:budgetmaster/db/ControllerPagoPeriodico.dart';
import 'package:budgetmaster/models/pago_periodico.dart';
import 'package:budgetmaster/screens/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../models/gasto_espontaneo.dart';
import '../models/usuario.dart';

class InicioWidget extends StatefulWidget {
  final PanelController panelController;
  final Usuario usuario;

  InicioWidget({Key? key, required this.panelController, required this.usuario})
      : super(key: key);

  @override
  State<InicioWidget> createState() => _InicioWidgetState();
}

class _InicioWidgetState extends State<InicioWidget> {
  Random random = Random();
  late ScrollController scrollController;
  bool isOpen = false;

  // Formato
  final currencyFormat = NumberFormat.simpleCurrency(locale: "es_US");

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Column(
              children: [
                const SizedBox(height: 12),
                buildDragHandle(),
                //const SizedBox(height: 6),
                const Center(
                    child: Text("Próximos Pagos",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24))),
              ],
            ),
          ),
          Flexible(
            flex: 5,
            child: Container(
              width: double.infinity,
              child: GestureDetector(
                onVerticalDragStart: (details) {
                  (!details.localPosition.dy.isNegative)
                      ? widget.panelController.hide()
                      : null;
                },
                child: SingleChildScrollView(child: buildPagos()),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      );

  Widget buildPagos() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<List<PagoPeriodico>>(
            future: listaPagoPeriodicoNull(widget.usuario.id_usuario),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error al cargar los datos");
              } else {
                List<PagoPeriodico> pagosPeriodicos = snapshot.data!;
                return DataTable(
                    dividerThickness: 0,
                    dataRowMaxHeight: 75,
                    headingRowHeight: 0,
                    columnSpacing: 15,
                    columns: const [
                      DataColumn(label: Text("")),
                      DataColumn(label: Text("")),
                      DataColumn(label: Text("")),
                    ],
                    rows: pagosPeriodicos.map((pagoPeriodico) {
                      return DataRow(cells: [
                        DataCell(Container(
                          width: 5,
                          height: 60,
                          color: Colors.purple,
                          child: const Text(""),
                        )),
                        DataCell(Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "${pagoPeriodico.vencimiento.day}-${pagoPeriodico.vencimiento.month}-${pagoPeriodico.vencimiento.year}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            Row(children: <Widget>[
                              Text(pagoPeriodico.descripcion,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                currencyFormat.format(pagoPeriodico.valor),
                                style: const TextStyle(
                                    fontSize: 15, color: Color(0xFF7B1FA2)),
                              ),
                            ])
                          ],
                        )),
                        DataCell(Container(
                            height: 30,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 33, 145, 243),
                                    Color.fromARGB(255, 77, 135, 201)
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                int id=int.parse(pagoPeriodico.id_notificacion);
                                cancelNotifications(id);
                                actualizarFechaPagoPeriodico(
                                    pagoPeriodico.id_gasto, DateTime.now());



                              },
                              child: const Text("Pagar",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            )))
                      ]);
                    }).toList());
              }
            }),
      );

  Widget buildDragHandle() => GestureDetector(
        onTap: togglePanel,
        child: Center(
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                // color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12)),
            child: Icon(isOpen
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded),
          ),
        ),
      );

  void togglePanel() {
    setState(() {

      if (widget.panelController.isPanelOpen) {
        widget.panelController.close();
        isOpen = true;
      } else {
        widget.panelController.open();
        isOpen = false;
      }
    });
  }
}
