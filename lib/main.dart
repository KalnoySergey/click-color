import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RandomColorScreen(),
    );
  }
}

class RandomColorScreen extends StatefulWidget {
  const RandomColorScreen({super.key});

  @override
  _RandomColorScreenState createState() => _RandomColorScreenState();
}

class _RandomColorScreenState extends State<RandomColorScreen> {
  static const int maxColorValue = 256;
  static const int fullOpacity = 255;
  Color color = Colors.white;
  Timer? _timer;

  void _generateRandomColor() {
    final random = Random();
    setState(() {
      color = Color.fromARGB(
        fullOpacity,
        random.nextInt(maxColorValue),
        random.nextInt(maxColorValue),
        random.nextInt(maxColorValue),
      );
    });
  }

  void _startChangingColor() {
    _timer = Timer.periodic(const Duration(milliseconds: 700), (_) {
      _generateRandomColor();
    });
  }

  void _stopChangingColor() {
    if (_timer == null) return;
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _generateRandomColor,
      onLongPressStart: (_) {
        _startChangingColor();
      },
      onLongPressEnd: (_) {
        _stopChangingColor();
      },
      onLongPressCancel: _stopChangingColor,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        color: color,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Text(
              'HELLO THERE',
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
