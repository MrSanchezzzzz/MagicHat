import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magic_hat/Utils/provider.dart';
import 'package:magic_hat/Wigets/bordered_container.dart';

class CountersFragment extends ConsumerStatefulWidget {
  const CountersFragment({super.key, this.child});

  final Widget? child;

  @override
  ConsumerState<CountersFragment> createState() => _CountersFragmentState();
}

class _CountersFragmentState extends ConsumerState<CountersFragment> {
  @override
  Widget build(BuildContext context) {
    final double countersWidth = MediaQuery.of(context).size.width * 0.25;
    final total=ref.watch(totalCounterProvider).value;
    final success=ref.watch(successCounterProvider).value;
    final failed=ref.watch(failedCounterProvider).value;
    return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BorderedContainer(
                width: countersWidth,
                child: Column(
                  children: [
                    Text(total.toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                    const Text("Total"),
                  ]
                ),
              ),
              BorderedContainer(
                width: countersWidth,
                child: Column(
                    children: [
                      Text(success.toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                      const Text("Success"),
                    ]
                ),
              ),
              BorderedContainer(
                width: countersWidth,
                child: Column(
                    children: [
                      Text(failed.toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                      const Text("Failed"),
                    ]
                ),
              ),
      ])
    );
  }
}
