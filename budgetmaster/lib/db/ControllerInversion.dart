import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:budgetmaster/db/supabaseConnection.dart';
import 'package:budgetmaster/functions.dart';
import 'package:budgetmaster/models/inversion.dart';

Future<int> agregarInversionUsuario(
    String id_usuario, String descripcion, int valor, DateTime fecha) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  String id = randomDigits(10);
  String fechaPostgres = convertDate(fecha);
  try {
    await cliente.from('inversion').insert({
      'id_inversion': id,
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

Future<int> eliminarInversion(String id_inversion) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente
        .from('inversion')
        .delete()
        .match({"id_inversion": id_inversion});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarDescripcionInversion(String id_inversion, String descripcion) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente.from('inversion')
        .update({"descripcion": descripcion})
        .match({"id_inversion": id_inversion});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarValorInversion(String id_inversion, int valor) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente.from('inversion')
        .update({"valor": valor})
        .match({"id_inversion": id_inversion});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarFechaInversion(String id_inversion, DateTime fecha) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  String fechaPosgress = convertDate(fecha);
  try {
    await cliente.from('inversion')
        .update({"fecha": fechaPosgress})
        .match({"id_inversion": id_inversion});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<List<Inversion>> listaInversion(String id_usuario) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  List<Inversion> listaInversiones = [];
  try {
    final data = await cliente
        .from('inversion')
        .select('id_inversion, descripcion, valor, fecha, id_usuario')
        .eq('id_usuario', id_usuario);
    if (data.isNotEmpty) {
      for (var i in data) {
        Map<String, dynamic> dato = i;
        Inversion inversion = Inversion.usuario(
          id_inversion: dato['id_inversion'],
          descripcion: dato['descripcion'],
          valor: dato['valor'],
          fecha: converDateTime(dato['fecha']),
          id_usuario: dato['id_usuario'],
        );
        listaInversiones.add(inversion);
      }
      return listaInversiones;
    } else {
      return listaInversiones;
    }
  } catch (e) {
    debugPrint(e.toString());
    return listaInversiones;
  }
}