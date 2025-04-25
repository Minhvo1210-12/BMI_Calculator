import 'package:flutter/material.dart';
import './input_bmi.dart';
import 'dart:math';

class CaculatorPage extends StatefulWidget {
  final bool isMale;
  final int weight, age;
  final double height;

  const CaculatorPage({
    Key? key,
    required this.isMale,
    required this.height,
    required this.weight,
    required this.age,
  }) : super(key: key);

  @override
  CaculatorPageState createState() => CaculatorPageState();
}

class CaculatorPageState extends State<CaculatorPage> {
  late double weightD, result;
  String text = '', suggest = '';

  @override
  void initState() {
    super.initState();
    weightD = widget.weight.toDouble();
    result = double.parse((weightD / pow(widget.height / 100, 2)).toStringAsFixed(1));
    caculate();
  }

  void caculate() {
    if (result < 18.5) {
      text = 'Cân nặng thấp, cơ thể gầy';
      suggest = 'Bạn cần ăn uống đầy đủ, tập luyện thể dục thể thao';
    } else if (18.5 <= result && result <= 24.9) {
      text = 'Bình thường';
      suggest = 'Cơ thể tốt';
    } else if (result == 25) {
      text = 'Thừa cân';
      suggest = 'Bạn cần tập thể dục và ăn uống lành mạnh hơn';
    } else if (result <= 29.9) {
      text = 'Tiền béo phì';
      suggest = 'Cơ thể bạn đang trở nên béo phì, bạn cần giảm cân';
    } else if (result <= 34.9) {
      text = 'Béo phì cấp độ I';
      suggest = 'Tình trạng đáng báo động vì cơ thể trở nên quá nặng';
    } else if (result <= 39.9) {
      text = 'Béo phì cấp độ II';
      suggest = 'Rất dễ mắc nhiều bệnh liên quan đến béo phì';
    } else {
      text = 'Béo phì cấp độ III';
      suggest = 'Bạn cần có kế hoạch giảm cân để bảo vệ sức khỏe.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3E5F5),
      appBar: AppBar(
        title: Text("Your BMI Result"),
        backgroundColor: Color(0xFFBA68C8),
        centerTitle: true,
      ),
      body: Center(
        child: ResultBmi(
          text: text,
          result: result,
          suggest: suggest,
        ),
      ),
    );
  }
}

class ResultBmi extends StatelessWidget {
  final String text, suggest;
  final double result;

  const ResultBmi({
    required this.text,
    required this.result,
    required this.suggest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color(0xFFD1C4E9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 6)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            '$result',
            style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 20),
          Text(
            suggest,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(height: 30),
          ResultButton(
            text: "GO BACK HOME",
            color: Color(0xFFBA68C8),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
