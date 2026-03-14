import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  bool hidePassword = true;

  Color pink = const Color.fromARGB(255, 255, 171, 197);

  Future register() async {

    final user = username.text.trim();
    final mail = email.text.trim();
    final pass = password.text.trim();

    if(user.isEmpty || mail.isEmpty || pass.isEmpty){
      showMsg("All field is required.");
      return;
    }

    try{

      final existingUser = await supabase
          .from('users')
          .select()
          .eq('username', user)
          .maybeSingle();

      if(existingUser != null){
        showMsg("Username is already taken.");
        return;
      }

    if(!mail.endsWith("@gmail.com")){
      showMsg("Please enter a valid email address.");
      return;
    }

    if(pass.length < 6){
      showMsg("Password must be at least 6 characters.");
      return;
    }

      await supabase.from('users').insert({
        'username': user,
        'email': mail,
        'password': pass
      });

      showMsg("Registration successful.");

      Future.delayed(const Duration(milliseconds: 800), (){
        Get.back();
      });

    }catch(e){
      showMsg(e.toString());
    }
  }

  void showMsg(String msg){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff3b2b2b),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget input(String hint, TextEditingController controller,
      {bool obscure = false}) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFFFC0D6),
              width: 1.5,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFFFA0C0),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget passwordInput(){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: password,
        obscureText: hidePassword,
        decoration: InputDecoration(
          hintText: "Password",
          filled: true,
          fillColor: Colors.white,

          suffixIcon: IconButton(
            icon: Icon(
              hidePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: (){
              setState(() {
                hidePassword = !hidePassword;
              });
            },
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFFFC0D6),
              width: 1.5,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFFFA0C0),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.favorite,
              size: 80,
              color: pink,
            ),

            const SizedBox(height: 20),

            const Text(
              "Create an account",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xff3b2b2b),
              ),
            ),

            const SizedBox(height: 40),

            input("Username", username),

            input("Email", email),

            passwordInput(),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: pink,
                padding: const EdgeInsets.symmetric(
                    horizontal: 70, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 6,
              ),
              onPressed: register,
              child: const Text(
                "Register",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Text("Already have an account?"),

                const SizedBox(width: 6),

                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Color.fromARGB(255, 254, 108, 157),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}