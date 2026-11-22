# FastLocation

Aplicativo mobile desenvolvido em Flutter para a disciplina de **Desenvolvimento de Sistemas Móveis (SENAI)**.

O projeto resolve uma demanda da empresa fictícia **FastDelivery**: agilizar o trabalho dos entregadores na confirmação de endereços diretamente pelo celular, evitando atrasos nas entregas e ligações constantes para a matriz.

## Funcionalidades

- **Tela de abertura animada** com redirecionamento automático para a tela principal.
- **Consulta de endereço por CEP** consumindo a API pública do [ViaCEP](https://viacep.com.br/).
- **Busca de CEP por endereço completo ou parcial** (UF, cidade e logradouro).
- **Armazenamento local com Hive** para manter o histórico de consultas e reaproveitar buscas recorrentes sem precisar refazer requisições repetidas.
- **Gerenciamento de estado reativo** com MobX (`Observer` e `reaction` para tratamento de erros).
- **Histórico de consultas** em tela dedicada com carregamento automático.
- **Traçado de rota** da localização atual do aparelho até o último endereço consultado (ou qualquer item do histórico), usando `geocoding` + `map_launcher`.

## Tecnologias e Pacotes Utilizados

- **Flutter / Dart** (suporte exclusivo para Android e iOS)
- **Dio** (`^4.0.6`) — requisições HTTP à API ViaCEP
- **MobX** (`^2.0.6+1`) & **Flutter MobX** (`^2.0.4`) — gerenciamento de estado
- **Hive** (`^2.1.0`) & **Hive Flutter** (`^1.1.0`) — banco de dados local NoSQL
- **Path** (`^1.8.0`) & **Path Provider** (`^2.0.2`) — gerenciamento do diretório local de armazenamento
- **Geocoding** (`^2.1.1`) — conversão do endereço em latitude e longitude
- **Map Launcher** (`^2.2.1+1`) — abertura do aplicativo de mapas instalado para traçar a rota
- **Build Runner**, **MobX Codegen** e **Hive Generator** — geração de código (`.g.dart`)

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

- [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado e configurado no PATH
- Android Studio / Xcode ou dispositivo físico conectado (Android ou iOS)

### Passo a passo

1. Clone o repositório:
```bash
git clone https://github.com/SEU-USUARIO/fast_location.git
cd fast_location
```

2. Instale as dependências do projeto:
```bash
flutter pub get
```

3. *(Opcional)* Os arquivos gerados (`.g.dart`) já estão versionados no projeto. Caso altere algum model do Hive ou controller do MobX, regenere com:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Execute o aplicativo no emulador ou dispositivo conectado:
```bash
flutter run
```

> **Obs. sobre rotas em emuladores:** para testar o botão de traçar rota, certifique-se de que o emulador ou aparelho possua o Google Maps, Waze ou Apple Maps instalado e com acesso à internet.
