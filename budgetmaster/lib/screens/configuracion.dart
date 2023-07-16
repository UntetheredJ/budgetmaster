import 'package:budgetmaster/db/ControllerUsuario.dart';
import 'package:flutter/material.dart';
import 'package:budgetmaster/models/usuario.dart';
import 'package:budgetmaster/widgets/form_password.dart';
import 'package:budgetmaster/widgets/form_email.dart';
import 'package:budgetmaster/screens/service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../db/ControllerFamilia.dart';
import '../models/familia.dart';
import '../widgets/switch_notification.dart';

class Configuracion extends StatefulWidget {
  final Usuario usuario;

  const Configuracion({Key? key, required this.usuario}) : super(key: key);

  @override
  _Configuracion createState() => _Configuracion();
}
class _Configuracion extends State<Configuracion>{
  //Familia
  List<Familia> familias = [];
  var familiaSeleccionada = null;
  var idFamilia = "";

  Future<void> listarFamilias () async {
    List<Familia> listaF = await listarFamilia(widget.usuario.id_usuario);
    setState(() {
      familias = listaF;
    });
  }

  @override
  void initState() {
    super.initState();
    listarFamilias();
  }

  final _formKey = GlobalKey<FormState>();
  final _formKeyAgregar = GlobalKey<FormState>();
  final _formKeyEditar = GlobalKey<FormState>();

  var nombreFamilia = TextEditingController();

