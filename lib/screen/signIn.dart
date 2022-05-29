import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/textStyleData.dart';
import 'package:holland/screen/loginPage.dart';
import 'package:holland/screen/user/homePage.dart';
import 'package:holland/widget/cardInput.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundApp,
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: ListView(
            children: [
              Image.asset(
                'assets/images/logoHolland.png',
                width: 300,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("Sign Up", style: boldWhite),
              ),
              Container(
                width: size.width,
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: boxInput,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cardInput(
                      title: "username",
                      controller: nameController,
                      hint: "Masukkan username",
                      isSecure: false,
                    ),
                    cardInput(
                      title: "Alamat",
                      controller: addressController,
                      hint: "Masukkan alamat",
                      isSecure: false,
                    ),
                    cardInput(
                      title: "Email",
                      controller: emailController,
                      hint: "Masukkan email",
                      isSecure: false,
                    ),
                    cardInput(
                      title: "Password",
                      controller: passwordController,
                      hint: "Masukkan password",
                      isSecure: false,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                        child: const Text("Login"),
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(100, 25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Suddah punya akun ?",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
