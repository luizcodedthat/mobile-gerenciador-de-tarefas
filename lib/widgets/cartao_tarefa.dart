import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../models/tarefa.dart';

class CartaoTarefa extends StatelessWidget {
  const CartaoTarefa({
    super.key,
    required this.tarefa,
    required this.onAlternarStatus,
    required this.onExcluir,
  });

  final Tarefa tarefa;
  final VoidCallback onAlternarStatus;
  final VoidCallback onExcluir;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final concluida = tarefa.concluida;
    final corStatus = concluida ? corConcluida : corPendente;
    final corTexto = concluida
        ? theme.colorScheme.onSurfaceVariant
        : theme.colorScheme.onSurface;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 0,
      color: concluida
          ? theme.colorScheme.surfaceContainerLow
          : theme.colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: corStatus.withValues(alpha: 0.35)),
      ),
      child: InkWell(
        onTap: onAlternarStatus,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(value: concluida, onChanged: (_) => onAlternarStatus()),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tarefa.titulo,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: corTexto,
                          fontWeight: FontWeight.w600,
                          decoration: concluida
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationThickness: 2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tarefa.descricao,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: corTexto,
                          decoration: concluida
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Icon(
                        concluida ? Icons.check_circle : Icons.pending_outlined,
                        size: 18,
                        color: corStatus,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: onExcluir,
                tooltip: 'Excluir tarefa',
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
