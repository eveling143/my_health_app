# 🏥 MyVaccine Web Application

##  **📝 Descripción**

Esta aplicación móvil desarrollada con Flutter permite a los usuarios calcular su edad, su Índice de Masa Corporal (IMC) y determinar su signo zodiacal de manera rápida y sencilla.

 ###  **Características**

**Calculadora de Edad:** Permite al usuario ingresar su fecha de nacimiento y calcula automáticamente su edad actual.

**Calculadora de IMC:** Permite al usuario ingresar su peso y altura para calcular su Índice de Masa Corporal y proporciona una clasificación del estado de su peso (bajo peso, normal, sobrepeso, obesidad).

**Determinador de Signo Zodiacal:** El usuario puede ingresar su fecha de nacimiento para conocer su signo zodiacal según el día y mes de nacimiento.



# 📦 Cómo Desplegar
###  **Prerrequisitos**

 **<img src="https://github.com/Stephanie4712205/My_Health_App/assets/161189108/5f3ed1eb-148b-4d33-845f-f54ed4413aa7" alt="Texto alternativo" width="30"/> 
Vysor** (se debe instalar en pc y en el teléfono)


# **🔧 Configuración de la Aplicación**

Vamos a crear un proyecto vacio de flutter en VS Code (Ctrl + Shift + p)

# 🚀 Despliegue

### Main.dart
Este código crea una aplicación Flutter básica con una estructura de enrutamiento personalizado (MaterialApp.router), donde MainApp sirve como el widget principal y define cómo se construye la interfaz de usuario de la aplicación. La función main inicia la aplicación y el enrutador personalizado se encarga de gestionar la navegación entre las diferentes pantallas de la app.

``` void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      routerConfig: MyHealthAppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
} 
```


**Screens**

Se refiere a una página o vista en la interfaz de usuario de nuestra aplicación una pantalla puede estar representada por una clase que extiende  StatelessWidget o StatefulWidget (Puede cambiar estado), dependiendo de si la pantalla tiene o no estado interno que pueda cambiar durante su ciclo de vida.

Para nuestro código vamos a necesitar 4 screens que se realizarán en dart:

*  ***Age Screen:*** Esta pantalla AgeScreen permite al usuario calcular su edad seleccionando su fecha de nacimiento a través de un selector de fecha. La pantalla muestra la edad calculada y proporciona un botón para cambiar la fecha de nacimiento si se desea.

```
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
```

*  ***BMI Screen:*** la pantalla BmiScreen permite al usuario calcular su índice de masa corporal (BMI) ingresando su peso y altura, y muestra el resultado del cálculo junto con la categoría correspondiente. El código también incluye validaciones para manejar posibles errores al ingresar datos inválidos.

``` import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_health_app/src/feature/screens/widgets/my_health_app_drawer.dart';

class BmiScreen extends StatefulWidget {
  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double? _bmi;
  String? _category;

  void _calculateBMI() {
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final double height = double.tryParse(_heightController.text) ?? 0;
    if (weight > 0 && height > 0) {
      final double heightInMeters = height / 100;
      setState(() {
        _bmi = weight / (heightInMeters * heightInMeters);
        _category = _determineCategory(_bmi!);
      });
    }
  }

  String _determineCategory(double bmi) {
    if (bmi < 18.5)
      return "Underweight";
    else if (bmi < 25)
      return "Normal";
    else if (bmi < 30)
      return "Overweight";
    else
      return "Obese";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyHealthAppDrawer(),
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  border: OutlineInputBorder(),
                  hintText: 'Enter your weight in kg'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  border: OutlineInputBorder(),
                  hintText: 'Enter your height in cm'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: Text('Calculate BMI'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal:30, vertical: 15),
              ),
            ),
            SizedBox(height: 20),
            if (_bmi != null)
              Text('Your BMI: ${_bmi!.toStringAsFixed(2)} ($_category)',
                  style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
```

*  ***Home Screen:***  la pantalla HomeScreen muestra un AppBar con un título de bienvenida y un menú lateral. El cuerpo de la pantalla contiene varios botones que permiten al usuario navegar a diferentes partes de la aplicación al presionarlos. Cada botón utiliza el contexto para navegar a rutas específicas utilizando el enrutador GoRouter.

```
class HomeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      drawer: MyHealthAppDrawer(),
      appBar: AppBar(
        title: Text('Welcome to my App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            ElevatedButton(
              onPressed: () => context.push('/age'), 
              child: Text('Calculate Age'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal:30, vertical: 15),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.push('/bmi'), 
              child: Text('Calculate BMI'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal:30, vertical: 15),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.push('/zodiac'), 
              child: Text('Determine Zodiac Sign'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal:30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

*  ***Zodiac Screen:*** la pantalla permite al usuario calcular su signo zodiacal seleccionando su fecha de nacimiento. La pantalla muestra un campo para ingresar el nombre, un botón para seleccionar la fecha de nacimiento y muestra el signo zodiacal calculado junto con un saludo al usuario en función de su nombre y signo zodiacal.

  ```
class ZodiacScreen extends StatefulWidget {
  @override
  _ZodiacScreenState createState() => _ZodiacScreenState();
}

class _ZodiacScreenState extends State<ZodiacScreen> {
  final TextEditingController _nameController = TextEditingController();
  DateTime? _selectedDate;
  String? _zodiacSing;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
        _zodiacSing = _determineZodiacSing(pickedDate);
      });
    });
  }

  String _determineZodiacSing(DateTime date) {
    int day = date.day;
    int month = date.month;

    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
      return "Aries";
    } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
      return "Taurus";
    } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
      return "Gemini";
    } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
      return "Cancer";
    } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
      return "Leo";
    } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
      return "Virgo";
    } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
      return "Libra";
    } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
      return "Scorpio";
    } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
      return "Sagittarius";
    } else if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) {
      return "Capricorn";
    } else if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
      return "Aquarius";
    } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
      return "Pisces";
    }
    return "Unknown";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyHealthAppDrawer(),
      appBar: AppBar(title: Text('Zodiac sing Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _presentDatePicker,
              child: Text(_selectedDate == null
                  ? 'Pick your birthdate'
                  : 'Change birthdate'),
             style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal:30, vertical: 15),
              ),     
            ),
            SizedBox(height: 20),
            if (_zodiacSing != null)
              Text(
                  'Hello, ${_nameController.text}! Your Zodiac Sing is $_zodiacSing.',
                  style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
```

Ahora configuraremos el **Widget**


``` class MyHealthAppDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('My Healt App'),
            decoration: BoxDecoration(
              color: Colors.yellow,
            ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                context.go('/');
              },
            ),
            ListTile(
              title: Text('BMI Calculator'),
              onTap: () {
                Navigator.pop(context);
                context.go('/bmi');
              },
            ),
             ListTile(
              title: Text('Age Calculator'),
              onTap: () {
                Navigator.pop(context);
                context.go('/age');
              },
            ),
             ListTile(
              title: Text('Zodiac Calculator'),
              onTap: () {
                Navigator.pop(context);
                context.go('/zodiac');
              },
            ),
        ],
      ),
    );
  }
} 
```


Por último las **rutas**  que usaremos 

```
class MyHealthAppRouter{
  static GoRouter router = GoRouter(routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/bmi', builder: (context, state) => BmiScreen()),
    GoRoute(path: '/age', builder: (context, state) => AgeScreen()),
    GoRoute(path: '/zodiac', builder: (context, state) => ZodiacScreen()),

  ]);
}
```


+ Es importante revisar que tu App este funcionando correctamente en tu emulador y en chorme
  
