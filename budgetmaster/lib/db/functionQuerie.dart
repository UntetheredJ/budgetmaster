import 'package:budgetmaster/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:budgetmaster/db/supabaseConnection.dart';
import 'package:budgetmaster/functions.dart';
import 'package:budgetmaster/models/gasto_espontaneo.dart';
import 'package:budgetmaster/models/pago_periodico.dart';
import 'package:budgetmaster/models/inversion.dart';
import 'package:budgetmaster/models/ingreso.dart';


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
      usuario = Usuario(
          dato['id_usuario'],
          dato['nombre'],
          dato['usuario'],
          dato['contrasenna'],
          dato['saldo_total'],
          dato['total_ahorrado']
      );
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

Future<int> registroUsuario(String nombre, String usuario, String contrasenna) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    var id = randomDigits(10);
    await cliente
        .from('usuario')
        .insert(
        {'id_usuario':id, 'nombre':nombre, 'usuario':usuario, 'contrasenna':contrasenna, 'saldo_total':0, 'total_ahorrado':0}
    );
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
        .update({ 'usuario': newusuario})
        .match({ 'usuario': usuario }
    );
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
        .update({ 'contrasenna': newcontrasenna})
        .match({ 'usuario': usuario }
    );
    debugPrint("Correcto, cambio de contraseña realizado");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> agregarPagoPeriodicoUsuario(String id_usuario, String descripcion, int valor, DateTime fecha, DateTime vencimineto) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  String id = randomDigits(10);
  String fechaPostgres = convertDate(fecha);
  String fechaVenciminetoPostgres = convertDate(vencimineto);
  try {
    await cliente.from('pago_periodico').insert({
      'id_pago_periodico': id,
      'descripcion': descripcion,
      'valor': valor,
      'fecha_pago': fechaPostgres,
      'vencimiento': fechaVenciminetoPostgres,
      'id_usuario': id_usuario,
    });
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> agregarGastoEspontaneoUsuario(String id_usuario,String descripcion, int valor, DateTime fecha) async {
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

Future<int> agregarInversionUsuario(String id_usuario, String descripcion, int valor, DateTime fecha) async {
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

Future<int> agregarIngreso(String id_usuario, String descripcion, int valor, DateTime fecha) async {
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

Future<List<PagoPeriodico>> listaPagoPeriodico(String id_usuario) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  List<PagoPeriodico> listaPagoPeriodico = [];
  try {
    final data = await cliente
        .from('pago_periodico')
        .select('id_pago_periodico, descripcion, valor, fecha, id_usuario')
        .eq('id_usuario', id_usuario);
    if (data.isNotEmpty) {
      for (var i in data) {
        Map<String, dynamic> dato = i;
        PagoPeriodico pago = PagoPeriodico(
            id_pago_periodico: dato['id_pago_periodico'],
            descripcion: dato['descripcion'],
            valor: dato['valor'],
            fecha_pago: converDateTime(dato['fecha']),
            id_usuario: dato['id_usuario'],
            vencimiento: converDateTime(dato['vencimiento']),
            id_familia: dato['id_usuario']);
        listaPagoPeriodico.add(pago);
      }
      debugPrint("Correcto");
      return listaPagoPeriodico;
    } else {
      return listaPagoPeriodico;
    }
  } catch (e) {
    debugPrint(e.toString());
    return listaPagoPeriodico;
  }
}