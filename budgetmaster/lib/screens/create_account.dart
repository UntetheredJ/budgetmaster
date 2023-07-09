import 'package:flutter/material.dart';
import 'package:budgetmaster/db/functionQuerie.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Icon(
                    Icons.auto_graph_rounded,
                    size: 70,
                    color: Colors.deepPurpleAccent,
                  ),
                  const Text(
                    "Budget Master",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      color: Colors.deepPurple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: nombreController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Nombre",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.account_box),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: usuarioController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Correo electrónico",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: contrasennaController1,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Contraseña",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.remove_red_eye),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: contrasennaController2,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Confirmar contraseña",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.remove_red_eye),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.purple],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft),
                    ),
                    child: MaterialButton(
                      onPressed: () async {
                        String nombre = nombreController.text;
                        String usuario = usuarioController.text;
                        String contrasenna1 = contrasennaController1.text;
                        String contrasenna2 = contrasennaController2.text;
                        if (contrasenna1 == contrasenna2) {
                          int valor = await registroUsuario(nombre, usuario, contrasenna1);
                          if (valor == 1) {
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Correcto"),
                                  content: Text("Se ha creado correctamente"),
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
                                    title: Text("Ocurrio un error"),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          Text("No se pudo crear")
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            );
                          }
                        } else {
                          // ignore: use_build_context_synchronously
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  title: Text("Alerta"),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        Text("Incosistencia en contraseña")
                                      ],
                                    ),
                                  ),
                                );
                              }
                          );
                        }
                      },
                      child: const Text(
                        "Crear Cuenta",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}