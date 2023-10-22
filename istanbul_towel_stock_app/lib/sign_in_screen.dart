// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:istanbul_towel_stock_app/product_list_screen.dart'; // Firebase Authentication paketi eklenmeli

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Giriş Yap'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: emailController, // E-posta girişi için
                decoration: InputDecoration(
                  labelText: 'E-posta',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController, // Şifre girişi için
                obscureText: true, // Şifre gizli olacak
                decoration: InputDecoration(
                  labelText: 'Şifre',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  String email = emailController.text;
                  String password = passwordController.text;

                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    // Oturum açma başarılı oldu, ürünlerin listelendiği sayfaya yönlendir
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return ProductListScreen();
                        },
                      ),
                    );
                  } catch (e) {
                    // Oturum açma başarısız olduğunda hata mesajını göster
                    print('Oturum açma başarısız: $e');
                  }
                },
                child: Text('Giriş Yap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
