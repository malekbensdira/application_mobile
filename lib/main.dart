import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isEmailValid(String email) {
    // Validation basique de l'email : doit contenir '@' et se terminer par '.com'
    return email.contains('@') && email.endsWith('.com');
  }

  bool _isPasswordValid(String password) {
    // Validation du mot de passe : au moins une majuscule et un chiffre
    return password.contains(RegExp(r'[A-Z]')) && password.contains(RegExp(r'[0-9]'));
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      // Si la validation réussit, naviguer vers la page suivante
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page d\'authentification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty || !_isEmailValid(value)) {
                    return 'Veuillez entrer un email valide (exemple@domain.com)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                validator: (value) {
                  if (value == null || value.isEmpty || !_isPasswordValid(value)) {
                    return 'Le mot de passe doit contenir une majuscule et un chiffre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu principal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            _MenuItem(imagePath: 'assets/icons/transaction.jpg', label: 'Suivre ma transaction'),
            _MenuItem(imagePath: 'assets/icons/property.jpg', label: 'Trouver un bien'),
            _MenuItem(imagePath: 'assets/icons/contact.jpg', label: 'Contact'),
            _MenuItem(imagePath: 'assets/icons/convention.jpg', label: 'Nouvelle convention'),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String imagePath;
  final String label;

  const _MenuItem({required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Action sur le clic du menu, ici on peut gérer la navigation ou d'autres actions
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Vous avez cliqué sur: $label')),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 50, height: 50),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
