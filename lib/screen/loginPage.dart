import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/textStyleData.dart';
import 'package:holland/model/user_model.dart';
import 'package:holland/screen/signIn.dart';
import 'package:holland/screen/user/homePage.dart';
import 'package:holland/widget/cardInput.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    loginCek({
      required String username,
      required String password,
    }) {
      if (username.isEmpty || password.isEmpty) {
        for (var i = 0; i < listUser.length; i++) {
          if (listUser[i].username == username &&
              listUser[i].password == password) {
            if (listUser[i].role == "admin") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            } else if (listUser[i].role == "user") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            } else {
              userController.clear();
              passwordController.clear();
            }
          } else {
            userController.clear();
            passwordController.clear();
          }
        }
      } else {
        userController.clear();
        passwordController.clear();
      }
    }

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
              child: Text("Login", style: boldWhite),
            ),
            Container(
              height: 300,
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
                    title: "Username",
                    controller: userController,
                    hint: "Masukkan Username",
                    isSecure: false,
                  ),
                  cardInput(
                    title: "Password",
                    controller: passwordController,
                    hint: "Masukkan password",
                    isSecure: true,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        loginCek(
                          username: userController.text,
                          password: passwordController.text,
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
                          builder: (context) => const SignIn(),
                        ),
                      );
                    },
                    child: const Text(
                      "Belum punya akun ?",
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
      )),
    );
  }
}
