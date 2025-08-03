import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<CounterRepository>(
          create: (_) => CounterRepositoryImpl(),
        ),
        ProxyProvider<CounterRepository, IncrementCounter>(
          update: (_, repo, __) => IncrementCounter(repo),
        ),
        ChangeNotifierProxyProvider<IncrementCounter, CounterViewModel>(
          create: (_) => CounterViewModel(null),
          update: (_, useCase, vm) => vm!..updateUseCase(useCase),
        ),
      ],
      child: MyApp(),
    ),
  );
}

// ==================== Domain ====================

abstract class CounterRepository {
  Future<int> increment();
}

class IncrementCounter {
  final CounterRepository repository;
  IncrementCounter(this.repository);

  Future<int> call() => repository.increment();
}

// ==================== Data ====================

class CounterRepositoryImpl implements CounterRepository {
  int _count = 0;

  @override
  Future<int> increment() async {
    await Future.delayed(Duration(milliseconds: 400)); // simulate delay
    return ++_count;
  }
}

// ==================== Presentation ====================

class CounterViewModel extends ChangeNotifier {
  IncrementCounter? _incrementCounter;
  int _count = 0;
  bool _isLoading = false;

  CounterViewModel(this._incrementCounter);

  int get count => _count;
  bool get isLoading => _isLoading;

  void updateUseCase(IncrementCounter useCase) {
    _incrementCounter = useCase;
  }

  Future<void> increment() async {
    if (_incrementCounter == null) return;

    _isLoading = true;
    notifyListeners();

    _count = await _incrementCounter!();

    _isLoading = false;
    notifyListeners();
  }
}

// ==================== UI ====================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Clean Arch + Provider + Async")),
        body: Consumer<CounterViewModel>(
          builder: (_, vm, __) => Center(
            child: vm.isLoading
                ? CircularProgressIndicator()
                : Text("Count: ${vm.count}", style: TextStyle(fontSize: 32)),
          ),
        ),
        floatingActionButton: Consumer<CounterViewModel>(
          builder: (_, vm, __) => FloatingActionButton(
            onPressed: vm.increment,
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
