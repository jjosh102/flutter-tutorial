import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

// ==================== Providers ====================

final counterRepositoryProvider = Provider<CounterRepository>((ref) {
  return CounterRepositoryImpl();
});

final incrementCounterProvider = Provider<IncrementCounter>((ref) {
  final repo = ref.read(counterRepositoryProvider);
  return IncrementCounter(repo);
});

final counterViewModelProvider =
    ChangeNotifierProvider<CounterViewModel>((ref) {
  final useCase = ref.read(incrementCounterProvider);
  return CounterViewModel(useCase);
});

// ==================== Presentation ====================

class CounterViewModel extends ChangeNotifier {
  final IncrementCounter _incrementCounter;
  int _count = 0;

  CounterViewModel(this._incrementCounter);

  int get count => _count;

  void increment() {
    _count = _incrementCounter();
    notifyListeners();
  }
}

// ==================== UI ====================

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Clean Arch with Riverpod")),
        body: const Center(
          child: CountDisplay(),
        ),
        floatingActionButton: const IncrementButton(),
      ),
    );
  }
}

class CountDisplay extends ConsumerWidget {
  const CountDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(counterViewModelProvider);
    return Text("Count: ${vm.count}", style: const TextStyle(fontSize: 32));
  }
}

class IncrementButton extends ConsumerWidget {
  const IncrementButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(counterViewModelProvider);
    return FloatingActionButton(
      onPressed: vm.increment,
      child: const Icon(Icons.add),
    );
  }
}
