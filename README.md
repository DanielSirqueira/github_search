<!--
# github_search
github_search performs the [Clean Dart](https://github.com/Flutterando/Clean-Dart) architecture with Modular and Bloc.


Esse é uma documentação sobre o **Estado Atômico** em substituição do **Triple** no projeto da Elevagro.
-->
# Problema
Durante o desenvolvimento do APP da Alevagro, identificamos um grande problema: temos apenas um endpoint para os conteúdos do aplicativo, que traz todos os conteúdos de uma vez. Porém, precisamos exibir esses conteúdos em telas separadas, tornando o processo de busca e tratamento muito lento.

Nossa equipe conversou em uma Dayle e vimos que não faria muito sentido buscar os conteúdos em telas separadas. Diante disso, tivemos duas **tentativas de soluções**: uma delas foi usar o **Estado atômico**, enquanto a outra foi usar uma **Store global do Triple**.


# Solução
Essa documentação vai descrever como utilizamos o estado atômico e o estado global usando o RxNotifier para resolver o problema do endpoint no desenvolvimento do aplicativo da Alevagro.

Primeiramente, exploramos a solução do Estado Atômico, que permite o gerenciamento de estado de maneira mais granular e eficiente. Com o uso dessa técnica, conseguimos buscar os dados apenas uma vez, armazenando-os em variáveis de estado atômico, e disponibilizá-los para as telas que necessitam de forma rápida e precisa. Essa abordagem foi especialmente útil para evitar a lentidão causada pelo acesso frequente ao endpoint.

Em seguida, exploramos o uso do estado global com o RxNotifier, que permite a criação de um estado compartilhado e acessível de qualquer lugar do aplicativo. Com isso, foi possível criar uma Store global com os dados necessários para as diferentes telas, permitindo um acesso mais fácil e organizado aos conteúdos.

Com a implementação dessas soluções, conseguimos melhorar significativamente o desempenho e a eficiência do aplicativo, tornando a experiência do usuário mais fluida e agradável.

# Estado Atômico
O estado atômico consiste em deixar a distribuição do estado mais fácil e separar a regra de negócio em um único lugar específico, como um reducer. Nesse modelo, a tela não precisa saber da regra de negócio, mas apenas do estado. Isso torna a distribuição do estado mais fácil de gerenciar e evita problemas de inconsistência no código. Além disso, torna a manutenção do código mais fácil, já que a lógica de negócio está centralizada em um único lugar.

### Camadas
O Estado Atômico consiste em trés camadas, sendo elas: Atoms, Reducers e view.

![image](https://user-images.githubusercontent.com/39882255/223015764-368b3b66-c997-4da1-875c-6c7455e7045b.png)

- Atoms: Os Atoms são a primeira camada do Estado Atômico e representam os estados de uma tela.
- Reducers: É a camada que fica responsável pela manipulação da regra de negócio e do estado. É onde ocorrem as mudanças de estado e as operações de negócio são realizadas. Esta camada é responsável por receber ações e aplicá-las no estado, realizando as validações necessárias antes de atualizar o estado.
- View: São as páginas ou componentes do Flutter que consomem os Atoms, exibindo as informações e permitindo a interação do usuário com o aplicativo. Elas não conhecem diretamente as regras de negócio, mas apenas o estado gerenciado pelos Reducers.

Abaixo está representada uma ilustração que exemplifica o funcionamento do estado atômico entre a View e o Atom. Na imagem, é possível visualizar como a tela reconhece os atoms e estes, por sua vez, atualizam o estado na tela.

![image](https://user-images.githubusercontent.com/39882255/223017633-e48cd6f6-f25e-4bad-8169-47bfe818f62a.png)

A imagem abaixo ilustra o funcionamento do Reducer e do Atom no modelo de estado atômico. Nela, é possível observar que o Reducer reconhece o Atom e modifica os estados dos atoms por meio de eventos ou mudanças de estado do próprio Atom. Vale ressaltar que a camada do Reducer não é obrigatória no modelo de estado atômico, sendo utilizada somente quando o estado possui um evento específico. Em tópicos posteriores, esclareceremos melhor o papel do Reducer no modelo de estado atômico.

![image](https://user-images.githubusercontent.com/39882255/223019020-c589a758-844d-4e76-8e5a-123050ed4d71.png)

Para uma melhor compreensão do fluxo completo do estado atômico, a imagem abaixo apresenta a ilustração do processo e as cores das setas indicam a direção do fluxo. É possível notar que a View atualiza os Atoms, que por sua vez atualizam o estado na View. Além disso, o Reducer também pode atualizar os Atoms e notificar a View quando um evento específico ocorrer.

![image](https://user-images.githubusercontent.com/39882255/223020348-560d4c2c-11c0-4184-8395-3a4a9048de89.png)

# RxNotifier

Para o teste do modelo do estado atômico, usaremos o pacote RxNotifier, desenvolvido pela Flutterando, que simplifica a implementação do estado atômico.

### RxNotifier - Atoms
Para especificar o estado reativo usando o pacote RxNotifier, pode-se utilizar as classes `RxNotifier` e `RxAction`. O Atom representa o estado reativo.

- `RxNotifier`: A classe RxNotifier do pacote RxNotifier representa o estado reativo da tela e é capaz de receber um tipo, que informará o tipo do estado. No exemplo abaixo, podemos ver a utilização da classe RxNotifier com o tipo `String` e o valor inicial `initial value`.
```dart
final atomState = RxNotifier<String>('initial value');
```

- `RxAction`: A classe RxAction do pacote RxNotifier apresenta um evento que pode ser escutado na camada da **View** e do **Reducer**. Abaixo está uma declaração de RxAction:
```dart
final atomAction = RxAction();
```
### RxNotifier - Reducer
Para demonstrar como realizar a camada do Reducer no estado atômico com o pacote RxNotifier, pode-se utilizar a classe RxReducer. Além disso, o código abaixo mostra um exemplo de como utilizar o RxReducer em conjunto com o RxNotifier e a RxAction:

```dart
final atomState = RxNotifier<String>('initial value');
final atomAction = RxAction();

class AtomicReducer extends RxReducer {
  AtomicReducer() {
    on(() => [atomAction], _atomEvent);
  }

  void _atomEvent() {
    atomState.value = 'new state';
  }
}
```
Este código representa um exemplo de uso do padrão de estado atômico com o pacote RxNotifier. Ele define uma classe `AtomicReducer` que estende a classe `RxReducer`. A classe `AtomicReducer` é responsável por manipular o estado do átomo e as ações que podem ser executadas nele.

O código também define duas variáveis, `atomState` e `atomAction`. A variável `atomState` é uma instância da classe `RxNotifier` que representa o estado do **atom** e recebe o valor inicial de "initial value". Já a variável `atomAction` é uma instância da classe `RxAction` que representa um evento que pode ser disparado para atualizar o estado do **atom**.

Dentro da classe `AtomicReducer`, no construtor, é definido que quando houver uma ação na lista de dependências do `RxAction`, a função `_atomEvent` será executada. A função `_atomEvent` atualiza o valor do `atomState` para "new state".

Assim, quando a ação é disparada, o estado do atom é atualizado e essa atualização pode ser refletida na interface do usuário. Esse exemplo mostra como o padrão de estado atômico pode ser implementado com o pacote RxNotifier e como ele pode ser utilizado para simplificar a gestão de estado em aplicativos Flutter.

# Aplicação do estado atômico no aplicativo da Elevagro

1. Foi instalado o pacote de RxNotifier no pacote de dependências do APP para facilitar no controle da versão do RxNotifier.
2. Foi adicionado o `RxRoot` na raiz do aplicativo.
```dart
  RxRoot(
        child: ModularApp(
          module: AppModule(),
          child: const AppWidget(),
        ),
      ),
```

Para resolver o problema de gerenciamento de conteúdo, seria necessário criar uma Store atômica que pudesse ser acessada em todo o aplicativo. Nisso criamos um módulo que seria referente aos conteúdos.

![image](https://user-images.githubusercontent.com/39882255/223036689-ce4b347e-9e89-4ef2-8b92-549d9dcbe5d7.png)


### Store de conteúdo atômico
No exemplo abaixo, é apresentado como criar uma Store atômica dos conteúdos utilizando o pacote RxNotifier.
```dart
import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

class ContentStore {
  final contentListState = RxNotifier<List<ContentEntity>>([]);
  final isLoadingState = RxNotifier<bool>(true);
  final errorState = RxNotifier<Failure?>(null);

  final fetchContentAction = RxAction();
}
```
Dentro da classe, há quatro membros definidos:

1. `contentListState`: um objeto `RxNotifier` que mantém o estado da lista de conteúdos. Ele é inicializado com uma lista vazia de `ContentEntity`.
2. `isLoadingState`: um objeto `RxNotifier` que mantém o estado de carregamento. Ele é inicializado como `true`.
3. `errorState`: um objeto `RxNotifier` que mantém o estado de erro. Ele é inicializado como `null`.
4. `fetchContentAction`: um objeto `RxAction` que representa uma ação de busca de conteúdo. Ele não recebe nenhum parâmetro.

A seguir, temos um exemplo de como a Store era implementada no Triple.
```dart
import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../../../auth/presentation/stores/auth_store.dart';
import '../../../domain/usecase/fetch_content_usecase.dart';

class ContentStore extends StreamStore<Failure, List<ContentEntity>> {
  final IFetchContentUsecase fetchContentUsecase;
  final AuthStore authStore;
  ContentStore(this.fetchContentUsecase, this.authStore) : super([]);

  Future<void> fetchContent(String userId) async {
    setLoading(true);

    final result = await fetchContentUsecase(userId);

    result.fold(
      setError,
      (content) {
        update(
          content,
        );
        setLoading(false);
      },
    );
  }
}
```
O primeiro código utiliza o estado atômico através do pacote RxNotifier, que facilita o gerenciamento do estado do aplicativo, sem a necessidade de implementar a regra de negócio. Já o segundo código, utiliza a arquitetura Triple para gerenciamento de estado e inclui a implementação da regra de negócio para a recuperação dos conteúdos através do use case `IFetchContentUsecase`.

### Como implementar a regra de negócio no estado atómico?
Aqui está um exemplo de como implementar a regra de negócio usando a camada Reducer no estado atômico.
```dart
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../domain/usecase/fetch_content_usecase.dart';
import '../store/content_store.dart';

class ContentReducer extends RxReducer {
  final ContentStore _contentStore;
  final IFetchContentUsecase _fetchContentUsecase;
  final UserDTO _userDTO;

  ContentReducer(
    this._contentStore,
    this._fetchContentUsecase,
    this._userDTO,
  ) {
    on(() => [_contentStore.fetchContentAction], _fetchContent);
  }

  void _fetchContent() async {
    _contentStore.isLoadingState.value = true;

    final result = await _fetchContentUsecase(_userDTO.user.id);

    result.fold(
      (error) {
        _contentStore.errorState.value = error;
      },
      (content) {
        _contentStore.contentListState.value = content;
        _contentStore.errorState.value = null;
        _contentStore.isLoadingState.value = false;
      },
    );
  }
}
```
Este código implementa a lógica de negócio para uma Store atômica utilizando o pacote RxReducer. Ele cria uma classe `ContentReducer` que recebe o `ContentStore`, o `IFetchContentUsecase` e o `UserDTO` como parâmetros. No construtor da classe, ele configura o método `_fetchContent` para ser executado quando a ação `fetchContentAction` da `ContentStore` for chamada.

O método `_fetchContent` primeiro define que a aplicação está carregando ao definir o valor de `isLoadingState` para `true`. Em seguida, ele chama o método `fetchContentUsecase` para buscar o conteúdo do usuário fornecido pelo `UserDTO` e atualiza a Store com o resultado. Se houver um erro, a Store é atualizada com o erro na `errorState`. Se não houver erros, a Store é atualizada com o conteúdo na `contentListState` e `isLoadingState` é definido como `false`.

### Usando o modular
A seguir, é apresentado um exemplo de como foi implementado o módulo de conteúdo em nosso sistema.

```dart
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import 'domain/usecase/fetch_content_usecase.dart';
import 'external/datasources/content_datasource.dart';
import 'infra/repositories/content_repository.dart';
import 'reducer/content_reducer.dart';
import 'store/content_store.dart';

class ContentModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => ContentDatasource(i<DioClientServiceImpl>()), export: true),
        Bind.lazySingleton((i) => ContentRepository(i()), export: true),
        Bind.lazySingleton((i) => FetchContentUsecase(i()), export: true),
        Bind.lazySingleton((i) => ContentStore(), export: true),
        Bind.singleton((i) => ContentReducer(i(), i(), i()), export: true),
      ];
}
```
A classe `ContentModule` é uma classe que utiliza o pacote Modular para fazer a injeção de dependências e gerenciamento de estado de uma funcionalidade específica de um aplicativo. Essa classe tem como objetivo definir os Binds (ou ligações) que serão utilizados na aplicação para que o Modular possa gerenciar as dependências dessa funcionalidade.

Na lista de `Binds`, temos a definição de quatro instâncias singleton e uma instância lazy singleton, que serão utilizadas em diferentes partes do módulo:

- `ContentDatasource`: instância da classe que faz a comunicação com a fonte de dados externa da funcionalidade, que é representada pelo serviço `DioClientServiceImpl`.
- `ContentRepository`: instância da classe que implementa a interface `IContentRepository` e é responsável por tratar os dados do `ContentDatasource`.
- `FetchContentUsecase`: instância da classe que implementa a interface IFetchContentUsecase e representa um caso de uso da funcionalidade, que é buscar o conteúdo da fonte de dados.
- `ContentStore`: instância da classe que representa o estado da funcionalidade e armazena as informações do conteúdo buscado.
- `ContentReducer`: instância da classe que implementa o `RxReducer` e é responsável por gerenciar as ações que podem ser disparadas no ContentStore e atualizar seu estado de acordo com as regras de negócio definidas.

Ao exportar esses binds, é possível utilizar essas instâncias em outras partes do aplicativo, inclusive em outras funcionalidades que tenham dependências dessas classes. O Modular se encarrega de gerenciar as instâncias e garantir que cada uma seja criada apenas uma vez durante o ciclo de vida da aplicação.

O `ContentReducer` é uma classe que deve ser criada apenas uma vez (singleton) e não precisa ser implementada em nenhum outro lugar.

O `ContentModule` é adicionado como uma dependência do `AppModule`, permitindo que seja acessado por todo o aplicativo.

```dart
class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        DownloadModule(),
        AuthModule(),
        ContentModule(),
      ];
}
```

### Usando o Store atômica na tela
A `Page` ou `Widget` depende dos Atoms (Store) e pode ser obtida pela injeção de dependencia do modular.  A seguir, é apresentado um exemplo:

```dart
class _ContentListWidgetState extends State<ContentListWidget> {
  late final ContentStore store;

  @override
  void initState() {
    super.initState();
    store = context.read();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (store.contentListState.value.isEmpty) {
        store.fetchContentAction();
      }
    });
  }
}
```
Esse é um exemplo de um StatefulWidget no Flutter. A classe `_ContentListWidgetState` representa o estado interno do widget `ContentListWidget`.

Na declaração da classe, uma instância da classe `ContentStore` é criada com o modificador `late` para indicar que ela será inicializada posteriormente, dentro do método `initState()`.

No método `initState()`, a implementação padrão do método é chamada com `super.initState()`. Em seguida, o contexto do widget é usado para obter a instância do `ContentStore`, através do método `read()` disponível a partir do pacote Modular.

Por fim, um callback é adicionado com `WidgetsBinding.instance.addPostFrameCallback()`, para ser chamado após a construção completa do widget. Esse callback verifica se a lista de conteúdo do `ContentStore` está vazia, e em caso positivo, chama o método `fetchContentAction()` do store para buscar o conteúdo.

Para escutar quando o estado da store for atualizado, é possível utilizar `context.select(() => [store.atomState.value])` ou `RxBuilder`. Abaixo, vou descrever como utilizamos na tela da lista de conteúdo.

```dart
@override
Widget build(BuildContext context) {
    context.select(() => [store.contentListState.value, store.isLoadingState.value, store.errorState.value]);
}    
```

O código acima está dentro do método `build` de um widget. Ele utiliza o método `context.select` para escutar o estado atual de três **atom** da `store`: `contentListState`, `isLoadingState` e `errorState`.

O método `context.select` é usado para selecionar uma ou mais partes do estado que o widget depende e notificar quando essas partes do estado mudam. Quando as partes selecionadas do estado mudam, o widget é reconstruído automaticamente.

Segue abaixo um exemplo de como utilizar o `store.isLoadingState.value` para verificar todas as vezes que o estado de loading foi modificado:

```dart
class _ContentListWidgetState extends State<ContentListWidget> {
  late final ContentStore store;

  @override
  void initState() {
    super.initState();
    store = context.read();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (store.contentListState.value.isEmpty) {
        store.fetchContentAction();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    context.select(() => [store.contentListState.value, store.isLoadingState.value, store.errorState.value]);
    final mediaQuery = MediaQuery.of(context).size;

    if (store.isLoadingState.value) {
      return const CircularProgressIndicator();
    }
   
    return const Container();
  }
}    
```

Utilizando o ContentStore como uma forma atômica de gerenciar o estado, conseguimos separar a lógica de negócio e melhorar a distribuição da classe dentro do aplicativo. Como resultado, o conteúdo pode ser consumido em todas as telas do app. Um vídeo do aplicativo em funcionamento com o estado atômico pode ser conferido abaixo.

[Veja neste vídeo a demonstração do aplicativo com o uso do estado atômico](https://user-images.githubusercontent.com/39882255/223064925-25f448e8-2077-4bb2-b4db-f655c2669d70.webm)

# Vantagens da utilização de estados atômicos
1. Separação clara de responsabilidades: O uso do estado atômico permite separar claramente as responsabilidades entre a lógica de negócios e a gerência de estado, tornando o código mais organizado e fácil de entender.

2. Maior reutilização de código: Com o estado atômico, o mesmo estado pode ser utilizado em diferentes telas e widgets, o que aumenta a reutilização do código.

3. Melhor desempenho: O estado atômico utiliza a programação reativa e a atualização de estado apenas quando necessário, o que ajuda a melhorar o desempenho do aplicativo.

4. Menos erros de programação: Ao usar o estado atômico, há menos riscos de erros de programação, já que as atualizações de estado são gerenciadas de forma segura e consistente.

# Desvantagens da utilização de estados atômicos
1. Complexidade: a implementação de estados atômicos pode ser mais complexa do que a simples utilização de estados locais em cada tela, exigindo um conhecimento mais avançado em gerenciamento de estado no Flutter.

2. Padronização: a adoção de estados atômicos em um projeto pode exigir uma padronização rigorosa na equipe para evitar conflitos e garantir a consistência do estado em todas as telas.

3. Curva de aprendizado: a utilização de estados atômicos pode requerer uma curva de aprendizado maior para a equipe, especialmente se não houver experiência prévia em gerenciamento de estado atômico.

4. Manutenção: a manutenção de estados atômicos pode ser mais complexa do que a manutenção de estados locais, exigindo uma atenção especial para evitar bugs e garantir a consistência do estado em todas as telas.
