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
  int increment();
}

class IncrementCounter {
  final CounterRepository repository;
  IncrementCounter(this.repository);

  int call() => repository.increment();
}

// ==================== Data ====================

class CounterRepositoryImpl implements CounterRepository {
  int _count = 0;

  @override
  int increment() => ++_count;
}

// ==================== Presentation ====================

class CounterViewModel extends ChangeNotifier {
  IncrementCounter? _incrementCounter;
  int _count = 0;

  CounterViewModel(this._incrementCounter);

  int get count => _count;

  void updateUseCase(IncrementCounter useCase) {
    _incrementCounter = useCase;
  }

  void increment() {
    if (_incrementCounter != null) {
      _count = _incrementCounter!();
      notifyListeners();
    }
  }
}

// ==================== UI ====================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Clean Arch with Provider")),
        body: Consumer<CounterViewModel>(
          builder: (_, vm, __) => Center(
            child: Text("Count: ${vm.count}", style: TextStyle(fontSize: 32)),
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
