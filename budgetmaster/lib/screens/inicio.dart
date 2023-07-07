import 'package:budgetmaster/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:budgetmaster/widgets/inicio_widget.dart';
import 'package:budgetmaster/screens/service.dart';

class Inicio extends StatelessWidget {
  final Usuario usuario;
  const Inicio({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7B1FA2),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Inicio",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            )),
      ),
      body: SlidingUpPanel(
        minHeight: panelHeightClosed,
        //parallaxEnabled: true,
        //parallaxOffset: .5,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Hola,",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                          child: Text(
                        usuario.nombre,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.purple,
                        ),
                      ))
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 18,
                             color: Colors.black.withOpacity(0.7)
                          ),
                          children: const <TextSpan>[
                            TextSpan(text: "Estos son tus "),
                            TextSpan(
                              text: "gastos",
                              style: TextStyle(
                                color: Colors.purple
                              )
                            ),
                            TextSpan(text: " mensuales:")
                          ]
                        )
                      )
                    )
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("\$1'160.000",
                          style: TextStyle(
                            fontSize: 34,
                            color: Colors.purple,
                          ))
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 18,
                             color: Colors.black.withOpacity(0.7)
                          ),
                          children: const <TextSpan>[
                            TextSpan(text: "Estos son tus "),
                            TextSpan(
                              text: "ingresos",
                              style: TextStyle(
                                color: Colors.purple
                              )
                            ),
                            TextSpan(text: " mensuales:")
                          ]
                        )
                      )
                    )
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("\$1'150.000",
                          style: const TextStyle(
                            fontSize: 34,
                            color: Colors.purple,
                          ))
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 18,
                             color: Colors.black.withOpacity(0.7)
                          ),
                          children: const <TextSpan>[
                            TextSpan(text: "Tu "),
                            TextSpan(
                              text: "saldo disponible",
                              style: TextStyle(
                                color: Colors.purple
                              )
                            ),
                            TextSpan(text: " es:")
                          ]
                        )
                      )
                    )
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("\$${usuario.saldo_total}",
                          style: const TextStyle(
                            fontSize: 34,
                            color: Colors.purple,
                          ))
                    ],
                  ),
                ],
              ))),
        ),
        panelBuilder: (controller) => InicioWidget(
          controller: controller,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
    );
  }

}