  @override
  Widget build(BuildContext context) {

    mostrarDialogoAceptado() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Correcto"),
            content: Text("La operacion se ejecuto correctamente"),
            actions: <Widget>[
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.pop(context);
                  List<Familia> listaF = await listarFamilia(widget.usuario.id_usuario);
                  setState(() {
                    familias = listaF;
                  });
                },
              ),
            ],
          );
        },
      );
    }

    mostrarDialogoError(){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Ocurrio un error en la operacion"),
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

    crearGrupo() {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title:
              const Text(
                "Ingresar datos",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        const Text(
                          "Nombre:",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: nombreFamilia,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Nombre",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor complete este campo';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.purple),
                          child: MaterialButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                String nombre = nombreFamilia.text;
                                var valor = await crearFamilia(nombre, widget.usuario.id_usuario);
                                if (valor == 1) {
                                  Navigator.pop(context);
                                  mostrarDialogoAceptado();
                                } else {
                                  Navigator.pop(context);
                                  mostrarDialogoError();
                                }
                              }
                            },
                            child:
                            const Text(
                              "Crear Grupo",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              )
          );
        },
      );
    }

    editarGrupo() {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title:
              const Text(
                "Ingresar datos",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Form(
                  key: _formKeyEditar,
                  child: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        const Text(
                          "Seleccionar grupo:",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Center(
                          child: Container(
                            height: 50,
                            child: DropdownButtonFormField(
                              value: familiaSeleccionada,
                              items: familias.map((Familia familia) {
                                return DropdownMenuItem(
                                  value: familia,
                                  child: Text(familia.nombre),
                                );
                              }).toList(),
                              onChanged: (nuevaFamilia) {
                                setState(() {
                                  familiaSeleccionada = nuevaFamilia!;
                                  idFamilia = familiaSeleccionada.id_familia;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Nombre del grupo:",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: nombreFamilia,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: "Nombre",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor complete este campo';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.purple),
                          child: MaterialButton(
                            onPressed: () async {
                              if (_formKeyEditar.currentState!.validate()) {
                                if (idFamilia == "") {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content: Text("Seleccione un grupo"),
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
                                  String nombre = nombreFamilia.text;
                                  var valor = await actualizarFamilia(nombre, idFamilia);
                                  if (valor == 1) {
                                    Navigator.pop(context);
                                    mostrarDialogoAceptado();
                                  } else {
                                    Navigator.pop(context);
                                    mostrarDialogoError();
                                  }
                                }
                              }
                            },
                            child:
                            const Text(
                              "Actualizar",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              )
          );
        },
      );
    }

    editarMiembros() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Miembros del grupo:",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              content: Form(
                key: _formKeyAgregar,
                child: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      const Text(
                        "Seleccionar grupo:",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 50,
                          child: DropdownButtonFormField(
                            value: familiaSeleccionada,
                            items: familias.map((Familia familia) {
                              return DropdownMenuItem(
                                value: familia,
                                child: Text(familia.nombre),
                              );
                            }).toList(),
                            onChanged: (nuevaFamilia) {
                              setState(() {
                                familiaSeleccionada = nuevaFamilia!;
                                idFamilia = familiaSeleccionada.id_familia;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Correo del miembro:",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      TextFormField(
                        controller: nombreFamilia,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Correo",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor complete este campo';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.purple),
                        child: MaterialButton(
                          onPressed: () async {
                            if (_formKeyAgregar.currentState!.validate()) {
                              if (idFamilia == "") {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text("Seleccione un grupo"),
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
                                String correo = nombreFamilia.text;
                                var val = await validar(correo);
                                if(val == "No existe") {
                                  // ignore: use_build_context_synchronously
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content: Text("Este usuario no existe"),
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
                                } else if (val == "Existe") {
                                  var valor = await agregarMiembro(correo, idFamilia);
                                  if (valor == 1) {
                                    Navigator.pop(context);
                                    mostrarDialogoAceptado();
                                  } else {
                                    Navigator.pop(context);
                                    mostrarDialogoError();
                                  }
                                }
                              }
                            }
                          },
                          child:
                          const Text(
                            "Agregar Miembro",
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
              ),
            );
          });
    }

    salirGrupo () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Salir de grupo:",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    const Text(
                      "Seleccionar grupo:",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        child: DropdownButtonFormField(
                          value: familiaSeleccionada,
                          items: familias.map((Familia familia) {
                            return DropdownMenuItem(
                              value: familia,
                              child: Text(familia.nombre),
                            );
                          }).toList(),
                          onChanged: (nuevaFamilia) {
                            setState(() {
                              familiaSeleccionada = nuevaFamilia!;
                              idFamilia = familiaSeleccionada.id_familia;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.purple),
                      child: MaterialButton(
                        onPressed: () async {
                          if (idFamilia == "") {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text("Seleccione un grupo"),
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
                            var valor = await salirFamilia(idFamilia, widget.usuario.id_usuario);
                            if (valor == 1) {
                              Navigator.pop(context);
                              mostrarDialogoAceptado();
                            } else {
                              Navigator.pop(context);
                              mostrarDialogoError();
                            }
                          }
                        },
                        child:
                        const Text(
                          "Salir",
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
          });
    }

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                const Text(
                  'Información de cuenta',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                ExpansionTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent,
                    child: Icon(
                      Icons.settings,
                      size: 20,
                    ),
                  ),
                  title: const Text('Inicio de sesión y seguridad'),
                  // Contents

                  children: [
                    Container(
                      height: 40,
                      width: screenWidth * 0.7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.purple),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.person_outline_sharp, size: 18),
                        label: const Text('Nombre'),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    "Nombre:",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        Text(
                                          widget.usuario.nombre,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.purple,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      width: screenWidth * 0.7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.purple),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.mail, size: 18),
                        label: const Text('Correo'),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    "Su correo electrónico es:",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        Text(
                                          widget.usuario.usuario,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.purple,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        ExpansionTile(
                                          leading: const CircleAvatar(
                                            backgroundColor:
                                                Colors.deepPurpleAccent,
                                            child: Icon(
                                              Icons.edit,
                                              size: 20,
                                            ),
                                          ),
                                          title: const Text(
                                            "Actualizar correo:",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // Contents
                                          children: [
                                            FormEmail(
                                              usuario: widget.usuario,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      width: screenWidth * 0.7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.purple),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.password, size: 18),
                        label: const Text('Contraseña'),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        ExpansionTile(
                                          leading: const CircleAvatar(
                                            backgroundColor:
                                                Colors.deepPurpleAccent,
                                            child: Icon(
                                              Icons.edit,
                                              size: 20,
                                            ),
                                          ),
                                          title: const Text(
                                            "Cambiar contraseña:",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // Contents
                                          children: [
                                            FormPassword(
                                              usuario: widget.usuario,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent,
                    child: Icon(
                      Icons.group,
                      size: 20,
                    ),
                  ),
                  title: const Text('Grupo Familiar'),
                  // Contents
                  children: [
                    Container(
                      height: 40,
                      width: screenWidth * 0.7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.purple),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.group, size: 18),
                        label: const Text('Crear Grupo'),
                        onPressed: () {
                          crearGrupo();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      width: screenWidth * 0.7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.purple),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.group_add, size: 18),
                        label: const Text('Agregar miembros'),
                        onPressed: () {
                          editarMiembros();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      width: screenWidth * 0.7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.purple),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.edit, size: 18),
                        label: const Text('Editar Grupo'),
                        onPressed: () {
                          editarGrupo();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      width: screenWidth * 0.7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.purple),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.logout, size: 18),
                        label: const Text('Salir de grupo'),
                        onPressed: () {
                          salirGrupo();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent,
                    child: Icon(
                      Icons.ring_volume_sharp,
                      size: 20,
                    ),
                  ),
                  title: Text('Ajuste de Notificaciones'),

                  // Contents
                  children: [
                    SwitchExample(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
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
                      List<PendingNotificationRequest> activeNotifications =
                          await flutterLocalNotificationsPlugin
                              .pendingNotificationRequests();
                      for (PendingNotificationRequest notification
                          in activeNotifications) {
                        debugPrint(notification.title);
                        debugPrint(notification.body);
                      }
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
