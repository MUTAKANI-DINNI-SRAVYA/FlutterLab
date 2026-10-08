import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
runApp(const SmartWaterTrackerApp());
}

class SmartWaterTrackerApp extends StatelessWidget {
  const SmartWaterTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Water Intake Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const WaterTrackerHome(),
    );
  }
}

class WaterTrackerHome extends StatefulWidget {
  const WaterTrackerHome({super.key});

  @override
  State<WaterTrackerHome>createState() => _WaterTrackerHomeState();
}

class _WaterTrackerHomeState extends State<WaterTrackerHome> {
  static const int dailyGoal = 2000;

  int totalConsumed = 0;
  int entryCount = 0;

  final TextEditingController waterController = TextEditingController();

  @override
  void initState() {
super.initState();
loadData();
  }

  // Load saved data
  Future<void>loadData() async {
    final prefs = await SharedPreferences.getInstance();

setState(() {
      totalConsumed = prefs.getInt('totalConsumed') ?? 0;
      entryCount = prefs.getInt('entryCount') ?? 0;
    });
  }

  // Save data locally
  Future<void>saveData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('totalConsumed', totalConsumed);
    await prefs.setInt('entryCount', entryCount);
  }

  // Add water intake
  void addWater() {
    final input = waterController.text.trim();
    final amount = int.tryParse(input);

    // Validation
    if (amount == null || amount <= 0) {
showMessage(
        'Please enter a valid water amount greater than 0 mL.',
        Colors.red,
      );
      return;
    }

setState(() {
      totalConsumed += amount;
      entryCount++;
    });

saveData();
    waterController.clear();

showMessage(
      '$amount mL added successfully!',
      Colors.green,
    );
  }

  // Reset water intake
  Future<void>resetWater() async {
    final shouldReset = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset Water Intake'),
          content: const Text(
            'Are you sure you want to reset today\'s water intake?',
          ),
          actions: [
TextButton(
              onPressed: () {
Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
ElevatedButton(
              onPressed: () {
Navigator.pop(context, true);
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );

    if (shouldReset == true) {
setState(() {
        totalConsumed = 0;
        entryCount = 0;
      });

      await saveData();

showMessage(
        'Today\'s water intake has been reset.',
        Colors.blue,
      );
    }
  }

  void showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  void dispose() {
    waterController.dispose();
super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Remaining water
    final int remaining =
        (dailyGoal - totalConsumed).clamp(0, dailyGoal);

    // Completion percentage
    final double percentage =
        ((totalConsumed / dailyGoal) * 100).clamp(0, 100);

    // Progress value for ProgressIndicator
    final double progress =
        (totalConsumed / dailyGoal).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Smart Water Tracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // Water icon
            const Icon(
              Icons.water_drop,
              size: 80,
              color: Colors.blue,
            ),

            const SizedBox(height: 10),

            const Text(
              'Daily Hydration Goal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

Text(
              '$dailyGoal mL',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 25),

            // Progress indicator
LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              borderRadius: BorderRadius.circular(10),
            ),

            const SizedBox(height: 10),

Text(
              '${percentage.toStringAsFixed(0)}% completed',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            // Statistics cards
Row(
              children: [
Expanded(
                  child: buildInfoCard(
                    'Consumed',
                    '$totalConsumed mL',
                    Icons.local_drink,
                    Colors.blue,
                  ),
                ),

                const SizedBox(width: 12),

Expanded(
                  child: buildInfoCard(
                    'Remaining',
                    '$remaining mL',
                    Icons.hourglass_bottom,
                    Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

Row(
              children: [
Expanded(
                  child: buildInfoCard(
                    'Entries',
                    '$entryCount',
                    Icons.format_list_numbered,
                    Colors.green,
                  ),
                ),

                const SizedBox(width: 12),

Expanded(
                  child: buildInfoCard(
                    'Completion',
                    '${percentage.toStringAsFixed(0)}%',
                    Icons.percent,
                    Colors.purple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Input field
TextField(
              controller: waterController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter water amount',
                hintText: 'Example: 500',
                suffixText: 'mL',
                prefixIcon: const Icon(Icons.water_drop),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Add button
SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: addWater,
                icon: const Icon(Icons.add),
                label: const Text(
                  'Add Water',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Reset button
SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: resetWater,
                icon: const Icon(Icons.refresh),
                label: const Text(
                  'Reset Today',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Goal completion message
            if (totalConsumed >= dailyGoal)
Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green.withValues(alpha: 0.15),
                ),
                child: const Row(
                  children: [
Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
SizedBox(width: 10),
Expanded(
                      child: Text(
                        'Congratulations! You reached your daily hydration goal!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Reusable information card
  Widget buildInfoCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
Icon(
              icon,
              color: color,
              size: 30,
            ),

            const SizedBox(height: 8),

Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
