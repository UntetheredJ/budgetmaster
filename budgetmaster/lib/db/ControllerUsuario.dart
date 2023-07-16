import 'package:budgetmaster/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:budgetmaster/db/supabaseConnection.dart';
import 'package:budgetmaster/functions.dart';

Future<Usuario> login(String correo, String contrasenna) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  Usuario usuario = Usuario.sinDatos();
  try {
    final data = await cliente
        .from('usuario')
        .select()
        .eq('usuario', correo)
        .eq('contrasenna', contrasenna);
    if (data.isNotEmpty) {
      Map<String, dynamic> dato = data[0];
      usuario = Usuario(dato['id_usuario'], dato['nombre'], dato['usuario'],
          dato['contrasenna'], dato['saldo_total'], dato['total_ahorrado'],
          dato['total_gastos'], dato['total_ingresos']);
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

Future<int> registroUsuario(
    String nombre, String usuario, String contrasenna) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    var id = randomDigits(10);
    await cliente.from('usuario').insert({
      'id_usuario': id,
      'nombre': nombre,
      'usuario': usuario,
      'contrasenna': contrasenna,
      'saldo_total': 0,
      'total_ahorrado': 0,
      'total_gastos': 0
    });
    debugPrint(id);
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarUsuario(String newusuario, String usuario) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente
        .from('usuario')
        .update({'usuario': newusuario}).match({'usuario': usuario});
    debugPrint("Correcto, correo actualizado");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarContrasenna(String newcontrasenna, String usuario) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente
        .from('usuario')
        .update({'contrasenna': newcontrasenna}).match({'usuario': usuario});
    debugPrint("Correcto, cambio de contraseña realizado");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarGastos(String id_usuario, int total_gastos) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente.from('usuario')
        .update({"total_gastos": total_gastos})
        .match({"id_usuario": id_usuario});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarIngresos(String id_usuario, int total_ingresos) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente.from('usuario')
        .update({"total_ingresos": total_ingresos})
        .match({"id_usuario": id_usuario});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarSaldoTotal(String id_usuario, int saldo_total) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente.from('usuario')
        .update({"saldo_total": saldo_total})
        .match({"id_usuario": id_usuario});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<List<String>> listarId(String id_familia) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  List<String> lista = [];
  try {
    final data = await cliente
        .from("usuario_familia")
        .select("id_usuario")
        .eq("id_familia", id_familia);
    if (data.isNotEmpty) {
      for (var i in data) {
        Map<String, dynamic> dato = i;
        String id = dato["id_usuario"];
        lista.add(id);
      }
    }
    return lista;
  } catch (e) {
    debugPrint(e.toString());
    return lista;
  }
}