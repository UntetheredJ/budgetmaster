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