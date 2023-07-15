import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:budgetmaster/db/supabaseConnection.dart';
import 'package:budgetmaster/models/familia.dart';
import 'package:budgetmaster/models/usuario.dart';

import 'ControllerUsuario.dart';

Future<List<String>> listarIdFamilia(String id_usuario) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  List<String> lista_id = [];
  try {
    final data = await cliente.from("usuario_familia")
        .select("id_familia")
        .eq("id_usuario", id_usuario);
    if (data.isNotEmpty) {
      for (var i in data) {
        Map<String, dynamic> dato = i;
        String id = dato["id_familia"];
        lista_id.add(id);
      }
      return lista_id;
    } else {
      return lista_id;
    }
  } catch (e) {
    debugPrint(e.toString());
    return lista_id;
  }
}

Future<List<Familia>> listarFamilia(String id_usuario) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  List<Familia> familias = [];
  try {
    final listaId = await listarIdFamilia(id_usuario);
    for (var i in listaId) {
      final data = await cliente
          .from("familia")
          .select("*")
          .eq("id_familia", i);
      if (data.isNotEmpty) {
        Map<String, dynamic> dato = data[0];
        List<Usuario> lista = await listarUsuarioPorFamilia(dato["id_familia"]);
        Familia familia = Familia(
            dato["id_familia"],
            dato["nombre"],
            dato["total_ahorrado"],
            dato["saldo_total"],
            dato["gasto_total"],
            lista
        );
        familias.add(familia);
      }
    }
    return familias;
  } catch (e) {
    debugPrint(e.toString());
    return familias;
  }
}

Future<List<Usuario>> listarUsuarioPorFamilia(String id_familia) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  List<String> ids = await listarId(id_familia);
  List<Usuario> lista = [];
  try {
      for (var id in ids) {
        final data = await cliente
            .from("usuario")
            .select("")
            .eq("id_usuario", id);
        if (data.isNotEmpity) {
          Map<String, dynamic> dato = data[0];
          Usuario usuario = Usuario(
              dato["id_usuario"],
              dato["nombre"],
              dato["usuario"],
              dato["contrasenna"],
              dato["saldo_total"],
              dato["total_ahorrado"],
              dato["total_gastos"],
              dato["total_ingresos"]
          );
          lista.add(usuario);
        }
      }
    return lista;
  } catch (e) {
    debugPrint(e.toString());
    return lista;
  }
}