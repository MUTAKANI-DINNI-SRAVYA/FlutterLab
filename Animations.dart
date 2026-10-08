
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
      title: 'Animation Demo',

      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),

      home: const AnimationPage(),
    );
  }
}

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void replay() {
    controller.reset();
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background
      backgroundColor: const Color(0xFFEAF7FA),

      // App Bar
      appBar: AppBar(
        title: const Text(
          'Flutter Animation Demo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        backgroundColor: const Color(0xFF006064),
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // FADE ANIMATION
              FadeTransition(
                opacity: controller,
                child: const Text(
                  'Fade Animation',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006064),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // SLIDE ANIMATION
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(controller),

                child: Container(
                  width: 250,
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: const Color(0xFF0097A7),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: const Text(
                    'Slide Animation',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // SCALE ANIMATION
              ScaleTransition(
                scale: Tween<double>(
                  begin: 0.3,
                  end: 1.0,
                ).animate(controller),

                child: Container(
                  width: 250,
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: const Color(0xFF00ACC1),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: const Text(
                    'Scale Animation',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ROTATION ANIMATION
              RotationTransition(
                turns: controller,

                child: const Icon(
                  Icons.settings,
                  size: 80,
                  color: Color(0xFF00838F),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Rotation Animation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00838F),
                ),
              ),

              const SizedBox(height: 35),

              // REPLAY BUTTON
              ElevatedButton.icon(
                onPressed: replay,

                icon: const Icon(Icons.refresh),

                label: const Text(
                  'Replay Animations',
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006064),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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
