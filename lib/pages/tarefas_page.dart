import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../models/tarefa.dart';
import '../widgets/cartao_tarefa.dart';
import 'nova_tarefa_page.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  final List<Tarefa> _tarefas = <Tarefa>[];

  Future<void> _abrirFormulario() async {
    final tarefa = await Navigator.of(context).push<Tarefa>(
      MaterialPageRoute(builder: (context) => const NovaTarefaPage()),
    );

    if (tarefa == null || !mounted) {
      return;
    }

    setState(() => _tarefas.insert(0, tarefa));
    _mostrarMensagem('Tarefa "${tarefa.titulo}" adicionada.');
  }

  void _alternarStatus(int indice) {
    final tarefa = _tarefas[indice];

    setState(() {
      _tarefas[indice] = tarefa.copyWith(
        status: tarefa.concluida
            ? StatusTarefa.pendente
            : StatusTarefa.concluida,
      );
    });

    _mostrarMensagem(
      tarefa.concluida
          ? 'Tarefa "${tarefa.titulo}" reaberta.'
          : 'Tarefa "${tarefa.titulo}" concluída.',
    );
  }

  void _excluirTarefa(int indice) {
    final tarefa = _tarefas[indice];
    setState(() => _tarefas.removeAt(indice));
    _mostrarMensagem('Tarefa "${tarefa.titulo}" excluída.');
  }

  void _mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensagem)));
  }

  int get _quantidadePendente =>
      _tarefas.where((tarefa) => !tarefa.concluida).length;

  int get _quantidadeConcluida => _tarefas.length - _quantidadePendente;

  String _rotular(int quantidade, String rotulo) {
    return quantidade == 1 ? '1 $rotulo' : '$quantidade ${rotulo}s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Tarefas')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      _rotular(_quantidadePendente, 'pendente'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: corPendente,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: Text(
                      _rotular(_quantidadeConcluida, 'concluída'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: corConcluida,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _tarefas.isEmpty
                  ? const _ListaVazia()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: _tarefas.length,
                      itemBuilder: (context, indice) {
                        final tarefa = _tarefas[indice];
                        return CartaoTarefa(
                          key: ValueKey(tarefa),
                          tarefa: tarefa,
                          onAlternarStatus: () => _alternarStatus(indice),
                          onExcluir: () => _excluirTarefa(indice),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirFormulario,
        tooltip: 'Nova tarefa',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ListaVazia extends StatelessWidget {
  const _ListaVazia();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 56,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 12),
            Text(
              'Nenhuma tarefa cadastrada',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              'Toque no botão + para adicionar a sua primeira tarefa.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
