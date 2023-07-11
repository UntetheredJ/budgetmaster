import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:budgetmaster/db/supabaseConnection.dart';
import 'package:budgetmaster/functions.dart';
import 'package:budgetmaster/models/ingreso.dart';

Future<int> agregarIngreso(
    String id_usuario, String descripcion, int valor, DateTime fecha) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  String id = randomDigits(10);
  String fechaPostgres = convertDate(fecha);
  try {
    await cliente.from('ingreso').insert({
      'id_ingreso': id,
      'descripcion': descripcion,
      'valor': valor,
      'fecha': fechaPostgres,
      'id_usuario': id_usuario,
    });
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> eliminarIngreso(String id_ingreso) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente.from('ingreso').delete().match({"id_ingreso": id_ingreso});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarDescripcionIngreso(String id_ingreso, String descripcion) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente.from('ingreso')
        .update({"descripcion": descripcion})
        .match({"id_ingreso": id_ingreso});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarValorIngreso(String id_ingreso, int valor) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente.from('ingreso')
        .update({"valor": valor})
        .match({"id_ingreso": id_ingreso});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarFechaIngreso(String id_ingreso, DateTime fecha) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  String fechaPosgress = convertDate(fecha);
  try {
    await cliente.from('ingreso')
        .update({"fecha": fechaPosgress})
        .match({"id_ingreso": id_ingreso});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<List<Ingreso>> listaIngresos(String id_usuario) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  List<Ingreso> listaIngresos = [];
  try {
    final data = await cliente
        .from('ingreso')
        .select('id_ingreso, descripcion, valor, fecha, id_usuario')
        .eq('id_usuario', id_usuario);
    if (data.isNotEmpty) {
      for (var i in data) {
        Map<String, dynamic> dato = i;
        Ingreso ingreso = Ingreso(dato['id_ingreso'], dato['descripcion'],
            dato['valor'], converDateTime(dato['fecha']), dato['id_usuario']);
        listaIngresos.add(ingreso);
      }
      return listaIngresos;
    } else {
      return listaIngresos;
    }
  } catch (e) {
    debugPrint(e.toString());
    return listaIngresos;
  }
}