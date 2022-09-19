import 'dart:math';

import 'package:crud/modals/lista.dart';
import 'package:crud/screens/consultar_page.dart';
import 'package:crud/screens/modal_form.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Lista> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CRUD'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => _openForm(context),
              child: const Text('Adicionar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ConsultarPage(
                      lista: list,
                    ),
                  ),
                );
              },
              child: const Text('Consultar'),
            ),
          ],
        ),
      ),
    );
  }

  _openForm(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 1),
      context: context,
      builder: (context) => SingleChildScrollView(
        padding: MediaQuery.of(context).viewInsets,
        child: ModalForm(
          onSubmit: _addList,
        ),
      ),
    );
  }

  _addList(String titulo, String descricao, String data, String horario,
      String local, String publico) {
    setState(() {
      final newList = Lista(
        id: Random().nextDouble().toString(),
        titulo: titulo,
        descricao: descricao,
        data: data,
        horario: horario,
        local: local,
        publico: publico,
      );
      list.add(newList);
    });
    Navigator.of(context).pop();
  }
}
