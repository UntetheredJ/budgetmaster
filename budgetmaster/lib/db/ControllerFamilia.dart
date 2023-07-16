import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:budgetmaster/db/supabaseConnection.dart';
import 'package:budgetmaster/models/familia.dart';
import 'package:budgetmaster/models/usuario.dart';
import 'ControllerUsuario.dart';
import 'package:budgetmaster/functions.dart';

Future<int> primerMiembro(String id_familia, String id_usuario) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    var id = randomDigits(10);
    await cliente
        .from('usuario_familia')
        .insert({
      'id_usuario_familia': id,
      'id_usuario': id_usuario,
      'id_familia': id_familia
    });
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> crearFamilia(String nombre, String id_usuario) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    var id = randomDigits(10);
    await cliente
        .from('familia')
        .insert({
      'id_familia': id,
      'nombre': nombre,
      'total_ahorrado': 0,
      'saldo_total': 0,
      'gasto_total': 0,
      'ingreso_total': 0
    });
    await primerMiembro(id, id_usuario);
    debugPrint(id);
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarFamilia(String nombre, String id_familia) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente
        .from('familia')
        .update({'nombre': nombre})
        .match({'id_familia': id_familia});
    debugPrint("Correcto, correo actualizado");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> agregarMiembro(String correo, String id_familia) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    String id_usuario = await buscarIdPorCorreo(correo);
    if (id_usuario != "" || id_usuario != "Error") {
      var id = randomDigits(10);
      await cliente.from('usuario_familia')
          .insert({
        'id_usuario_familia': id,
        'id_usuario': id_usuario,
        'id_familia': id_familia
      });
      debugPrint(id);
      debugPrint("Correcto");
    }
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> salirFamilia(String id_familia, String id_usuario) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente
        .from("usuario_familia")
        .delete()
        .match({"id_usuario": id_usuario, "id_familia": id_familia});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

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
            dato["ingreso_total"],
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
            .select()
            .eq("id_usuario", id);
        if (data.isNotEmpty) {
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

Future<int> actualizarIngresoFamilia(String id_familia, int ingresos) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente.from('familia')
        .update({"ingreso_total": ingresos})
        .match({"id_familia": id_familia});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarGastosFamilia(String id_familia, int gastos) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente.from('familia')
        .update({"gasto_total": gastos})
        .match({"id_familia": id_familia});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarSaldoTotalFamilia(String id_familia, int saldo_total) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente.from('familia')
        .update({"saldo_total": saldo_total})
        .match({"id_familia": id_familia});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}