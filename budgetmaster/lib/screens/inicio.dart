import 'package:budgetmaster/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:budgetmaster/widgets/inicio_widget.dart';
import 'package:budgetmaster/screens/service.dart';

class Inicio extends StatefulWidget {
  final Usuario usuario;

  Inicio({Key? key, required this.usuario}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final panelController = PanelController();
  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.12;
    final currencyFormat = NumberFormat.simpleCurrency(locale: "es_US");

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
        panelBuilder: (scrollController) => InicioWidget(
          usuario: widget.usuario,
          panelController: panelController,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        backdropEnabled: true,
        isDraggable: false,
        controller: panelController,
        minHeight: panelHeightClosed,
        /* collapsed: Column(
          children: <Widget>[
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              color: Colors.white,
              child: const Center(
                child: Text(
                  "Ver Próximos de Pagos",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                    ),
                ),
              )
            ),
            const SizedBox(height: 12),
          ],
        ), */
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
                        widget.usuario.nombre,
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
                                    color: Colors.black.withOpacity(0.7)),
                                children: const <TextSpan>[
                          TextSpan(text: "Estos son tus "),
                          TextSpan(
                              text: "gastos",
                              style: TextStyle(color: Colors.purple)),
                          TextSpan(text: " mensuales:")
                        ])))
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(currencyFormat.format(widget.usuario.total_gastos),
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
                                    color: Colors.black.withOpacity(0.7)),
                                children: const <TextSpan>[
                          TextSpan(text: "Estos son tus "),
                          TextSpan(
                              text: "ingresos",
                              style: TextStyle(color: Colors.purple)),
                          TextSpan(text: " mensuales:")
                        ])))
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(currencyFormat.format(widget.usuario.total_ingresos),
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
                                    color: Colors.black.withOpacity(0.7)),
                                children: const <TextSpan>[
                          TextSpan(text: "Tu "),
                          TextSpan(
                              text: "saldo disponible",
                              style: TextStyle(color: Colors.purple)),
                          TextSpan(text: " es:")
                        ])))
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(currencyFormat.format(widget.usuario.saldo_total),
                          style: const TextStyle(
                            fontSize: 34,
                            color: Colors.purple,
                          ))
                    ],
                  ),
                ],
              ))),
        ),
      ),
    );
  }
}
