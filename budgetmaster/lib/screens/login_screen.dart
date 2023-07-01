import 'package:budgetmaster/db/supabaseConnection.dart';
import 'package:budgetmaster/screens/home_page.dart';
import 'package:budgetmaster/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:budgetmaster/screens/create_account.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatelessWidget {
  var correoController = TextEditingController();
  var contrasennaController = TextEditingController();

  // Iniciar instancia de base de datos
  var supabase = Connection();
  final cliente = Supabase.instance.client;

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Icon(
                Icons.account_circle,
                size: 90,
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
                controller: correoController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Correo electrónico",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: contrasennaController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Contraseña",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.remove_red_eye),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text("¿Olvidaste tu contraseña?"))
                ],
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
                    String correo = correoController.text;
                    String contrasenna = contrasennaController.text;
                    Usuario usuario = Usuario.sinDatos();
                    usuario = await login(correo, contrasenna);
                    if (correo == usuario.usuario && contrasenna == usuario.contrasenna) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                       HomePage(usuario: usuario),),);
                    } else {
                      // ignore: use_build_context_synchronously
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text("No se puede ingresar"),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    Text("Verificar sus datos")
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    }
                  },
                  child: const Text(
                    "Iniciar sesión",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 30,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¿No tienes una cuenta?",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateAccount(),
                          ),
                        );
                      },
                      child: const Text("Regístrate aquí"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Usuario> login(String correo, String contrasenna) async {
    Usuario usuario = Usuario.sinDatos();
    try {
      final data = await cliente
          .from('usuario')
          .select()
          .eq('usuario', correo)
          .eq('contrasenna', contrasenna);
      if (data.isNotEmpty) {
        Map<String, dynamic> dato = data[0];
        usuario = Usuario(
            dato['id_usuario'],
            dato['nombre'],
            dato['usuario'],
            dato['contrasenna'],
            dato['saldo_total'],
            dato['total_ahorrado']
        );
        debugPrint("Correcto");
        return usuario;
      } else {
        return usuario;
      }
    } catch (e) {
      debugPrint(e.toString());
      return usuario;
    }
  }
}
