import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerador de Senha Dupla',
      theme: ThemeData(
        
        primaryColor: Colors.grey
      ),
      home: const PasswordGeneratorScreen(),
    );
  }
}

class PasswordGeneratorScreen extends StatefulWidget {
  const PasswordGeneratorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordGeneratorScreenState createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  Color corNumerica = Colors.grey;
  String password = '';
  String passwordType = 'Numérica'; 
  final TextEditingController lengthController = TextEditingController();


  String generateNumericPassword(int length) {
    final rand = Random();
    return List.generate(length, (_) => rand.nextInt(10).toString()).join('');
  }


  String generateTextualPassword(int length) {
    
    final rand = Random();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join('');
  }

  bool validateLength(String input) {
    final length = int.tryParse(input);
    if (length == null || length < 3) {
      return false;
    }
    return true;
  }

  void generatePassword() {
    final length = int.tryParse(lengthController.text);
    if (length != null && length >= 3) {
      setState(() {
        if (passwordType == 'Numérica') {
          password = generateNumericPassword(length);
        } else {
          password = generateTextualPassword(length);
        }
      });
    } else {
      setState(() {
        password = 'Erro: O comprimento deve ser maior ou igual a 3.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de Senha Dupla'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Escolha o tipo de senha:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                
                ElevatedButton(
                  onPressed: () => setState(() => passwordType = 'Numérica'),
                  child: const Text('Numérica'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => passwordType = 'Textual'),
                  child: const Text('Textual'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              'Quantos caracteres?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: lengthController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número de caracteres',
                errorText: !validateLength(lengthController.text) && lengthController.text.isNotEmpty
                    ? 'Insira um número válido (mínimo 3)'
                    : null,
              ),
            ),
            const SizedBox(height: 20),


            ElevatedButton(
              onPressed: generatePassword,
              child: const Text('Gerar Senha'),
            ),
            const SizedBox(height: 20),


            const Text(
              'Senha gerada:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              password,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
