import 'package:flutter/material.dart';
import 'package:budgetmaster/models/usuario.dart';
import 'package:budgetmaster/db/ControllerUsuario.dart';

// Define a custom Form widget.
class FormPassword extends StatefulWidget {
  final Usuario usuario;
  const FormPassword({Key? key ,required this.usuario}) : super(key: key);

  @override
  FormPasswordState createState() {
    return FormPasswordState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class FormPasswordState extends State<FormPassword> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  var newUsuarioController = TextEditingController();
  var newcontrasenna1Controller = TextEditingController();
  var newcontrasenna2Controller = TextEditingController();
  var contrasennaController = TextEditingController();
  bool isObscure_1 = true;
  bool isObscure_2 = true;
  bool isObscure_3 = true;

  @override
  Widget build(BuildContext context) {

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child:  Column(
        children: <Widget>[
          const SizedBox(height: 10,),
          const Text("Ingrese contraseña actual:", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          TextFormField(
            controller: contrasennaController,
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
          if (value == null || value.isEmpty) {
            return 'Por favor complete este campo';
          }
          else if (contrasennaController.text != widget.usuario.contrasenna) {
            return 'Contraseña incorrecta';
          }

          return null;
        },
         ),
          const SizedBox(height: 10,),
          const Text("Ingrese nueva contraseña:", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),

          TextFormField(
            controller: newcontrasenna1Controller,
            keyboardType: TextInputType.visiblePassword,
            obscureText: isObscure_2,
            decoration:  InputDecoration(
                labelText: "Contraseña",
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
          const SizedBox(height: 10,),
          const Text("Confirmar nueva contraseña:", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          TextFormField(
            controller: newcontrasenna2Controller,
            keyboardType:  TextInputType.visiblePassword,
            obscureText: isObscure_3,
            decoration: InputDecoration(
                labelText: "Contraseña",
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.password),
                suffixIcon: IconButton(
                    icon: Icon(
                        isObscure_3 ? Icons.visibility_off : Icons.visibility
                    ),
                    onPressed: () {
                      setState(() {
                        isObscure_3 = !isObscure_3;
                      });
                    })
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor complete este campo';
              }

              else if ( newcontrasenna1Controller.text != newcontrasenna2Controller.text) {
                // 3
                return "Las contraseñas no coinciden";
              }

              return null;
            },
          ),

          const SizedBox(height: 10,),
          Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: const LinearGradient(
                  colors: [Colors.yellow, Colors.green],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft),
            ),
            child: MaterialButton(
              onPressed: () async {

                String contrasenna1 = newcontrasenna1Controller.text;
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Realizando registro')),
                  );
                  int valor = await actualizarContrasenna(contrasenna1, widget.usuario.usuario);
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
                "Guardar cambios",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),

          ),
          const SizedBox(height: 10,),

        ],
      ),
    );
  }
}