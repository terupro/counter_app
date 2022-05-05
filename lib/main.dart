import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  // ①ProviderScopeで囲む
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

// ②カウンターの状態を管理をする
final counterProvider = StateProvider((ref) => 0);

// ③ConsumerWidgetを継承する
class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ④状態管理している値を取得する
    final _counterProvider = ref.watch(counterProvider);
    // ⑤状態管理している値を操作できるようにする
    final _counterNotifier = ref.watch(counterProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod Counter')),
      body: Center(
        child: Text(
          // ⑥状態を表示する
          '$_counterProvider',
          style: const TextStyle(fontSize: 150, color: Colors.lightBlueAccent),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ⑦状態を操作する
          _counterNotifier.state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
