import 'package:budgetmaster/models/gasto.dart';

class Inversion extends Gasto{
  DateTime fecha;
  String id_usuario;
  String id_familia;

  Inversion({
    required String id_inversion,
    required String descripcion,
    required int valor,
    required this.fecha,
    required this.id_usuario,
    required this.id_familia
  }) : super(id_inversion, descripcion, valor);

  Inversion.usuario({
    required String id_inversion,
    required String descripcion,
    required int valor,
    required this.fecha,
    required this.id_usuario,
    this.id_familia = 'null'
  }) : super(id_inversion, descripcion, valor);

  Inversion.familia({
    required String id_inversion,
    required String descripcion,
    required int valor,
    required this.fecha,
    required this.id_familia,
    this.id_usuario = 'null'
  }) : super(id_inversion, descripcion, valor);
}