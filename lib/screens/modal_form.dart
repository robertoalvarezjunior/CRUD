import 'package:crud/data/db.dart';
import 'package:crud/modals/evento.dart';
import 'package:flutter/material.dart';

class ModalForm extends StatefulWidget {
  const ModalForm({super.key});

  @override
  State<ModalForm> createState() => _ModalFormState();
}

class _ModalFormState extends State<ModalForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final tituloInput = TextEditingController();
  final descricaoInput = TextEditingController();
  final dataInput = TextEditingController();
  final horarioInput = TextEditingController();
  final localInput = TextEditingController();
  final publicoInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            txtFormField(tituloInput, 'Título', TextInputType.text),
            const SizedBox(
              height: 10,
            ),
            txtFormField(descricaoInput, 'Descrição', TextInputType.text),
            const SizedBox(
              height: 10,
            ),
            txtFormField(dataInput, 'Data do evento', TextInputType.datetime),
            const SizedBox(
              height: 10,
            ),
            txtFormField(horarioInput, 'Horário', TextInputType.datetime),
            const SizedBox(
              height: 10,
            ),
            txtFormField(localInput, 'Local', TextInputType.text),
            const SizedBox(
              height: 10,
            ),
            txtFormField(publicoInput, 'Público', TextInputType.text),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  final titulo = tituloInput.text;
                  final descricao = descricaoInput.text;
                  final data = dataInput.text;
                  final horario = horarioInput.text;
                  final local = localInput.text;
                  final publico = publicoInput.text;

                  creatEvent(
                    titulo: titulo,
                    data: data,
                    descricao: descricao,
                    horario: horario,
                    local: local,
                    publico: publico,
                  );
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField txtFormField(
      TextEditingController controller, String label, txtInputType) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.white,
      keyboardType: txtInputType,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );
  }

  Future creatEvent({
    required titulo,
    required descricao,
    required data,
    required horario,
    required local,
    required publico,
  }) async {
    final docEvent = DB.db.collection('evento').doc();

    final event = Evento(
        id: docEvent.id,
        titulo: titulo,
        descricao: descricao,
        data: data,
        horario: horario,
        local: local,
        publico: publico);

    final json = event.toJson();

    await docEvent.set(json);
  }
}
