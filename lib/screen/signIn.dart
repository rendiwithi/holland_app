import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/textStyleData.dart';
import 'package:holland/model/user_model.dart';
import 'package:holland/screen/loginPage.dart';
import 'package:holland/screen/user/homePage.dart';
import 'package:holland/widget/cardInput.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfController = TextEditingController();
  _register() async {
    await User.register(
            name: nameController.text,
            username: usernameController.text,
            password: passwordController.text,
            alamat: addressController.text)
        .then((value) {
      if (value == true) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Berhasil",
          desc: "Silahkan Masuk Ke Halaman",
          buttons: [
            DialogButton(
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              ),
              width: 120,
            )
          ],
        ).show();
      } else {
        Alert(
          context: context,
          type: AlertType.info,
          title: "Gagal",
          desc: "Silahkan Isi Data dengan data baru",
          buttons: [
            DialogButton(
              child: const Text(
                "kembali",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
    });
  }

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
                      title: "name",
                      controller: nameController,
                      hint: "Masukkan Nama",
                      isSecure: false,
                    ),
                    cardInput(
                      title: "username",
                      controller: usernameController,
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
                      title: "Password",
                      controller: passwordController,
                      hint: "Masukkan password",
                      isSecure: true,
                    ),
                    cardInput(
                      title: "Verifikasi Password",
                      controller: passwordConfController,
                      hint: "Masukkan password",
                      isSecure: true,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (nameController.text.isNotEmpty &&
                              usernameController.text.isNotEmpty &&
                              passwordConfController.text.isNotEmpty &&
                              usernameController.text.isNotEmpty &&
                              addressController.text.isNotEmpty &&
                              passwordConfController.text ==
                                  passwordController.text) {
                            _register();
                          } else {
                            Alert(
                              context: context,
                              type: AlertType.info,
                              title: "Info",
                              desc: "Data tidak boleh kosong",
                              buttons: [
                                DialogButton(
                                  child: const Text(
                                    "kembali",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  width: 120,
                                )
                              ],
                            ).show();
                          }
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
