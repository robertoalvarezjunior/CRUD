import 'package:crud/data/db.dart';
import 'package:crud/modals/evento.dart';
import 'package:crud/screens/modal_update_form.dart';
import 'package:flutter/material.dart';

class ConsultarPage extends StatefulWidget {
  const ConsultarPage({super.key, required this.lista});
  final List<Evento> lista;

  @override
  State<ConsultarPage> createState() => _ConsultarPageState();
}

class _ConsultarPageState extends State<ConsultarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Consulta'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<List<Evento>>(
        stream: readEvento(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Algo deu errado');
          } else if (snapshot.hasData) {
            final event = snapshot.data!;

            return ListView(
              children: event.map(_buildEvento).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildEvento(Evento e) => Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: ListTile(
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'O que deseja fazer?',
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          _edit(
                            id: e.id,
                            titulo: e.titulo,
                            descricao: e.descricao,
                            data: e.data,
                            horario: e.horario,
                            local: e.local,
                            publico: e.publico,
                          );
                        },
                        child: const Text(
                          'Editar',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _delete(e.id);
                        },
                        child: const Text(
                          'Excluir',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.more_vert),
            ),
            title: Center(
              child: Text(
                e.titulo,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            subtitle: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Data: ${e.data}'),
                    Text('Hora: ${e.horario}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Local: ${e.local}'),
                    Text('Publico: ${e.publico}'),
                  ],
                ),
                Text(
                  e.descricao,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      );

  Stream<List<Evento>> readEvento() =>
      DB.db.collection('evento').snapshots().map(
          (event) => event.docs.map((e) => Evento.fromJson(e.data())).toList());

  _edit({id, titulo, descricao, data, horario, publico, local}) {
    showModalBottomSheet(
      isScrollControlled: true,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 1),
      context: context,
      builder: (context) => SingleChildScrollView(
        padding: MediaQuery.of(context).viewInsets,
        child: ModalUpdateForm(
          id: id,
          descricao: descricao,
          titulo: titulo,
          data: data,
          horario: horario,
          local: local,
          publico: publico,
        ),
      ),
    );
  }

  void _delete(id) {
    final docEvento = DB.db.collection('evento').doc(id);

    docEvento.delete();
  }
}
