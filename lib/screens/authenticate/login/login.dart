import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    Future signIn() async {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF003a68),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.05, vertical: Get.height * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage('assets/logo.png'),
                width: Get.width * 1,
                height: Get.height * 0.4,
                fit: BoxFit.contain,
              ),
              Form(
                  child: Container(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.greenAccent,
                      ),
                      controller: emailController,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_outline_outlined,
                            color: Colors.greenAccent,
                          ),
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.greenAccent),
                          hintText: "Email",
                          hintStyle: TextStyle(color: Color(0xFF749776)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF69F0AE)),
                          )),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.greenAccent),
                      controller: passwordController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.fingerprint,
                            color: Colors.greenAccent,
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.greenAccent),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Color(0xFF749776)),
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.remove_red_eye_sharp,
                              color: Colors.greenAccent,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forget Password?",
                          style: TextStyle(color: Colors.greenAccent),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    SizedBox(
                      width: Get.width * 0.8,
                      height: Get.height * 0.05,
                      child: ElevatedButton(
                        onPressed: () {
                          signIn();
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(87, 0, 30, 54))),
                        child: Text("Login",
                            style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.w400,
                                fontSize: Get.height * 0.03)),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
