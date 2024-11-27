import 'package:firebase_auth/firebase_auth.dart'; // Mengimpor paket Firebase Auth untuk otentikasi pengguna
import 'package:flutter/material.dart'; // Mengimpor paket Material untuk komponen UI
import 'package:appbook/components/button.dart'; // Mengimpor komponen tombol khusus
import 'package:appbook/components/textfield.dart'; // Mengimpor komponen text field khusus
import 'package:appbook/helper/helper_functions.dart';
import 'package:appbook/pages/MainPage.dart';
import 'package:appbook/pages/HomePage.dart';

// Mendefinisikan LoginPage sebagai StatefulWidget
class LoginPage extends StatefulWidget {
  final void Function()? onTap; // Callback untuk menangani pendaftaran

  const LoginPage({super.key, required this.onTap}); // Konstruktor dengan key opsional dan onTap yang diperlukan

  @override
  State<LoginPage> createState() => _LoginPageState(); // Menghubungkan dengan state yang sesuai
}

// State untuk LoginPage
class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  // Kontroler untuk input teks
  final TextEditingController emailController = TextEditingController(); // Kontroler untuk email
  final TextEditingController passwordController = TextEditingController(); // Kontroler untuk password

  // Variabel untuk mengontrol visibilitas password
  bool _isPasswordVisible = false; // Status visibilitas password

  // Variabel untuk animasi
  double _avatarScale = 1.0; // Skala untuk animasi avatar

  @override
  void initState() {
    super.initState(); // Memanggil initState dari superclass
    // Skala avatar saat halaman dimuat (jika diperlukan)
  }

  // Metode untuk login
  void login() async {
    // Menampilkan indikator loading
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(), // Indikator loading
      ),
    );

    // Mencoba melakukan login
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text); // Melakukan otentikasi
      // Menghapus indikator loading
      if (context.mounted) Navigator.pop(context); // Menutup dialog loading jika konteks masih ada
      // Menavigasi ke halaman MainPage setelah pendaftaran berhasil

    } on FirebaseAuthException catch (e) {
      // Menghapus indikator loading
      Navigator.pop(context); // Menutup dialog loading
      displayMessageToUser(e.code, context); // Menampilkan pesan kesalahan kepada pengguna
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
              mainAxisAlignment: MainAxisAlignment.end, // Mengatur posisi kolom ke bawah
              children: [
                // Ikon profil bulat dengan simbol daun
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300), // Durasi animasi
                  curve: Curves.easeInOut, // Kurva animasi
                  transform: Matrix4.identity()..scale(_avatarScale), // Menerapkan skala pada avatar
                  child: CircleAvatar(
                    radius: 50, // Jari-jari lingkaran
                    backgroundColor: Colors.white, // Warna latar belakang lingkaran
                    child: Icon(
                      Icons.menu_book, // Ikon daun
                      size: 50, // Ukuran ikon
                      color: Colors.green, // Warna ikon
                    ),
                  ),
                ),

                const SizedBox(height: 25), // Spasi antara avatar dan teks

                // Nama aplikasi dengan warna putih
                Text(
                  "L O G I N", // Teks judul
                  style: const TextStyle(
                    fontSize: 30, // Ukuran font
                    color: Colors.white, // Mengubah warna teks menjadi putih
                  ),
                ),

                const SizedBox(height: 50), // Spasi antara teks dan kartu input

                // Kartu untuk field input dan tombol
                Card(
                  elevation: 5, // Elevasi untuk bayangan kartu
                  child: Padding(
                    padding: const EdgeInsets.all(20.0), // Padding di dalam kartu
                    child: Column(
                      children: [
                        // Field input untuk email dengan ikon
                        MyTextField(
                          hintText: "Email", // Teks petunjuk
                          obscureText: false, // Tidak menyembunyikan teks
                          controller: emailController, // Mengaitkan kontroler
                          prefixIcon: const Icon(Icons.email, color: Colors.grey), // Ikon prefix
                        ),

                        const SizedBox(height: 10), // Spasi antar field

                        // Field input untuk password dengan ikon dan toggle visibilitas
                        MyTextField(
                          hintText: "Password", // Teks petunjuk
                          obscureText: !_isPasswordVisible, // Menyembunyikan teks jika tidak terlihat
                          controller: passwordController, // Mengaitkan kontroler
                          prefixIcon: const Icon(Icons.lock, color: Colors.grey), // Ikon prefix
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off, // Ikon toggle
                              color: Colors.black,
                            ),
                            onPressed: () { // Aksi ketika ikon ditekan
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible; // Mengubah status visibilitas
                              });
                            },
                          ),
                        ),

                        const SizedBox(height: 20), // Spasi antar field dan tombol

                        // Tombol untuk masuk
                        MyButton(
                          text: "Sign In", // Teks tombol
                          onTap: login, // Mengaitkan aksi login
                        ),
                      ],
                    ),
                  ),
                ),

                // Pesan untuk pengguna yang belum memiliki akun
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Mengatur posisi baris ke tengah
                  children: [
                    Text(
                      "Don't have an account?", // Pesan teks
                      style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary), // Menggunakan warna tema
                    ),
                    GestureDetector(
                      onTap: widget.onTap, // Aksi ketika teks ditekan
                      child: const Text(
                        "Register here", // Teks untuk pendaftaran
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Mengatur teks menjadi tebal
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Spasi di bagian bawah
              ],
            ),
          ),
        ),
      ),
    );
  }
}