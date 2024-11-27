import 'package:flutter/material.dart'; // Mengimpor paket Material untuk komponen UI Flutter

// Fungsi untuk menampilkan pesan kepada pengguna
void displayMessageToUser(String e, BuildContext context, {bool isSuccess = false}) {
  String message; // Variabel untuk menyimpan pesan yang akan ditampilkan
  IconData icon; // Variabel untuk menyimpan ikon yang akan ditampilkan
  Color iconColor; // Variabel untuk menyimpan warna ikon
  Color backgroundColor; //Variabel untuk menyimpan warna latar belakang dialog

  // Menentukan pesan, ikon, dan warna latar belakang berdasarkan jenis pesan
  switch (e) {
    case "email-already-in-use": // Kasus untuk email yang sudah terdaftar
      message = "Email sudah terdaftar"; // Pesan yang akan ditampilkan
      icon = Icons.error; // Ikon kesalahan
      iconColor = Colors.red; // Warna ikon
      backgroundColor = Colors.red[100]!; // Warna latar belakang dialog
      break;
    case "invalid-email": // Kasus untuk email tidak valid
      message = "Format email tidak valid"; // Pesan yang akan ditampilkan
      icon = Icons.error; // Ikon kesalahan
      iconColor = Colors.red; // Warna ikon
      backgroundColor = Colors.red[100]!; // Warna latar belakang dialog
      break;
    case "weak-password": // Kasus untuk password yang lemah
      message = "Password terlalu lemah"; // Pesan yang akan ditampilkan
      icon = Icons.error; // Ikon kesalahan
      iconColor = Colors.red; // Warna ikon
      backgroundColor = Colors.red[100]!; // Warna latar belakang dialog
      break;
    case "wrong-password": // Kasus untuk password yang salah
      message = "Password salah"; // Pesan yang akan ditampilkan
      icon = Icons.error; // Ikon kesalahan
      iconColor = Colors.red; // Warna ikon
      backgroundColor = Colors.red[100]!; // Warna latar belakang dialog
      break;
    case "user-not-found": // Kasus untuk pengguna yang tidak ditemukan
      message = "Pengguna tidak ditemukan"; // Pesan yang akan ditampilkan
      icon = Icons.error; // Ikon kesalahan
      iconColor = Colors.red; // Warna ikon
      backgroundColor = Colors.red[100]!; // Warna latar belakang dialog
      break;
    default: // Kasus untuk pesan yang tidak terdefinisi
      message = "$e"; // Menampilkan pesan kesalahan asli
      icon = isSuccess ? Icons.check_circle : Icons.error; // Ikon sukses atau kesalahan
      iconColor = isSuccess ? Colors.green : Colors.red; // Warna ikon berdasarkan status
      backgroundColor = isSuccess ? Colors.green[100]! : Colors.red[100]!; // Warna latar belakang berdasarkan status
      break;
  }

  // Menampilkan pesan kepada pengguna dalam dialog
  showDialog(
    context: context,
    builder: (context) => AlertDialog( // Membuat dialog alert
      title: Column( // Menyusun judul dialog
        children: [
          Icon(icon, color: iconColor, size: 60), // Ikon besar di tengah
          const SizedBox(height: 8), // Spasi antara ikon dan judul
          const Text('Error', style: TextStyle(fontSize: 24)), // Judul dialog
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.all(16), // Padding di sekitar konten
        child: Text(
          message, // Pesan yang akan ditampilkan
          textAlign: TextAlign.center, // Menyejajarkan teks di tengah
          style: const TextStyle(fontSize: 16), // Ukuran font untuk pesan
        ),
      ),
      actions: [
        Center(
          child: TextButton( // Tombol untuk menutup dialog
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue, // Warna latar belakang tombol
              foregroundColor: Colors.white, // Warna teks tombol
            ),
            onPressed: () => Navigator.pop(context), // Menutup dialog saat tombol ditekan
            child: const Text('Close'), // Teks tombol
          ),
        ),
      ],
    ),
  );
}