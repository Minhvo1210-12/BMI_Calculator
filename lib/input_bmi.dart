import 'package:flutter/material.dart';
import 'result_bmi.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3E5F5),
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: Color(0xFFBA68C8),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: BMIPage(),
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  ReusableCard({
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 140,
        height: 120,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFCE93D8) : Color(0xFFD1C4E9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 4)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class HeightFrame extends StatelessWidget {
  final String text, label;
  final double? currentValue;
  final ValueChanged<double> onChanged;
  HeightFrame({
    required this.text,
    this.currentValue,
    this.label = '',
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFD1C4E9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          Text(
            '${currentValue!.round()} cm',
            style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Slider(
            value: currentValue!,
            min: 50,
            max: 200,
            activeColor: Color(0xFFBA68C8),
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}

class AgeWeightFrame extends StatelessWidget {
  final String text, increase, decrease;
  final int number;
  final VoidCallback onPressed1, onPressed2;
  AgeWeightFrame({
    required this.text,
    this.number = 0,
    this.increase = "+",
    this.decrease = "-",
    required this.onPressed1,
    required this.onPressed2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFD1C4E9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
          Text('$number', style: TextStyle(fontSize: 22, color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _circleBtn(onPressed1, decrease),
              SizedBox(width: 10),
              _circleBtn(onPressed2, increase),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleBtn(VoidCallback onPressed, String symbol) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        backgroundColor: Color(0xFFBA68C8),
        foregroundColor: Colors.white,
        padding: EdgeInsets.all(12),
      ),
      child: Text(symbol, style: TextStyle(fontSize: 20)),
    );
  }
}

class ResultButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  ResultButton({required this.text, required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class BMIPage extends StatefulWidget {
  const BMIPage({super.key});
  @override
  BMIPageState createState() => BMIPageState();
}

class BMIPageState extends State<BMIPage> {
  bool isMale = true;
  double currentValue = 150;
  int weight = 50;
  int age = 20;

  void setMale() => setState(() => isMale = true);
  void setFemale() => setState(() => isMale = false);
  void countWeight(int i) => setState(() => weight += i == 0 ? -1 : 1);
  void countAge(int i) => setState(() => age += i == 0 ? -1 : 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ReusableCard(text: "Male", icon: Icons.male, isSelected: isMale, onTap: setMale),
          ReusableCard(text: "Female", icon: Icons.female, isSelected: !isMale, onTap: setFemale),
        ]),
        SizedBox(height: 20),
        HeightFrame(
          text: "HEIGHT",
          currentValue: currentValue,
          onChanged: (value) => setState(() => currentValue = value),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AgeWeightFrame(text: 'WEIGHT', number: weight, onPressed1: () => countWeight(0), onPressed2: () => countWeight(1)),
            AgeWeightFrame(text: 'AGE', number: age, onPressed1: () => countAge(0), onPressed2: () => countAge(1)),
          ],
        ),
        SizedBox(height: 30),
        ResultButton(
          text: "CALCULATE BMI",
          color: Color(0xFFBA68C8),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CaculatorPage(
                  isMale: isMale,
                  weight: weight,
                  height: currentValue,
                  age: age,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
