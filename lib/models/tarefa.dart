enum StatusTarefa { pendente, concluida }

extension StatusTarefaRotulo on StatusTarefa {
  String get rotulo => switch (this) {
    StatusTarefa.pendente => 'Pendente',
    StatusTarefa.concluida => 'Concluída',
  };
}

class Tarefa {
  const Tarefa({
    required this.titulo,
    required this.descricao,
    this.status = StatusTarefa.pendente,
  });

  final String titulo;
  final String descricao;
  final StatusTarefa status;

  bool get concluida => status == StatusTarefa.concluida;

  Tarefa copyWith({StatusTarefa? status}) {
    return Tarefa(
      titulo: titulo,
      descricao: descricao,
      status: status ?? this.status,
    );
  }
}
