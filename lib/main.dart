import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool status = true;

  Stream<String> _clock() async* {
    while (status) {
      await Future.delayed(const Duration(milliseconds: 1));
      DateTime now = DateTime.now();
      yield "${now.hour} : ${now.minute} : ${now.second} : ${now.millisecond}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timer"),
      ),
      body: Column(
        children: [
          Center(
            child: StreamBuilder<String>(
              stream: _clock(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!,
                    style: const TextStyle(fontSize: 48, color: Colors.blue),
                  );
                }

                return const Text("");
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                status = true;
              });
            },
            child: const Text("Play"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                status = false;
              });
            },
            child: const Text("Stop"),
          )
        ],
      ),
    );
  }
}
