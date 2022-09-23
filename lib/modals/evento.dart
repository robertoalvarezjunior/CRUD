class Evento {
  //Título, descrição, data do evento, horário, local, público
  late String id;
  late String titulo;
  late String descricao;
  late String data;
  late String horario;
  late String local;
  late String publico;

  Evento({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.data,
    required this.horario,
    required this.local,
    required this.publico,
  });
}
