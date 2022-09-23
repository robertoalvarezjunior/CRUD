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

  Map<String, dynamic> toJson() => {
        'id': id,
        'titulo': titulo,
        'descrição': descricao,
        'data': data,
        'horario': horario,
        'local': local,
        'publico': publico,
      };

  static Evento fromJson(Map<String, dynamic> json) => Evento(
        id: json['id'],
        titulo: json['titulo'],
        descricao: json['descrição'],
        data: json['data'],
        horario: json['horario'],
        local: json['local'],
        publico: json['publico'],
      );
}
