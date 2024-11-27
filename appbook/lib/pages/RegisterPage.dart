import 'package:firebase_auth/firebase_auth.dart'; // Mengimpor paket Firebase Auth untuk otentikasi pengguna
import 'package:flutter/material.dart'; // Mengimpor paket Material untuk komponen UI
import 'package:appbook/helper/helper_functions.dart'; // Mengimpor fungsi pembantu untuk menampilkan pesan
import 'package:appbook/components/button.dart'; // Mengimpor komponen tombol khusus
import 'package:appbook/components/textfield.dart'; // Mengimpor komponen text field khusus
import 'package:appbook/pages/LoginPage.dart'; // Mengimpor halaman login
import 'package:appbook/auth/Login_or_Register.dart';

// Mendefinisikan RegisterPage sebagai StatefulWidget
class RegisterPage extends StatefulWidget {
  final void Function()? onTap; // Callback untuk menangani navigasi ke halaman login

  const RegisterPage({super.key, required this.onTap}); // Konstruktor dengan key opsional dan onTap yang diperlukan


  @override
  State<RegisterPage> createState() => _RegisterPageState(); // Menghubungkan dengan state yang sesuai
}

// State untuk RegisterPage
class _RegisterPageState extends State<RegisterPage> {
  // Kontroler untuk input teks
  final TextEditingController usernameController = TextEditingController(); // Kontroler untuk nama pengguna
  final TextEditingController emailController = TextEditingController(); // Kontroler untuk email
  final TextEditingController passwordController = TextEditingController(); // Kontroler untuk password
  final TextEditingController confirmpasswordController = TextEditingController(); // Kontroler untuk konfirmasi password

  // Skala untuk animasi avatar
  double _avatarScale = 1.0; // Faktor skala untuk avatar

  // Status visibilitas untuk field password
  bool _isPasswordVisible = false; // Status untuk visibilitas password
  bool _isConfirmPasswordVisible = false; // Status untuk visibilitas konfirmasi password

  @override
  void initState() {
    super.initState(); // Memanggil initState dari superclass
    // Mengatur animasi skala avatar saat halaman dimuat
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _avatarScale = 1.1; // Meningkatkan skala
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _avatarScale = 1.0; // Mengembalikan skala ke normal
        });
      });
    });
  }

  // Metode untuk mendaftar pengguna
  void registerUser() async {
    // Menampilkan indikator loading
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(), // Indikator loading
      ),
    );

    // Memastikan password dan konfirmasi password cocok
    if (passwordController.text != confirmpasswordController.text) {
      // Menutup indikator loading
      Navigator.pop(context);
      // Menampilkan pesan kesalahan kepada pengguna
      displayMessageToUser("Passwords don't match!", context);
    } else {
      // Mencoba membuat pengguna baru
      try {
        // Membuat pengguna baru
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, // Menggunakan email dari kontroler
          password: passwordController.text, // Menggunakan password dari kontroler
        );

        // Menutup indikator loading
        Navigator.pop(context);

        // Menavigasi ke halaman LoginPage setelah pendaftaran berhasil
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage(onTap: widget.onTap)),
        );
      } on FirebaseAuthException catch (e) {
        // Menutup indikator loading
        Navigator.pop(context);
        // Menampilkan pesan kesalahan kepada pengguna
        displayMessageToUser(e.code, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Struktur dasar halaman
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient( // Mengatur latar belakang dengan gradien
            colors: [
              const Color.fromARGB(255, 2, 85, 6), // Hijau gelap
              const Color.fromARGB(255, 188, 255, 152), // Kuning terang
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0), // Padding di sekitar konten
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Mengatur posisi kolom di tengah
              children: [
                // Avatar dengan animasi skala
                Transform.scale(
                  scale: _avatarScale, // Mengatur skala avatar
                  child: CircleAvatar(
                    radius: 50, // Jari-jari lingkaran
                    backgroundColor: Colors.white, // Warna latar belakang lingkaran
                    child: Icon(
                      Icons.forest, // Ikon daun
                      size: 50, // Ukuran ikon
                      color: Colors.green, // Warna ikon
                    ),
                  ),
                ),
                const SizedBox(height: 15), // Spasi di bawah avatar
                Text(
                  "REGISTER", // Judul halaman
                  style: TextStyle(fontSize: 30, color: Colors.white), // Gaya teks untuk judul
                ),
                const SizedBox(height: 20), // Spasi di bawah judul
                // Kartu untuk input field dan tombol
                Card(
                  elevation: 5, // Elevasi untuk bayangan kartu
                  child: Padding(
                    padding: const EdgeInsets.all(20.0), // Padding di dalam kartu
                    child: Column(
                      children: [
                        MyTextField( // Field input untuk email
                          hintText: "Email", // Teks petunjuk
                          obscureText: false, // Tidak menyembunyikan teks
                          controller: emailController, // Mengaitkan kontroler
                        ),
                        const SizedBox(height: 10), // Spasi antar field
                        MyTextField( // Field input untuk password
                          hintText: "Password", // Teks petunjuk
                          obscureText: !_isPasswordVisible, // Menyembunyikan teks jika tidak terlihat
                          controller: passwordController, // Mengaitkan kontroler
                          suffixIcon: IconButton( // Tombol untuk toggle visibilitas password
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off, // Ikon toggle
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible; // Mengubah status visibilitas
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10), // Spasi antar field
                        MyTextField( // Field input untuk konfirmasi password
                          hintText: "Confirm Password", // Teks petunjuk
                          obscureText: !_isConfirmPasswordVisible, // Menyembunyikan teks jika tidak terlihat
                          controller: confirmpasswordController, // Mengaitkan kontroler
                          suffixIcon: IconButton( // Tombol untuk toggle visibilitas konfirmasi password
                            icon: Icon(
                              _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off, // Ikon toggle
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible = !_isConfirmPasswordVisible; // Mengubah status visibilitas
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 25), // Spasi antar field dan tombol
                        MyButton( // Tombol untuk mendaftar
                          text: "Sign Up", // Teks tombol
                          onTap: registerUser, // Mengaitkan fungsi registerUser
                        ),
                        const SizedBox(height: 15), // Spasi di bawah tombol
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center, // Mengatur posisi baris ke tengah
                          children: [
                            Text(
                              "Already have an account?", // Pesan untuk pengguna yang sudah terdaftar
                              style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary), // Menggunakan warna tema
                            ),
                            GestureDetector( // Teks untuk mengalihkan ke halaman login
                              onTap: widget.onTap, // Mengaitkan aksi untuk berpindah ke halaman login
                              child: const Text(
                                " Login here", // Teks untuk tautan login
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, // Mengatur teks menjadi tebal
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}