import 'package:budgetmaster/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:budgetmaster/widgets/inicio_widget.dart';

class History extends StatefulWidget {
  final Usuario usuario;

  History({Key? key, required this.usuario}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
        title: const Text("Historial",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            )),
      ),
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
    
    ],
    ))),
    ),

    );
  }
}