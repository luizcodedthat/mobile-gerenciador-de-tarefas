# Gerenciador de Tarefas

Aplicativo mobile simples para gerenciamento de tarefas pendentes, desenvolvido em
Flutter/Dart como parte da disciplina de Desenvolvimento Mobile.

As tarefas são mantidas **apenas em memória**: não há persistência de dados, portanto
tudo o que foi cadastrado é descartado ao encerrar o aplicativo.

## Requisitos extras implementados

A atividade pede pelo menos um recurso extra. Foram implementados dois:

1. **Contador de tarefas** - no topo da lista são exibidos dois totais: a quantidade de
   tarefas pendentes e a quantidade de tarefas concluídas, sempre atualizados em tempo
   real conforme o usuário conclui, reabre ou exclui tarefas.
2. **Tema claro/escuro** - o aplicativo define um tema claro e um tema escuro
   (Material 3), alternados automaticamente conforme a configuração do dispositivo.

## Funcionalidades

### Cadastrar tarefa

- O botão flutuante `+` abre a página **Nova tarefa**.
- A página possui os campos **Título** e **Descrição** e o botão **Salvar tarefa**.
- Tarefa vazia não é permitida: ao salvar sem preenchimento, os campos são destacados e
  exibem as mensagens "Informe o título da tarefa." e "Informe a descrição da tarefa.",
  permanecendo na mesma página.
- Ao salvar com sucesso, a tarefa é adicionada ao topo da lista de imediato e um aviso
  confirma a operação.

### Listar tarefas

- Todas as tarefas cadastradas aparecem em uma lista rolável, da mais recente para a
  mais antiga.
- Cada item exibe o título, a descrição e a indicação de status.
- Quando não há tarefas, é exibida a mensagem "Nenhuma tarefa cadastrada" com a
  orientação de usar o botão `+`.
- A organização é adaptada a dispositivos móveis: cards com bordas arredondadas, áreas
  de toque confortáveis, uso de `SafeArea` para respeitar as bordas da tela e
  `ListView.builder` para renderizar apenas os itens visíveis.

### Concluir e reabrir tarefa

- O checkbox (ou um toque no card) alterna o status da tarefa entre **pendente** e
  **concluída**, atendendo também ao requisito de reabrir uma tarefa concluída.
- A diferença visual entre os estados é composta por quatro recursos: texto do título e
  da descrição riscados, alteração de cor do texto e do card, checkbox marcado e
  troca do ícone de status (`pending` para pendente, `check_circle` para concluída).
- Um aviso informa se a tarefa foi concluída ou reaberta.

### Excluir tarefa

- O ícone de lixeira no card remove a tarefa da lista.
- Após a exclusão a tarefa não aparece mais na lista e um aviso confirma a operação.

### Informar o usuário

- Ações não concluídas geram mensagem: erros de preenchimento são exibidos junto aos
  campos e as demais operações (adicionar, concluir, reabrir, excluir) exibem um aviso
  temporário (SnackBar).

## Requisitos obrigatórios x implementação

| Requisito da atividade                                    | Onde está                                     |
| --------------------------------------------------------- | --------------------------------------------- |
| Campo para informar a descrição                          | `lib/pages/nova_tarefa_page.dart`              |
| Botão para adicionar                                     | `lib/pages/nova_tarefa_page.dart`              |
| Nova tarefa aparece imediatamente na lista              | `lib/pages/tarefas_page.dart`                  |
| Não permitir cadastro de tarefa vazia                    | `lib/pages/nova_tarefa_page.dart`              |
| Mensagem orientando o preenchimento                      | `lib/pages/nova_tarefa_page.dart`              |
| Mostrar todas as tarefas e a descrição                   | `lib/pages/tarefas_page.dart`                  |
| Mostrar claramente pendente ou concluída                 | `lib/widgets/cartao_tarefa.dart`               |
| Apresentação organizada para mobile                      | `lib/widgets/cartao_tarefa.dart` e `SafeArea`  |
| Excluir tarefa                                           | `lib/widgets/cartao_tarefa.dart`               |
| Concluir tarefa com diferença visual                     | `lib/widgets/cartao_tarefa.dart`               |
| Retornar tarefa concluída para pendente                   | `lib/widgets/cartao_tarefa.dart`               |
| Informar quando uma ação não puder ser realizada        | `lib/pages/nova_tarefa_page.dart` e `lib/pages/tarefas_page.dart` |

## Estrutura do projeto

```
lib/
├── main.dart                     # Inicialização do app, temas claro/escuro e rota inicial
├── app_theme.dart                # Paleta de cores e criação do ThemeData
├── models/
│   └── tarefa.dart               # Modelo Tarefa (título, descrição e status)
├── pages/
│   ├── tarefas_page.dart         # Lista de tarefas, contador, concluir/reabrir e excluir
│   └── nova_tarefa_page.dart     # Formulário de cadastro com validação
└── widgets/
    └── cartao_tarefa.dart        # Card de cada tarefa com a diferença visual de status
```

Decisões de implementação:

- O modelo `Tarefa` é imutável e a alteração de status é feita com `copyWith`, evitando
  que o estado exibido na tela seja modificado sem passar por um novo `setState`.
- A criação de tarefa usa `Navigator.push` e devolve a tarefa pronta com
  `Navigator.pop`, mantendo o formulário e a lista independentes.
- A lista de tarefas vive no `State` de `TarefasPage`, o que atende à restrição de não
  usar persistência.

## Como executar

Pré-requisitos:

- Flutter SDK instalado (o projeto foi desenvolvido com Flutter 3.47 e Dart 3.13,
  exigindo Dart `^3.13.1`).
- Para Android: Android Studio (ou o Android SDK) com um dispositivo ou emulador
  disponível.
- Para iOS: macOS com Xcode e cocoapods.

Passo a passo:

```bash
# 1. Instalar as dependências do projeto
flutter pub get

# 2. Conferir os dispositivos disponíveis
flutter devices
flutter emulators

# 3. Executar o aplicativo (informe o id do dispositivo, se houver mais de um)
flutter run

# Gerar a versão de release para Android
flutter build apk --release

# Gerar a versão de release para iOS
flutter build ios
```

Também é possível executar diretamente pelo Android Studio ou Xcode, abrindo a pasta do
projeto e acionando o botão de execução.

## Tecnologias

- Flutter 3.47 / Dart 3.13
- Material 3 (Widgets nativos: `Scaffold`, `Form`, `TextFormField`, `Card`, `Checkbox`,
  `ListView.builder`, `SnackBar`)
- Sem pacotes de terceiros e sem persistência de dados
