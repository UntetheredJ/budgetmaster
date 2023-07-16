import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:budgetmaster/db/supabaseConnection.dart';
import 'package:budgetmaster/functions.dart';
import 'package:budgetmaster/models/gasto_espontaneo.dart';


Future<int> agregarGastoEspontaneoUsuario(
    String id_usuario, String descripcion, int valor, DateTime fecha) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  String id = randomDigits(10);
  String fechaPostgres = convertDate(fecha);
  try {
    await cliente.from('gasto_espontaneo').insert({
      'id_gasto_espontaneo': id,
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

Future<int> eliminarGastoEspontaneoUsuario(String id_gasto_espontaneo) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente
        .from('gasto_espontaneo')
        .delete()
        .match({"id_gasto_espontaneo": id_gasto_espontaneo});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarDescripcionGastoEspontaneo(String di_gasto_espontaneo, String descripcion) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente.from('gasto_espontaneo')
        .update({"descripcion": descripcion})
        .match({"id_gasto_espontaneo": di_gasto_espontaneo});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarValorGastoEspontaneo(String di_gasto_espontaneo, int valor) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente.from('gasto_espontaneo')
        .update({"valor": valor})
        .match({"id_gasto_espontaneo": di_gasto_espontaneo});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarFechaGastoEspontaneo(String di_gasto_espontaneo, DateTime fecha) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  String fechaPosgress = convertDate(fecha);
  try {
    await cliente.from('gasto_espontaneo')
        .update({"fecha": fechaPosgress})
        .match({"id_gasto_espontaneo": di_gasto_espontaneo});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<List<GastoEspontaneo>> listaGastoEspontaneo(String id_usuario) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  List<GastoEspontaneo> listaGastosEspontaneos = [];
  try {
    final data = await cliente
        .from('gasto_espontaneo')
        .select('id_gasto_espontaneo, descripcion, valor, fecha, id_usuario')
        .eq('id_usuario', id_usuario);
    if (data.isNotEmpty) {
      for (var i in data) {
        Map<String, dynamic> dato = i;
        GastoEspontaneo gasto = GastoEspontaneo(
            id_gasto_espontaneo: dato['id_gasto_espontaneo'],
            descripcion: dato['descripcion'],
            valor: dato['valor'],
            fecha: converDateTime(dato['fecha']),
            id_usuario: dato['id_usuario']);
        listaGastosEspontaneos.add(gasto);
      }
      return listaGastosEspontaneos;
    } else {
      return listaGastosEspontaneos;
    }
  } catch (e) {
    return listaGastosEspontaneos;
  }
}