import 'package:firebase_auth/firebase_auth.dart'; // Mengimpor paket Firebase Auth untuk otentikasi pengguna
import 'package:flutter/material.dart'; // Mengimpor paket Material untuk komponen UI
import 'package:appbook/auth/Login_or_Register.dart'; // Mengimpor halaman untuk login atau registrasi
import 'package:appbook/pages/MainPage.dart'; // Mengimpor halaman utama setelah login

// Mendefinisikan AuthPage sebagai StatelessWidget
class AuthPage extends StatelessWidget {
  const AuthPage({super.key}); // Konstruktor dengan key opsional

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Struktur dasar halaman
      body: StreamBuilder( // Membuat StreamBuilder untuk mendengarkan perubahan status otentikasi
          stream: FirebaseAuth.instance.authStateChanges(), // Mendengarkan perubahan status otentikasi pengguna
          builder: (context, snapshot) { // Membangun UI berdasarkan snapshot
            // Jika pengguna sudah login
            if (snapshot.hasData) {
              return const MainPage(); // Navigasi ke halaman utama
            }
            // Jika pengguna belum login
            else {
              return const LoginOrRegister(); // Menampilkan halaman login atau registrasi
            }
          }),
    );
  }
}