class Inversion{
  String id_inversion;
  String descripcion;
  int valor;
  DateTime fecha;
  String id_usuario;
  String id_familia;

  Inversion(
      this.id_inversion,
      this.descripcion,
      this.valor,
      this.fecha,
      this.id_usuario,
      this.id_familia,
    );

  Inversion.usuario(this.id_inversion, this.descripcion, this.valor, this.fecha, this.id_usuario):
        id_familia = 'null';

  Inversion.familia(this.id_inversion, this.descripcion, this.valor, this.fecha, this.id_familia):
      id_usuario = 'null';
}