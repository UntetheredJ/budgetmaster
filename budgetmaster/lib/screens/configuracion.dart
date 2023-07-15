import 'package:flutter/material.dart';
import 'package:budgetmaster/models/usuario.dart';
import 'package:budgetmaster/widgets/form_password.dart';
import 'package:budgetmaster/widgets/form_email.dart';

class Configuracion extends StatelessWidget {
  final Usuario usuario;
  const Configuracion({Key? key ,required this.usuario}) : super(key: key);

@override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
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
                    Container(
                      height: 40,
                      width: screenWidth*0.7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.purple),
                 child: ElevatedButton.icon(
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
                    ),
                    const SizedBox(height: 10,),

                    Container(
                      height: 40,
                      width: screenWidth*0.7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.purple),


                child:ElevatedButton.icon(
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
                               children: [ FormEmail(usuario: usuario,) ],
                            ),

                              ],
                            ),
                          ),
                        );

                      });},
                    ),
                    ),
                    const SizedBox(height: 10,),

                    Container(
                      height: 40,
                      width: screenWidth*0.7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.purple),

                child: ElevatedButton.icon(
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
                              children: [FormPassword(usuario: usuario,)],
                            ),

                          ],
                        ),
                      ),
                    );

                  });},
                ),
                    ),
                    const SizedBox(height: 10,),


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



