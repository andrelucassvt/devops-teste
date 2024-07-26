import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:devops_teste/amplifyconfiguration.dart';
import 'package:devops_teste/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  runApp(const MyApp());
}

Future<void> _configureAmplify() async {
  try {
    final api = AmplifyAPI(
      options: APIPluginOptions(
        modelProvider: ModelProvider.instance,
      ),
    );

    final auth = AmplifyAuthCognito();

    await Amplify.addPlugins([api, auth]);
    await Amplify.configure(amplifyconfig);

    safePrint('Successfully configured');
  } on Exception catch (e) {
    safePrint('Error configuring Amplify: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/manage-budget-entry',
        name: 'manage',
        builder: (context, state) => ManageBudgetEntryScreen(
          pessoaEntity: state.extra as PessoaEntity?,
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        builder: Authenticator.builder(),
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PessoaEntity> _pessoaEntity = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshBudgetEntries() async {
    // To be filled in
    try {
      final request = ModelQueries.list(
        PessoaEntity.classType,
        authorizationMode: APIAuthorizationType.userPools,
      );
      final response = await Amplify.API.query(request: request).response;

      final todos = response.data?.items;
      if (response.hasErrors) {
        safePrint('errors: ${response.errors}');
        return;
      }
      setState(() {
        _pessoaEntity = todos!.whereType<PessoaEntity>().toList();
      });
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
    }
  }

  Future<void> _deleteBudgetEntry(PessoaEntity budgetEntry) async {
    // To be filled in
  }

  Future<void> _navigateToBudgetEntry({PessoaEntity? budgetEntry}) async {
    // To be filled in
    await context.pushNamed('manage', extra: budgetEntry);
    await _refreshBudgetEntries();
  }

  Widget _buildRow({
    required String title,
    required String description,
    TextStyle? style,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
        Expanded(
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // Navigate to the page to create new budget entries
        onPressed: _navigateToBudgetEntry,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Lista de pessoas'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: RefreshIndicator(
            onRefresh: _refreshBudgetEntries,
            child: Column(
              children: [
                if (_pessoaEntity.isEmpty)
                  const Text('Adicione mais pessoas no botão +'),
                const SizedBox(height: 30),
                _buildRow(
                  title: 'Nome',
                  description: 'Idade',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: _pessoaEntity.length,
                    itemBuilder: (context, index) {
                      final pessoaEntity = _pessoaEntity[index];
                      return Dismissible(
                        key: ValueKey(pessoaEntity),
                        background: const ColoredBox(
                          color: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                        ),
                        onDismissed: (_) => _deleteBudgetEntry(pessoaEntity),
                        child: ListTile(
                          onTap: () => _navigateToBudgetEntry(
                            budgetEntry: pessoaEntity,
                          ),
                          title: _buildRow(
                            title: pessoaEntity.nome,
                            description: pessoaEntity.idade ?? '',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ManageBudgetEntryScreen extends StatefulWidget {
  const ManageBudgetEntryScreen({
    required this.pessoaEntity,
    super.key,
  });

  final PessoaEntity? pessoaEntity;

  @override
  State<ManageBudgetEntryScreen> createState() =>
      _ManageBudgetEntryScreenState();
}

class _ManageBudgetEntryScreenState extends State<ManageBudgetEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();

  late final String _titleText;

  bool get _isCreate => _pessoaEntity == null;
  PessoaEntity? get _pessoaEntity => widget.pessoaEntity;

  @override
  void initState() {
    super.initState();

    final pessoaEntity = _pessoaEntity;
    if (pessoaEntity != null) {
      _nomeController.text = pessoaEntity.nome;
      _idadeController.text = pessoaEntity.idade ?? '';
      _titleText = 'Atualizar pessoa';
    } else {
      _titleText = 'Criar pessoa';
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // If the form is valid, submit the data
    final title = _nomeController.text;
    final description = _idadeController.text;

    if (_isCreate) {
      // Create a new budget entry
      final newEntry = PessoaEntity(
        nome: title,
        idade: description.isNotEmpty ? description : null,
      );
      final request = ModelMutations.create(
        newEntry,
        authorizationMode: APIAuthorizationType.userPools,
      );
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Create result: $response');
    } else {
      // Update budgetEntry instead
      final updateBudgetEntry = _pessoaEntity!.copyWith(
        nome: title,
        idade: description.isNotEmpty ? description : null,
      );
      final request = ModelMutations.update(
        updateBudgetEntry,
        authorizationMode: APIAuthorizationType.userPools,
      );
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Update result: $response');
    }

    // Navigate back to homepage after create/update executes
    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleText),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nome não pode ser vazio';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _idadeController,
                      decoration: const InputDecoration(
                        labelText: 'Idade',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: submitForm,
                      child: Text(_titleText),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
