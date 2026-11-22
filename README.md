```markdown
# FastLocation

Aplicativo mobile desenvolvido em Flutter para a disciplina de Desenvolvimento de Sistemas Móveis (SENAI).

O projeto atende à demanda da empresa fictícia FastDelivery: permitir que os entregadores consultem e confirmem endereços diretamente pelo celular, agilizando as entregas e evitando ligações desnecessárias para a matriz.

## Funcionalidades

- Tela de abertura animada com redirecionamento automático para a tela principal.
- Consulta de endereço por CEP consumindo a API pública do [ViaCEP](https://viacep.com.br/).
- Busca de CEP por endereço completo ou parcial (UF, cidade e logradouro).
- Armazenamento local com Hive para manter o histórico de consultas e reaproveitar buscas recorrentes sem refazer requisições repetidas.
- Gerenciamento de estado reativo com MobX (`Observer` e `reaction` para tratamento de erros).
- Histórico de consultas em tela dedicada com carregamento automático ao abrir a página.
- Traçado de rota da localização atual do aparelho até o último endereço consultado (ou qualquer item salvo no histórico), utilizando `geocoding` e `map_launcher`.

## Tecnologias e Pacotes Utilizados

- Flutter / Dart (configurado exclusivamente para Android e iOS)
- Dio (`^4.0.6`) — requisições HTTP à API ViaCEP
- MobX (`^2.0.6+1`) & Flutter MobX (`^2.0.4`) — gerenciamento de estado
- Hive (`^2.1.0`) & Hive Flutter (`^1.1.0`) — armazenamento local
- Path (`^1.8.0`) & Path Provider (`^2.0.2`) — gerenciamento do diretório local de dados
- Geocoding (`^2.1.1`) — conversão do endereço em coordenadas (latitude e longitude)
- Map Launcher (`^2.2.1+1`) — abertura do aplicativo de mapas instalado no dispositivo para traçar a rota
- Build Runner, MobX Codegen e Hive Generator — geração de código (`.g.dart`)

## Estrutura do Projeto

```text
lib/
├── main.dart
└── src/
    ├── app.dart
    ├── http/
    │   └── dio_config.dart
    ├── routes/
    │   └── app_routes.dart
    ├── shared/
    │   ├── colors/
    │   ├── components/
    │   ├── metrics/
    │   └── storage/
    └── modules/
        ├── initial/
        │   └── page/
        ├── home/
        │   ├── components/
        │   ├── controller/
        │   ├── model/
        │   ├── page/
        │   ├── repositories/
        │   └── service/
        └── history/
            ├── controller/
            └── page/

```

## Como executar o projeto

### Pré-requisitos

 [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado e configurado no PATH (testado e validado com Flutter 3.7.12 / Dart 2.19)
 Emulador Android/iOS ou dispositivo físico conectado

### Passo a passo

1. Clone o repositório:

```bash
git clone [https://github.com/JoaozRoma/Desafio-2---Desenvolvimento-de-Sistemas-M-veis.git](https://github.com/JoaozRoma/Desafio-2---Desenvolvimento-de-Sistemas-M-veis.git)
cd Desafio-2---Desenvolvimento-de-Sistemas-M-veis

```

2. Instale as dependências do projeto:

```bash
flutter pub get

```

3. (Opcional) Os arquivos gerados (`.g.dart`) já estão versionados no repositório. Caso faça alterações em models do Hive ou controllers do MobX, regenere os arquivos com:

```bash
flutter pub run build_runner build --delete-conflicting-outputs

```

4. Execute o aplicativo no emulador ou dispositivo conectado:

```bash
flutter run

```
