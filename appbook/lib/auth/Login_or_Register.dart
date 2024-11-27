import 'package:flutter/material.dart'; // Mengimpor paket Material untuk komponen UI
import 'package:appbook/pages/LoginPage.dart'; // Mengimpor halaman login
import 'package:appbook/pages/RegisterPage.dart'; // Mengimpor halaman registrasi

// Mendefinisikan LoginOrRegister sebagai StatefulWidget
class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key}); // Konstruktor dengan key opsional

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState(); // Menghubungkan dengan state yang sesuai
}

// State untuk LoginOrRegister
class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Variabel untuk menentukan tampilan yang akan ditampilkan, awalnya menunjukkan halaman login
  bool showLoginPage = true;

  // Fungsi untuk beralih antara halaman login dan registrasi
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage; // Mengubah status tampilan
    });
  }

  @override
  Widget build(BuildContext context) {
    // Membangun UI berdasarkan status showLoginPage
    if (showLoginPage) {
      return LoginPage(onTap: togglePages); // Menampilkan halaman login
    } else {
      return RegisterPage(onTap: togglePages); // Menampilkan halaman registrasi
    }
  }
}