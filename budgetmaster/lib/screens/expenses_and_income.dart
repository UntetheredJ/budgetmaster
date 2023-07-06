import 'package:budgetmaster/models/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class expenses_and_income extends StatelessWidget {
  final Usuario usuario;
  const expenses_and_income({Key? key, required this.usuario}) : super(key: key);

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
              child: Column(
                children: [
                  Container(
                    decoration:  BoxDecoration(
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
                                child: Text("Gastos", style: TextStyle(fontSize: 25, color: Colors.black)),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10.0),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0xFF7B1FA2),
                                ),
                                child: MaterialButton(
                                  onPressed: () { },
                                  child: const Text('+',
                                    style:  TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          DataTable(
                            dataRowHeight: 70,
                            headingRowHeight: 0,
                              columnSpacing: 15,
                              columns: const [
                                DataColumn(label: Text(""), numeric: true, tooltip: 'Color'),
                                DataColumn(label: Text("")),
                                DataColumn(label: Text("")),
                              ],
                              rows: [
                                DataRow(
                                    cells: [
                                      DataCell(
                                        Container(
                                          width: 5,
                                          height: 60,
                                          color: Colors.lightBlue,
                                          child: Text(""),
                                        ),
                                      ),
                                      const DataCell(
                                        Column(
                                          children: [
                                            Text("Mercado", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                            Row(
                                              children: [
                                                Text("Espontaneo - "),
                                                Text("300.000",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                      color: Color(0xFF7B1FA2)
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ),
                                      DataCell(
                                        Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(10.0),
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                color: Colors.amber,
                                              ),
                                              child: MaterialButton(
                                                onPressed: () { },
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
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
                                              child: MaterialButton(
                                                onPressed: () { },
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                ),
                                              ),
                                          ],
                                        )
                                      ),
                                    ]
                                ),
                                DataRow(
                                    cells: [
                                      DataCell(
                                        Container(
                                          width: 5,
                                          height: 60,
                                          color: Colors.purple,
                                          child: Text(""),
                                        ),
                                      ),
                                      const DataCell(
                                          Column(
                                            children: [
                                              Text("Arriendo", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                              Row(
                                                children: [
                                                  Text("Fijo - "),
                                                  Text("800.000",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Color(0xFF7B1FA2)
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                      ),
                                      DataCell(
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.all(10.0),
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  color: Colors.amber,
                                                ),
                                                child: MaterialButton(
                                                  onPressed: () { },
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
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
                                                child: MaterialButton(
                                                  onPressed: () { },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                    ]
                                ),
                                DataRow(
                                    cells: [
                                      DataCell(
                                        Container(
                                          width: 5,
                                          height: 60,
                                          color: Colors.green,
                                          child: Text(""),
                                        ),
                                      ),
                                      const DataCell(
                                          Column(
                                            children: [
                                              Text("Empresa Tal", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                              Row(
                                                children: [
                                                  Text("Inversion - "),
                                                  Text("800.000",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Color(0xFF7B1FA2)
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                      ),
                                      DataCell(
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.all(10.0),
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  color: Colors.amber,
                                                ),
                                                child: MaterialButton(
                                                  onPressed: () { },
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
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
                                                child: MaterialButton(
                                                  onPressed: () { },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                    ]
                                ),
                              ]
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10.0),
                                child: Text("Total:", style: TextStyle(fontSize: 20),),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10.0),
                                child: const Text("6.100.000",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF7B1FA2)
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10.0),
                                child: Text("Ingresos", style: TextStyle(fontSize: 25, color: Colors.black)),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10.0),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0xFF7B1FA2),
                                ),
                                child: MaterialButton(
                                  onPressed: () { },
                                  child: const Text('+',
                                    style:  TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          DataTable(
                              dataRowHeight: 70,
                              headingRowHeight: 0,
                              columnSpacing: 15,
                              columns: const [
                                DataColumn(label: Text(""), numeric: true, tooltip: 'Color'),
                                DataColumn(label: Text("")),
                                DataColumn(label: Text("")),
                              ],
                              rows: [
                                DataRow(
                                    cells: [
                                      DataCell(
                                        Container(
                                          width: 5,
                                          height: 60,
                                          color: Colors.purple,
                                          child: Text(""),
                                        ),
                                      ),
                                      const DataCell(
                                          Column(
                                            children: [
                                              Text("Salario", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                              Text("1.500.000",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xFF7B1FA2)
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                      DataCell(
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.all(10.0),
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  color: Colors.amber,
                                                ),
                                                child: MaterialButton(
                                                  onPressed: () { },
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
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
                                                child: MaterialButton(
                                                  onPressed: () { },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                    ]
                                ),
                                DataRow(
                                    cells: [
                                      DataCell(
                                        Container(
                                          width: 5,
                                          height: 60,
                                          color: Colors.purple,
                                          child: Text(""),
                                        ),
                                      ),
                                      const DataCell(
                                          Column(
                                            children: [
                                              Text("Hijo", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                              Text("150.000",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xFF7B1FA2)
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                      DataCell(
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.all(10.0),
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  color: Colors.amber,
                                                ),
                                                child: MaterialButton(
                                                  onPressed: () { },
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
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
                                                child: MaterialButton(
                                                  onPressed: () { },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                    ]
                                ),
                                DataRow(
                                    cells: [
                                      DataCell(
                                        Container(
                                          width: 5,
                                          height: 60,
                                          color: Colors.purple,
                                          child: Text(""),
                                        ),
                                      ),
                                      const DataCell(
                                          Column(
                                            children: [
                                              Text("Otros", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                              Text("10.000",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xFF7B1FA2)
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                      DataCell(
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.all(10.0),
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  color: Colors.amber,
                                                ),
                                                child: MaterialButton(
                                                  onPressed: () { },
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
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
                                                child: MaterialButton(
                                                  onPressed: () { },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                    ]
                                ),
                              ]
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10.0),
                                child: Text("Total:", style: TextStyle(fontSize: 20),),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10.0),
                                child: const Text("1.560.000",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF7B1FA2)
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    )
                  ),

                ],
              )
            )
        ),
      ),
    );
  }
}