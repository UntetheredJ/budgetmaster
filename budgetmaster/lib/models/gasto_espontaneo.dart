import 'package:budgetmaster/models/gasto.dart';

class GastoEspontaneo extends Gasto {
  DateTime fecha;
  String id_usuario;

  GastoEspontaneo({
    required String id_gasto_espontaneo,
    required String descripcion,
    required int valor,
    required this.fecha,
    required this.id_usuario
  }) : super(id_gasto_espontaneo, descripcion, valor);
}