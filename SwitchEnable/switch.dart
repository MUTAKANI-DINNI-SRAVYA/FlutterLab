
import 'package:flutter/material.dart';

void main() {
runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage>createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Switch Enable/Disable"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
Switch(
              value: isEnabled,
              onChanged: (value) {
setState(() {
                  isEnabled = value;
                });
              },
            ),
SizedBox(height: 20),
ElevatedButton(
              onPressed: isEnabled
                  ? () {
print("Button Pressed");
                    }
                  : null,
              child: Text("Click Me"),
            ),
          ],
        ),
      ),
    );
  }
}



 
