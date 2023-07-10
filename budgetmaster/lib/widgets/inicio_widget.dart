import 'dart:math';

import 'package:budgetmaster/db/functionQuerie.dart';
import 'package:budgetmaster/models/pago_periodico.dart';
import 'package:budgetmaster/screens/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/gasto_espontaneo.dart';
import '../models/usuario.dart';

class InicioWidget extends StatefulWidget {
  final ScrollController controller;
  final Usuario usuario;

  const InicioWidget({
    Key? key,
    required this.controller, required this.usuario
  }) : super(key: key);

  @override
  State<InicioWidget> createState() => _InicioWidgetState();
}

class _InicioWidgetState extends State<InicioWidget> {
  Random random = Random();
  // Formato
  final currencyFormat = NumberFormat.simpleCurrency(locale: "es_US");

  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        controller: widget.controller,
        children: <Widget>[
          const SizedBox(height: 12),
          buildDragHandle(),
          const SizedBox(height: 4),
          const Center(
                child: Text("Próximos Pagos",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24)
                )
            ),
          buildPagos(),
          const SizedBox(height: 24),
        ],
      );

Widget buildPagos() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<List<PagoPeriodico>>(
          future: listaPagoPeriodicoFuturo(widget.usuario.id_usuario),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            } else if (snapshot.hasError){
              return Text("Error al cargar los datos");
            } else {
              List<PagoPeriodico> gastos = snapshot.data!;
              return DataTable(
                dividerThickness: 0,
                dataRowMaxHeight: 70,
                headingRowHeight: 0,
                columnSpacing: 15,
                columns: const[
                  DataColumn(label: Text("")),
                  DataColumn(label: Text("")),
                ],
                rows: gastos.map((pagoPeriodico){
                  mostrarNotification(
                    random.nextInt(100), 
                    "Recordatorio de Pago", 
                    "${pagoPeriodico.descripcion} por un valor de ${pagoPeriodico.valor}"
                  );
                  return DataRow(cells: [
                    DataCell(
                      Container(
                        width: 5,
                        height: 60,
                        color: Colors.purple,
                        child: const Text(""),
                      )
                    ),
                    DataCell(
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "${pagoPeriodico.vencimiento.day}-${pagoPeriodico.vencimiento.month}-${pagoPeriodico.vencimiento.year}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Row(children: [
                            Text(
                              pagoPeriodico.descripcion,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)
                            ),
                          ]),
                          Row(children: [
                            Text(
                              currencyFormat.format(pagoPeriodico.valor),
                              style: const TextStyle(
                                  fontSize: 15, color: Color(0xFF7B1FA2)),
                            ),
                          ])
                        ],
                      )
                    )
                  ]);
                }).toList()
              );
            }
          }
        ),
      );

  Widget buildDragHandle() => Center(
          child: Container(
        width: 30,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12)
        ),
      ));
}
