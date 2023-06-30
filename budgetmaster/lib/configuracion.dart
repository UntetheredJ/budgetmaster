import 'package:flutter/material.dart';
import 'package:budgetmaster/models/usuario.dart';

class Configuracion extends StatelessWidget {
  const Configuracion({Key? key}) : super(key: key);

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
                      icon:  const Icon(Icons.mail, size: 18),
                      label: const Text('Correo'),
                      onPressed: () {showDialog(context: context, builder: (BuildContext context){
                        return  AlertDialog(
                          title: const Text("Su correo electrónico es:", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                const Text("Actualizar correo:", style: TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),),
                                const Text("Ingrese correo electrónico:", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10,),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    labelText: "Correo electrónico",
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                ),

                                const SizedBox(height: 10,),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    gradient: const LinearGradient(
                                        colors: [Colors.yellow, Colors.green],
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
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
                              ],
                            ),
                          ),
                        );
                      });},
                    ),

                ElevatedButton.icon(
                  icon:  const Icon(Icons.phone, size: 18),
                  label: Text('Teléfono'),
                  onPressed: () {},
                ),
                ElevatedButton.icon(
                  icon:  const Icon(Icons.password, size: 18),
                  label: Text('Contraseña'),
                  onPressed: () {},
                ),

              ],
            ),

            const ExpansionTile(
              leading:  CircleAvatar(
                backgroundColor: Colors.deepPurpleAccent,
                child: Icon(Icons.settings, size: 20,),
              ),
              title: Text('Información personal'),
              // Contents
              children: [
                ExpansionTile(
                  leading:  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.email, size: 20,),
                  ),
                  title: Text('Nombres y apellidos'),
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
                onPressed: () {
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


  );
}
}