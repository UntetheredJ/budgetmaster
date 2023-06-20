
import 'package:budgetmaster/db/postgressConnection.dart';
import 'package:flutter/cupertino.dart';

class Usuario{
  String id_usario;
  String nombre;
  String correo;
  String contrasenna;

  Usuario(
      this.id_usario,
      this.nombre,
      this.correo,
      this.contrasenna,
      );

  Usuario.sinDatos():
      id_usario = 'null', nombre = 'null', correo = 'null', contrasenna = 'null';
}