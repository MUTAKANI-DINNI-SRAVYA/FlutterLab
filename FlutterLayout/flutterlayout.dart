import 'package:flutter/material.dart';

void main() {
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Layout Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Layout'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Row with three evenly spaced icons
Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
Icon(Icons.home, size: 40, color: Colors.blue),
Icon(Icons.favorite, size: 40, color: Colors.red),
Icon(Icons.settings, size: 40, color: Colors.green),
                ],
              ),

              const SizedBox(height: 30),

              // Outer container
Container(
                width: 320,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                // Inner container placed inside outer container
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      'Inner Container',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 
