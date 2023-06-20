
import 'package:budgetmaster/db/postgressConnection.dart';
import 'package:flutter/cupertino.dart';

class Usuario{
  String id_usario;
  String usuario;
  String nombre;
  String correo;
  String contrasenna;

  Usuario(
      this.id_usario,
      this.usuario,
      this.nombre,
      this.correo,
      this.contrasenna,
      );

  Usuario.sinDatos():
      id_usario = 'null', usuario = 'null', nombre = 'null', correo = 'null', contrasenna = 'null';
}