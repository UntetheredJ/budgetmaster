import 'package:flutter/material.dart';

class InicioWidget extends StatelessWidget {
  final ScrollController controller;

  const InicioWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        controller: controller,
        children: <Widget>[
          const SizedBox(height: 12),
          buildDragHandle(),
          const SizedBox(height: 4),
          buildPagos(),
          const SizedBox(height: 24),
        ],
      );

  Widget buildPagos() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Center(
                child: Text("Próximos Pagos",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24))),
            DataTable(
                dividerThickness: 0,
                dataRowMaxHeight: 80,
                headingRowHeight: 0,
                columns: const [
                  DataColumn(label: Text("")),
                  DataColumn(label: Text("")),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(
                      Container(
                        width: 5,
                        height: 60,
                        color: Colors.purple,
                        child: const Text(""),
                      ),
                    ),
                    const DataCell(Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "07-07-2023",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        Row(children: [
                          Text(
                            "Arriendo",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ]),
                        Row(
                          children: [
                            Text(
                              "800.000",
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xFF7B1FA2)),
                            ),
                          ],
                        )
                      ],
                    )),
                  ]),
                  DataRow(cells: [
                    DataCell(
                      Container(
                        width: 5,
                        height: 60,
                        color: Colors.purple,
                        child: const Text(""),
                      ),
                    ),
                    const DataCell(Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "09-07-2023",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Movistar",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "37.000",
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xFF7B1FA2)),
                            ),
                          ],
                        )
                      ],
                    )),
                  ]),
                  DataRow(cells: [
                    DataCell(
                      Container(
                        width: 5,
                        height: 60,
                        color: Colors.purple,
                        child: const Text(""),
                      ),
                    ),
                    const DataCell(Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "15-07-2023",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Cuota Crédito",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "450.000",
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xFF7B1FA2)),
                            ),
                          ],
                        )
                      ],
                    )),
                  ]),
                ]),
          ],
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
