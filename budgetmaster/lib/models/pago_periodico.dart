import 'package:budgetmaster/models/gasto.dart';

class PagoPeriodico extends Gasto{
  DateTime fecha_pago;
  DateTime vencimiento;
  String id_usuario;
  String id_familia;

  PagoPeriodico({
    required String id_pago_periodico,
    required String descripcion,
    required int valor,
    required this.fecha_pago,
    required this.vencimiento,
    required this.id_usuario,
    required this.id_familia
  }) : super(id_pago_periodico, descripcion, valor);

  PagoPeriodico.usuario({
    required String id_pago_periodico,
    required String descripcion,
    required int valor,
    required this.fecha_pago,
    required this.vencimiento,
    required this.id_usuario,
    this.id_familia = 'null'
  }) : super(id_pago_periodico, descripcion, valor);

  PagoPeriodico.familia({
    required String id_pago_periodico,
    required String descripcion,
    required int valor,
    required this.fecha_pago,
    required this.vencimiento,
    required this.id_familia,
    this.id_usuario = 'null'
  }) : super(id_pago_periodico, descripcion, valor);
}