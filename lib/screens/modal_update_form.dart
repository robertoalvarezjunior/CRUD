import 'package:crud/data/db.dart';
import 'package:flutter/material.dart';

class ModalUpdateForm extends StatefulWidget {
  const ModalUpdateForm(
      {super.key,
      required this.id,
      required this.titulo,
      required this.descricao,
      required this.data,
      required this.horario,
      required this.local,
      required this.publico});

  final String id;
  final String titulo;
  final String descricao;
  final String data;
  final String horario;
  final String local;
  final String publico;

  @override
  State<ModalUpdateForm> createState() => _ModalUpdateFormState();
}

class _ModalUpdateFormState extends State<ModalUpdateForm> {
  @override
  void initState() {
    tituloInput = TextEditingController(text: widget.titulo);
    descricaoInput = TextEditingController(text: widget.descricao);
    dataInput = TextEditingController(text: widget.data);
    horarioInput = TextEditingController(text: widget.horario);
    localInput = TextEditingController(text: widget.local);
    publicoInput = TextEditingController(text: widget.publico);
    super.initState();
  }

  late final dynamic tituloInput;
  late final dynamic descricaoInput;
  late final dynamic dataInput;
  late final dynamic horarioInput;
  late final dynamic localInput;
  late final dynamic publicoInput;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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

                  final docEvento = DB.db.collection('evento').doc(widget.id);
                  docEvento.update({
                    'titulo': titulo,
                    'descrição': descricao,
                    'data': data,
                    'horario': horario,
                    'local': local,
                    'publico': publico,
                  });

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
      textCapitalization: TextCapitalization.sentences,
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
}
