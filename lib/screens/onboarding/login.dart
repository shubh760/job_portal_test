import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal/screens/onboarding/onboard_controller.dart';
import 'package:job_portal/utils/textfield_widget.dart';

class LoginScreen extends GetView<OnboardingController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/splash_logo.png",
                    height: 150,
                  ),
                  Positioned(
                    bottom: 50.0,
                    left: MediaQuery.of(context).size.width / 3.5,
                    child: Text(
                      "Job Cat",
                      style: GoogleFonts.pacifico(fontSize: 40),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Login",
                  style: GoogleFonts.roboto(fontSize: 30, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              buildTextField(
                controller: controller.emailController.value,
                keyboardType: TextInputType.emailAddress,
                label: 'Email Address',
                icon: Icons.email,
              ),
              SizedBox(height: 16),
              buildTextField(
                controller: controller.passwordController.value,
                label: 'Password',
                icon: Icons.password,
                obscureText: true,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: /* controller.login */ () {
                  controller.loginWithEmailPassword();
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text("Don't have any account? "),
                  InkWell(
                    onTap: () {
                      Get.toNamed("/SigninScreen");
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.deepPurpleAccent),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  SizedBox(
                    width: 10,
                  ),
                  Text("or"),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: /* controller.googleSignIn */ () {
                  controller.signInWithGoogle();
                },
                icon: Image.network(  
                  'https://imgs.search.brave.com/WFUCWSTA1WQZxQ6Bj0PpSiIS0qx9cb9e-ysxkOY4rTA/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9jZG4x/Lmljb25maW5kZXIu/Y29tL2RhdGEvaWNv/bnMvZ29vZ2xlLXMt/bG9nby8xNTAvR29v/Z2xlX0ljb25zLTA5/LTUxMi5wbmc',
                  height: 24,
                  width: 24,
                ),
                label: Text('Sign in with Google'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  /* primary: Colors.white,
                  onPrimary: Colors.black87, */
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
