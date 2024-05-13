import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_health_app/src/feature/screens/widgets/my_health_app_drawer.dart';

class AgeScreen extends  StatefulWidget
{
  @override
  _ageScreenState createState()=> _ageScreenState();
}

class _ageScreenState extends State<AgeScreen> 
{
  DateTime? _selectedDate;
  int? _age;

  void _presentDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(), 
      firstDate: DateTime(1900), 
      lastDate: DateTime.now(),
    ).then ((pickedDate){
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
        _age = _calculateAge(pickedDate);
      });
    });
  }

  int _calculateAge(DateTime birthDate)
  {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month || 
      (currentDate.month == birthDate.month)) {
        age--;
      }
      return age;
  }

  @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      drawer: MyHealthAppDrawer(),
      appBar: AppBar(
        title: Text('Age Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _presentDatePicker,
              child: Text(_selectedDate == null
              ? 'Select your birthdate'
              : 'Change birthdate(${_selectedDate?.toIso8601String().substring(0, 10)})'),
               style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal:30, vertical: 15)),
            ),
            SizedBox(height:20),
            if(_age != null)
              Text('You are $_age years old.' , style: TextStyle (fontSize: 18)),
          ],
        ),
      ),
    );
  }

}