import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'register_page.dart';
import 'home_page.dart';

final supabase = Supabase.instance.client;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final username = TextEditingController();
  final password = TextEditingController();

  bool hidePassword = true;

  Color pink = const Color.fromARGB(255, 255, 171, 197);

  Future login() async {

    final user = username.text.trim();
    final pass = password.text.trim();

    if(user.isEmpty || pass.isEmpty){
      showMsg("Username and Password is required.");
      return;
    }

    try{

      final data = await supabase
          .from('users')
          .select()
          .eq('username', user)
          .eq('password', pass)
          .maybeSingle();

      if(data == null){

        showMsg("Username or password is incorrect.");

      }else{
        
        int loggedInUserId = data['id_users'];

        showMsg("Welcome back! You have successfully logged in.");

        Future.delayed(const Duration(milliseconds: 500), (){
          Get.offAll(() => HomePage(activeUserId: loggedInUserId));
        });

      }

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
        style: const TextStyle(color: Color(0xff3b2b2b)), 
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white, 
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFFC0D6), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFFA0C0), width: 2),
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
              "Welcome Back",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xff3b2b2b),
              ),
            ),

            const SizedBox(height: 40),

            input("Username", username),
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
              onPressed: login,
              child: const Text(
                "Login",
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

                const Text("Don't have an account?"),

                const SizedBox(width: 6),

                GestureDetector(
                  onTap: (){
                    Get.to(() => const RegisterPage());
                  },
                  child: const Text(
                    "Register",
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