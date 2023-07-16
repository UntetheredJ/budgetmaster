import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:budgetmaster/db/supabaseConnection.dart';
import 'package:budgetmaster/functions.dart';
import 'package:budgetmaster/models/pago_periodico.dart';

Future<int> agregarPagoPeriodicoUsuario(String id_usuario, String descripcion,
    int valor, DateTime vencimineto, id_notificacion) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  String id = randomDigits(10);
  String fechaVenciminetoPostgres = convertDate(vencimineto);
  try {
    await cliente.from('pago_periodico').insert({
      'id_pago_periodico': id,
      'descripcion': descripcion,
      'valor': valor,
      'vencimiento': fechaVenciminetoPostgres,
      'id_usuario': id_usuario,
      'id_notificacion': id_notificacion,
    });
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> agregarPagoPeriodicoFamilia(String id_familia, String descripcion,
    int valor, DateTime vencimineto) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  String id = randomDigits(10);
  String fechaVenciminetoPostgres = convertDate(vencimineto);
  try {
    await cliente.from('pago_periodico').insert({
      'id_pago_periodico': id,
      'descripcion': descripcion,
      'valor': valor,
      'vencimiento': fechaVenciminetoPostgres,
      'id_familia': id_familia,
    });
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> eliminarPagoPeriodicoUsuario(String id_pago_periodico) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente
        .from('pago_periodico')
        .delete()
        .match({"id_pago_periodico": id_pago_periodico});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarDescripcionPagoPeriodico(
    String id_pago_periodico, String descripcion) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente
        .from('pago_periodico')
        .update({"descripcion": descripcion})
        .match({"id_pago_periodico": id_pago_periodico});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarValorPagoPeriodico(
    String id_pago_periodico, int valor) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  try {
    await cliente.from('pago_periodico').update({"valor": valor}).match(
        {"id_pago_periodico": id_pago_periodico});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<int> actualizarFechaPagoPeriodico(
    String id_pago_periodico, DateTime fecha) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  String fechaPosgress = convertDate(fecha);
  try {
    await cliente
        .from('pago_periodico')
        .update({"fecha_pago": fechaPosgress}).match(
            {"id_pago_periodico": id_pago_periodico});
    debugPrint("Correcto");
    return 1;
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<List<PagoPeriodico>> listaPagoPeriodico(String id_usuario) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  List<PagoPeriodico> listaPagoPeriodico = [];
  try {
    final data = await cliente
        .from('pago_periodico')
        .select(
            'id_pago_periodico, descripcion, valor, fecha_pago, vencimiento, id_usuario')
        .eq('id_usuario', id_usuario);
    if (data.isNotEmpty) {
      for (var i in data) {
        Map<String, dynamic> dato = i;
        DateTime fecha_pago;
        if (dato['fecha_pago'] == null) {
          fecha_pago = DateTime(0, 0, 0, 0, 0, 0, 0, 0);
        } else {
          fecha_pago = converDateTime(dato['fecha_pago']);
        }
        String id_notificacion;
        if (dato['id_notificacion'] == null) {
          id_notificacion = "";
        } else {
          id_notificacion = dato['id_notificacion'];
        }
        PagoPeriodico pago = PagoPeriodico.usuario(
            id_pago_periodico: dato['id_pago_periodico'],
            descripcion: dato['descripcion'],
            valor: dato['valor'],
            fecha_pago: fecha_pago,
            vencimiento: converDateTime(dato['vencimiento']),
            id_usuario: dato['id_usuario'],
            id_notificacion: id_notificacion
        );
        listaPagoPeriodico.add(pago);
      }
      return listaPagoPeriodico;
    } else {
      return listaPagoPeriodico;
    }
  } catch (e) {
    debugPrint(e.toString());
    return listaPagoPeriodico;
  }
}

Future<List<PagoPeriodico>> listaPagoPeriodicoFamilia(String id_familia) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  List<PagoPeriodico> listaPagoPeriodico = [];
  try {
    final data = await cliente
        .from('pago_periodico')
        .select(
        'id_pago_periodico, descripcion, valor, fecha_pago, vencimiento, id_familia')
        .eq('id_familia', id_familia);
    if (data.isNotEmpty) {
      for (var i in data) {
        Map<String, dynamic> dato = i;
        DateTime fecha_pago;
        if (dato['fecha_pago'] == null) {
          fecha_pago = DateTime(0, 0, 0, 0, 0, 0, 0, 0);
        } else {
          fecha_pago = converDateTime(dato['fecha_pago']);
        }
        String id_notificacion;
        if (dato['id_notificacion'] == null) {
          id_notificacion = "";
        } else {
          id_notificacion = dato['id_notificacion'];
        }
        PagoPeriodico pago = PagoPeriodico.familia(
            id_pago_periodico: dato['id_pago_periodico'],
            descripcion: dato['descripcion'],
            valor: dato['valor'],
            fecha_pago: fecha_pago,
            vencimiento: converDateTime(dato['vencimiento']),
            id_familia: dato['id_familia'],
            id_notificacion: id_notificacion
        );
        listaPagoPeriodico.add(pago);
      }
      return listaPagoPeriodico;
    } else {
      return listaPagoPeriodico;
    }
  } catch (e) {
    debugPrint(e.toString());
    return listaPagoPeriodico;
  }
}

Future<List<PagoPeriodico>> listaPagoPeriodicoNull(String id_usuario) async {
  final SupabaseService _supabaseService = SupabaseService();
  SupabaseClient cliente = _supabaseService.client;
  List<PagoPeriodico> listaPagoPeriodico = [];
  try {
    final data = await cliente
        .from('pago_periodico')
        .select(
            'id_pago_periodico, descripcion, valor, fecha_pago, vencimiento, id_usuario')
        .eq('id_usuario', id_usuario)
        .is_('fecha_pago', null)
        .order("vencimiento", ascending: true);
    if (data.isNotEmpty) {
      for (var i in data) {
        Map<String, dynamic> dato = i;
        DateTime fecha_pago;
        if (dato['fecha_pago'] == null) {
          fecha_pago = DateTime(0, 0, 0, 0, 0, 0, 0, 0);
        } else {
          fecha_pago = converDateTime(dato['fecha_pago']);
        }
        String id_notificacion;
        if (dato['id_notificacion'] == null) {
          id_notificacion = "";
        } else {
          id_notificacion = dato['id_notificacion'];
        }
        PagoPeriodico pago = PagoPeriodico.usuario(
            id_pago_periodico: dato['id_pago_periodico'],
            descripcion: dato['descripcion'],
            valor: dato['valor'],
            fecha_pago: fecha_pago,
            vencimiento: converDateTime(dato['vencimiento']),
            id_usuario: dato['id_usuario'],
            id_notificacion: id_notificacion
        );
        listaPagoPeriodico.add(pago);
      }
      return listaPagoPeriodico;
    } else {
      return listaPagoPeriodico;
    }
  } catch (e) {
    debugPrint(e.toString());
    return listaPagoPeriodico;
  }
}
