class PagoPeriodico{
  String id_pago_periodico;
  String descripcion;
  int valor;
  DateTime fecha_pago;
  DateTime vencimiento;
  String id_usuario;
  String id_familia;

  PagoPeriodico(
      this.id_pago_periodico,
      this.descripcion,
      this.valor,
      this.fecha_pago,
      this.vencimiento,
      this.id_usuario,
      this.id_familia,
      );

  PagoPeriodico.usuario(this.id_pago_periodico, this.descripcion, this.valor, this.fecha_pago, this.vencimiento, this.id_usuario):
        id_familia = 'null';

  PagoPeriodico.familia(this.id_pago_periodico, this.descripcion,this.valor,this.fecha_pago, this.vencimiento, this.id_familia):
        id_usuario = 'null';
}