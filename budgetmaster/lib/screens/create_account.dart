import 'package:flutter/material.dart';
import 'package:budgetmaster/widgets/form.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  //_CreateAccountState createState() => _CreateAccountState();
  State<CreateAccount> createState() {
    // Avoid using private types in public APIs.
    return _CreateAccountState();
  }
}

class _CreateAccountState extends State<CreateAccount> {
  var usuarioController = TextEditingController();
  var nombreController = TextEditingController();
  var contrasennaController1 = TextEditingController();
  var contrasennaController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7B1FA2),
        centerTitle: true,
        title: const Text(
          'Creación de Cuenta',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: const SafeArea(
        child:  Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Icon(
                    Icons.auto_graph_rounded,
                    size: 70,
                    color: Colors.deepPurpleAccent,
                  ),
                   Text(
                    "Budget Master",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      color: Colors.deepPurple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                   SizedBox(
                    height: 25,
                  ),
                  MyCustomForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}