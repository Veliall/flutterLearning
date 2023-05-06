import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  static const route = '/stopwatch';
  const StopWatch({Key? key}) : super(key: key);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  bool isTicking = false;
  int milliseconds = 0;
  late Timer timer;
  final laps = <int>[];
  final itemHeight = 60.0;
  final scrollController = ScrollController();

  void _onTick(Timer time) {
    setState(() {
      milliseconds += 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    String name = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch of $name'),
      ),
      body: Column(
        children: [
          Expanded(child: _buildCounter(context)),
          Expanded(child: _buildLapDisplay())
        ],
      ),
    );
  }

  Widget _buildCounter(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Lap ${laps.length + 1}',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
          Text(
            _secondsTex(milliseconds),
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildControls()
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: () => _startTimer(),
          child: const Text('Start'),
        ),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.yellow),
          ),
          onPressed: () => isTicking ? _lap() : null,
          child: const Text('Lap'),
        ),
        const SizedBox(
          width: 20,
        ),
        TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () => _stopTimer(),
            child: const Text('Stop'))
      ],
    );
  }

  void _startTimer() {
    if (isTicking) return;

    timer = Timer.periodic(const Duration(milliseconds: 100), _onTick);

    setState(() {
      milliseconds = 0;
      isTicking = true;
      laps.clear();
    });
  }

  void _stopTimer() {
    if (!isTicking) return;

    timer.cancel();

    setState(() {
      isTicking = false;
    });
  }

  void _lap() {
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });

    scrollController.animateTo(itemHeight * laps.length,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  String _secondsTex(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds seconds';
  }

  Widget _buildLapDisplay() {
    return Scrollbar(
      child: ListView.builder(
        controller: scrollController,
        itemExtent: itemHeight,
        itemCount: laps.length,
        itemBuilder: (context, index) {
          final milliseconds = laps[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50),
            title: Text('Lap ${index + 1}'),
            trailing: Text(_secondsTex(milliseconds)),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
