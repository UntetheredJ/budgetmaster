import 'package:flutter/material.dart';
import 'package:budgetmaster/db/ControllerUsuario.dart';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  var usuarioController = TextEditingController();
  var nombreController = TextEditingController();
  var contrasennaController1 = TextEditingController();
  var contrasennaController2 = TextEditingController();

  bool isObscure_1 = true;
  bool isObscure_2 = true;

  @override
  Widget build(BuildContext context) {

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child:  Column(
        children: <Widget>[
          TextFormField(
            controller: nombreController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Nombre",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.account_box),
            ),
            validator: (value) {
              RegExp regex = RegExp(r'^[ a-zA-Z0-9_.+-]{1,40}');
              if (value == null || value.isEmpty) {
                return 'Por favor complete este campo';
              }
              else if (!regex.hasMatch(value)) {
                // 3
                return "Nombre no válido";
              }

              else {
              return null;
              }
            },
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
              RegExp regex = RegExp(r"^[a-zA-Z0-9_!#$%&'\*+/=?{|}~^.-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-]+[a-zA-Z0-9_.][a-zA-Z0-9_]+[a-zA-Z0-9_.][a-zA-Z0-9_]+$");
              if (value == null || value.isEmpty) {
                return 'Por favor complete este campo';
              }
              else if (!regex.hasMatch(value)) {
                // 3
                return "Correo no válido";
              }

              else {
                return null;
              }
            },

          ),

          const SizedBox(
            height: 25,
          ),
          TextFormField(
            controller: contrasennaController1,
            keyboardType: TextInputType.visiblePassword,
            obscureText: isObscure_1,
            decoration:  InputDecoration(
              labelText: "Contraseña",
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                  icon: Icon(
                      isObscure_1 ? Icons.visibility_off : Icons.visibility
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure_1 = !isObscure_1;
                    });
                  })
            ),
            validator: (value) {
              RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#&?])[A-Za-z\d@$!#%*?&]{5,20}$');
              if (value == null || value.isEmpty) {
                return 'Por favor complete este campo';
              }
              else if (!regex.hasMatch(value)) {
                // 3
                return "Contraseña no válida";
              }

              return null;
            },
          ),

          Text(
            "La contraseña debe tener entre 5 y 20 caracteres y estar compuesta por letras minúsculas, mayúsculas, números y mínimo un caracter especial (@\$!%*#&?)",
            style: TextStyle(
              color: Colors.grey.withOpacity(0.7),
              fontSize: 12,
            ),
          ),

          const SizedBox(
            height: 25,
          ),
          TextFormField(
            controller: contrasennaController2,
            keyboardType: TextInputType.visiblePassword,
            obscureText: isObscure_2,
            decoration:  InputDecoration(
              labelText: "Confirmar contraseña",
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                  icon: Icon(
                      isObscure_2 ? Icons.visibility_off : Icons.visibility
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure_2 = !isObscure_2;
                    });
                  })),

            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor complete este campo';
              }

              else if ( contrasennaController1.text != contrasennaController2.text) {
                // 3
                return "Las contraseñas no coinciden";
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
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Realizando registro')),
                  );
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
                  }
                } else {
                   // ignore: use_build_context_synchronously
                      showDialog(
                       context: context,
                       builder: (BuildContext context) {
                        return const AlertDialog(
                          title: Text("Ocurrió un error"),
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
    );
  }
}