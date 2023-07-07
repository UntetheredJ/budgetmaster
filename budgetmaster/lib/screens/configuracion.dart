import 'package:flutter/material.dart';
import 'package:budgetmaster/models/usuario.dart';
import 'package:budgetmaster/db/functionQuerie.dart';

class Configuracion extends StatelessWidget {
  var newUsuarioController = TextEditingController();
  var newcontrasenna1Controller = TextEditingController();
  var newcontrasenna2Controller = TextEditingController();
  var contrasennaController = TextEditingController();
  final Usuario usuario;
  Configuracion({Key? key ,required this.usuario}) : super(key: key);

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color(0xFF7B1FA2),
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text("Configuración",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          )),

    ),
    body:  SafeArea(
     child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(2.0),

        child: Column(
          children: [
            const Text('Información de cuenta', style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            ExpansionTile(
              leading:  const CircleAvatar(
                backgroundColor: Colors.deepPurpleAccent,
                child: Icon(Icons.settings, size: 20,),
              ),
              title: const Text('Inicio de sesión y seguridad'),
              // Contents
              children: [

                ElevatedButton.icon(
                  icon:  const Icon(Icons.person_outline_sharp, size: 18),
                  label: const Text('Nombre'),
                  onPressed: () {showDialog(context: context, builder: (BuildContext context){
                    return  AlertDialog(
                      title: const Text("Nombre:", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            Text(
                              usuario.nombre,

                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.purple,
                              ),
                            ),
                            const SizedBox(height: 20,),


                          ],
                        ),
                      ),
                    );

                  });},
                ),


                ElevatedButton.icon(
                      icon:  const Icon(Icons.mail, size: 18),
                      label: const Text('Correo'),
                      onPressed: () {showDialog(context: context, builder: (BuildContext context){
                        return  AlertDialog(
                          title: const Text("Su correo electrónico es:", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                 Text(
                                  usuario.usuario,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.purple,
                                  ),
                                ),
                                const SizedBox(height: 20,),
                             ExpansionTile(
                               leading:  const CircleAvatar(
                                 backgroundColor: Colors.deepPurpleAccent,
                                 child: Icon(Icons.edit, size: 20,),
                               ),
                               title:  const Text("Actualizar correo:", style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),),
                               // Contents
                               children: [
                                const SizedBox(height: 10,),
                                const Text("Ingrese correo electrónico:", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10,),
                                TextFormField(
                                  controller: newUsuarioController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    labelText: "Correo electrónico",
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.email),
                                  ),
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
                                      String newUsuario = newUsuarioController.text;
                                      int valor = await actualizarUsuario(newUsuario, usuario.usuario);

                                      if (valor == 1) {
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Correcto"),
                                              content: Text("Se ha actualizado su correo electrónico. Vuelva a iniciar sesión para visualizar los cambios"),
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
                                      }  else {
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const AlertDialog(
                                                title: Text("Error"),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: [
                                                      Text("No se pudo actualizar el correo")
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

                              ],
                            ),
                          ),
                        );

                      });},
                    ),

                ElevatedButton.icon(
                  icon:  const Icon(Icons.password, size: 18),
                  label: const Text('Contraseña'),
                  onPressed: () {showDialog(context: context, builder: (BuildContext context){
                    return  AlertDialog(
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            const SizedBox(height: 20,),
                            ExpansionTile(
                              leading:  const CircleAvatar(
                                backgroundColor: Colors.deepPurpleAccent,
                                child: Icon(Icons.edit, size: 20,),
                              ),
                              title:  const Text("Cambiar contraseña:", style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),),
                              // Contents
                              children: [
                                const SizedBox(height: 10,),
                                const Text("Ingrese contraseña actual:", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10,),
                                TextFormField(
                                  controller: contrasennaController,
                                  keyboardType:  TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: "Contraseña",
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.password),
                                  ),
                                ),

                                const SizedBox(height: 10,),
                                const Text("Ingrese nueva contraseña:", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10,),
                                TextFormField(
                                  controller: newcontrasenna1Controller,
                                  keyboardType:  TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: "Contraseña",
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.password),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                const Text("Confirmar nueva contraseña:", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10,),
                                TextFormField(
                                  controller: newcontrasenna2Controller,
                                  keyboardType:  TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: "Contraseña",
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.password),
                                  ),
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
                                      String contrasenna = contrasennaController.text;
                                      String contrasenna1 = newcontrasenna1Controller.text;
                                      String contrasenna2 = newcontrasenna2Controller.text;
                                      if (contrasenna == usuario.contrasenna && contrasenna1 == contrasenna2) {
                                        int valor = await actualizarContrasenna(contrasenna1, usuario.usuario);

                                      if (valor == 1) {
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Correcto"),
                                              content: Text("Se ha cambio su contraseña. Vuelva a iniciar sesión para visualizar los cambios"),
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
                                      }  else {
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const AlertDialog(
                                                title: Text("Error"),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: [
                                                      Text("No se pudo actualizar la contraseña")
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                        );
                                      }
                                      }
                                      else {
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

                          ],
                        ),
                      ),
                    );

                  });},
                ),


              ],
            ),

            const ExpansionTile(
              leading:  CircleAvatar(
                backgroundColor: Colors.deepPurpleAccent,
                child: Icon(Icons.mail, size: 20,),
              ),
              title: Text('Grupo Familiar'),
              // Contents
              children: [
                ExpansionTile(
                  leading:  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.email, size: 20,),
                  ),
                  title: Text('Gestión de grupo familiar'),
                  // Contents
                  children: [
                    ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                        title: Text('Blue')),
                  ],
                ),
              ],
            ),

            const ExpansionTile(
              leading:  CircleAvatar(
                backgroundColor: Colors.deepPurpleAccent,
                child: Icon(Icons.ring_volume_sharp, size: 20,),
              ),
              title: Text('Ajuste de Notificaciones'),
              // Contents
              children: [
                ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                    ),
                    title: Text('Blue')),

              ],
            ),

            const SizedBox(height: 10,),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: const LinearGradient(
                    colors: [Colors.orangeAccent, Colors.red],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft),
              ),

                child: MaterialButton(
                onPressed: () async {

                },
                child: const Text(
                  "Cerrar sesión",
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
  );
}
}



