import 'package:flutter/material.dart';
import 'sales.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, String> _userDatabase = {
    'usuario1@gmail.com': 'contraseña1',
    'usuario2@gmail.com': 'contraseña2',
    'usuario3@gmail.com': 'contraseña3',
    'xd': 'xdxd'
  };

  Widget _buildTextField(String hintText, TextEditingController controller,
      IconData icon, bool obscureText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon),
          contentPadding: EdgeInsets.symmetric(
              vertical: 15.0), // Ajusta el espacio vertical
          border: UnderlineInputBorder(
            borderSide: BorderSide(
                color:
                    Colors.grey), // Color de la línea cuando no está enfocado
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blue), // Color de la línea cuando está enfocado
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce un valor';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSignInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            String email = _emailController.text;
            String password = _passwordController.text;
            if (_userDatabase.containsKey(email) &&
                _userDatabase[email] == password) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SalesPage()),
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Error de inicio de sesión',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: const Text(
                      'Credenciales inválidas.',
                      style: TextStyle(fontSize: 16),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cerrar',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.black,
                    elevation: 4,
                  );
                },
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          primary: Color(0xFFD69C67),
        ),
        child: const Text(
          'ingresar',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3C79E),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Color(0xFFD69C67),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/xoxoxd.png',
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Bienvenido!',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      fontFamily: 'sans-serif',
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 3.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 75, 75, 75),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  _buildTextField(
                    'Email',
                    _emailController,
                    Icons.email,
                    false,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    'Contraseña',
                    _passwordController,
                    Icons.lock,
                    true,
                  ),
                  const SizedBox(height: 10),
                  _buildSignInButton(),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
