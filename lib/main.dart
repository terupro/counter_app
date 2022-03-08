import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  // ①MyAppでProviderを利用できるようにする
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

// ②カウンター表示用にStateProviderを作成
final counterProvider = StateProvider((ref) => 0);

// ③ConsumerWidgetを継承する
class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod Counter')),
      body: Center(
        child: Consumer(builder: (context, ref, _) {
          final count = ref.watch(counterProvider); // ④状態の監視と取得
          return Text('$count',
              style: TextStyle(fontSize: 150, color: Colors.lightBlueAccent));
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ⑤状態の更新
          ref.read(counterProvider.state).update((state) => state + 1); // 1加算する
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
