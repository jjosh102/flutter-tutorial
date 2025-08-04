import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    await Future.delayed(const Duration(milliseconds: 400));
    return ++_count;
  }
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
  bool _isLoading = false;

  CounterViewModel(this._incrementCounter);

  int get count => _count;
  bool get isLoading => _isLoading;

  Future<void> increment() async {
    _isLoading = true;
    notifyListeners();

    _count = await _incrementCounter();

    _isLoading = false;
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
        appBar: AppBar(title: const Text("Riverpod + Clean Architecture")),
        body: const Center(child: CountDisplay()),
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
    return vm.isLoading
        ? const CircularProgressIndicator()
        : Text("Count: ${vm.count}", style: const TextStyle(fontSize: 32));
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
