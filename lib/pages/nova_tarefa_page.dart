import 'package:flutter/material.dart';

import '../models/tarefa.dart';

class NovaTarefaPage extends StatefulWidget {
  const NovaTarefaPage({super.key});

  @override
  State<NovaTarefaPage> createState() => _NovaTarefaPageState();
}

class _NovaTarefaPageState extends State<NovaTarefaPage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _salvar() {
    final formularioValido = _formKey.currentState?.validate() ?? false;
    if (!formularioValido) {
      return;
    }

    Navigator.of(context).pop(
      Tarefa(
        titulo: _tituloController.text.trim(),
        descricao: _descricaoController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova tarefa')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  key: const Key('campo-titulo'),
                  controller: _tituloController,
                  validator: (valor) =>
                      (valor == null || valor.trim().isEmpty)
                      ? 'Informe o título da tarefa.'
                      : null,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    hintText: 'Ex.: Estudar para a prova',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: const Key('campo-descricao'),
                  controller: _descricaoController,
                  validator: (valor) =>
                      (valor == null || valor.trim().isEmpty)
                      ? 'Informe a descrição da tarefa.'
                      : null,
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    hintText: 'Ex.: Revisar o capítulo 3',
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  key: const Key('botao-salvar'),
                  onPressed: _salvar,
                  icon: const Icon(Icons.check),
                  label: const Text('Salvar tarefa'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
