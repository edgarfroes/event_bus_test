import 'package:event_bus_test/current_account_balance_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'events.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Injection.
    Get.put(
      EventsManager(),
      permanent: true,
    );

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double _balance = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Current Balance'),
            const Gap(20),
            const CurrentAccountBalanceWidget(),
            const CurrentAccountBalanceWidget(),
            const CurrentAccountBalanceWidget(),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Get.to(() => const Page1());
                  },
                  child: const Text('Page 1'),
                ),
                const Gap(10),
                OutlinedButton(
                  onPressed: () {
                    Get.to(() => const Page2());
                  },
                  child: const Text('Page 2'),
                ),
                const Gap(10),
                OutlinedButton(
                  onPressed: () {
                    Get.to(() => const Page3());
                  },
                  child: const Text('Page 3'),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _balance += 10;

          // Get.find<CurrentBalanceEvent>().update(_balance);

          final event = Get.find<CurrentAccountBalanceEvent>();

          event.update((event.observable.value ?? 0) + 10);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
      ),
      body: const _PageBody(),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
      ),
      body: const _PageBody(),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 3'),
      ),
      body: const _PageBody(),
    );
  }
}

class _PageBody extends StatelessWidget {
  const _PageBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CurrentAccountBalanceWidget(),
          const Gap(20),
          OutlinedButton(
            onPressed: () {
              final event = Get.find<CurrentAccountBalanceEvent>();

              event.update((event.observable.value ?? 0) + 10);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
