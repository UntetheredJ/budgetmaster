import 'dart:math';

import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:budgetmaster/models/usuario.dart';

Future<Usuario> iniciarSesion(String correo, String contrasenna) async {
  var connection = PostgreSQLConnection(
    "kashin.db.elephantsql.com", 5432, "fgfaxyng",
    username: "fgfaxyng",
    password: "3A4Y2DXvEXxC6ekNqAr4eCctzJtxWzS_",
    useSSL: true,
  );
  Usuario usuario = Usuario.sinDatos();
  await connection.open();
  try {
    List<Map<String, Map<String, dynamic>>> result = await connection
        .mappedResultsQuery("SELECT * FROM budgetmaster.usuario u WHERE u.correo = @correo AND u.contrasenna = @contrasenna",
        substitutionValues: {
          "correo": correo,
          "contrasenna": contrasenna,
        });
    if (result.isNotEmpty) {
      Map<String, dynamic> firstRow = result.first.values.first;
      usuario = Usuario(
        firstRow['id_usuario'],
        firstRow['usuario'],
        firstRow['nombre'],
        firstRow['correo'],
        firstRow['contrasenna'],
      );
    }
    await connection.close();
    debugPrint("Correcto");
    return usuario;
  } catch (e) {
    debugPrint(e.toString());
    return usuario;
  }
}

Future<int> registroUsuario(String usuario, String nombre, String correo, String contrasenna) async {
  String randomDigits(int length) {
    final random = Random();
    String result = '';
    for (int i = 0; i < length; i++) {
      int digit = random.nextInt(10);
      result += digit.toString();
    }
    return result;
  }

  var connection = PostgreSQLConnection(
    "kashin.db.elephantsql.com", 5432, "fgfaxyng",
    username: "fgfaxyng",
    password: "3A4Y2DXvEXxC6ekNqAr4eCctzJtxWzS_",
    useSSL: true,
  );
  try {
    await connection.open();
    var id = randomDigits(10);
    debugPrint(id);
    await connection.query("INSERT INTO budgetmaster.usuario (id_usuario, usuario, nombre, correo, contrasenna) VALUES(@id_usuario, @usuario, @nombre, @correo, @contrasenna)",
        substitutionValues: {
          "id_usuario" : id,
          "usuario": usuario,
          "nombre": nombre,
          "correo": correo,
          "contrasenna": contrasenna,
        });
    await connection.close();
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}