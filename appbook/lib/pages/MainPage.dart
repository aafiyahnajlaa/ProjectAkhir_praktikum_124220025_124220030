import 'package:appbook/pages/ProfilPage.dart';
import 'package:appbook/pages/bookmark.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Mengimpor paket Firebase Auth untuk otentikasi pengguna
import 'package:flutter/material.dart'; // Mengimpor paket Material untuk komponen UI
import 'package:appbook/pages/HomePage.dart';
import 'package:shimmer/main.dart'; // Mengimpor halaman Utama
import 'package:appbook/pages/ListBuku.dart';
// Mendefinisikan MainPage sebagai StatelessWidget

// Fungsi untuk logout pengguna dari aplikasi
void logout() {
  FirebaseAuth.instance.signOut(); // Memanggil fungsi signOut dari FirebaseAuth
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key); // Konstruktor dengan key opsional

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> currentIndex = ValueNotifier<int>(0); // Menggunakan ValueNotifier untuk menyimpan index halaman saat ini
    final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false); // Notifier untuk status loading

    // Fungsi untuk menangani navigasi ketika item dipilih
    void onItemTapped(int index) {
      currentIndex.value = index; // Mengatur index saat ini
    }

    // Fungsi untuk menampilkan dialog konfirmasi logout
    void _confirmLogout() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min, // Mengatur ukuran kolom minimum
              children: [
                const Icon(Icons.warning, color: Colors.yellow, size: 60), // Ikon peringatan di bagian atas
                const SizedBox(height: 16), // Spasi antara ikon dan teks
                const Text(
                  'Konfirmasi Logout', // Judul dialog
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Gaya teks untuk judul
                  textAlign: TextAlign.center, // Mengatur alignment teks ke tengah
                ),
                const SizedBox(height: 8), // Spasi antara judul dan pesan
                const Text(
                  'Apakah Anda yakin ingin keluar?', // Pesan konfirmasi
                  textAlign: TextAlign.center, // Mengatur alignment teks ke tengah
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur jarak antar tombol
                children: [
                  TextButton(
                    onPressed: () {

                      Navigator.of(context).pop(); // Menutup dialog jika tombol 'Tidak' ditekan
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red, // Warna latar belakang tombol
                      foregroundColor: Colors.white, // Warna teks tombol
                    ),
                    child: const Text('Tidak'), // Teks tombol
                  ),
                  TextButton(
                    onPressed: () {
                      logout(); // Memanggil fungsi logout jika tombol 'Ya' ditekan
                      Navigator.of(context).pop(); // Menutup dialog
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue, // Warna latar belakang tombol
                      foregroundColor: Colors.white, // Warna teks tombol
                    ),
                    child: const Text('Ya'), // Teks tombol
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'E-BOOK', // Judul aplikasi
              style: TextStyle(color: Colors.white), // Mengatur warna teks judul
            ),
            backgroundColor: const Color.fromARGB(255, 2, 85, 6), // Warna latar belakang AppBar
            automaticallyImplyLeading: false, // Menonaktifkan tombol kembali secara otomatis
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.logout, // Ikon logout
                  color: Colors.white,
                ),
                onPressed: _confirmLogout, // Menampilkan dialog konfirmasi logout saat ikon ditekan
              ),
            ],
          ),
          bottomNavigationBar: ValueListenableBuilder<int>(
            valueListenable: currentIndex, // Menggunakan ValueNotifier untuk bottom navigation
            builder: (context, index, child) {
              return BottomNavigationBar(
                currentIndex: index, // Mengatur indeks saat ini
                type: BottomNavigationBarType.fixed, // Tipe bottom navigation
                selectedItemColor: const Color.fromARGB(255, 188, 255, 152), // Warna item yang dipilih
                backgroundColor: const Color.fromARGB(255, 2, 85, 6), // Warna latar belakang bottom navigation
                elevation: 20, // Elevasi untuk bayangan
                iconSize: 32, // Ukuran ikon
                selectedFontSize: 12, // Ukuran font item yang dipilih
                unselectedFontSize: 12, // Ukuran font item yang tidak dipilih
                unselectedItemColor: Colors.white, // Warna item yang tidak dipilih
                showSelectedLabels: true, // Menampilkan label untuk item yang dipilih
                onTap: onItemTapped, // Mengaitkan fungsi onItemTapped
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home), // Ikon untuk halaman utama
                    label: 'Home',    // Label untuk halaman utama
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark_outlined), // Ikon untuk halaman bantuan
                    label: 'Bookmark', // Label untuk halaman bantuan
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person), // Ikon untuk halaman bantuan
                    label: 'Profil', // Label untuk halaman bantuan
                  ),
                ],
              );
            },
          ),
          body: ValueListenableBuilder<int>(
            valueListenable: currentIndex, // Menggunakan ValueNotifier untuk body
            builder: (context, index, child) {
              switch (index) {
                case 0: // Jika indeks 0, tampilkan HomePage
                  return BookListPage();
                case 1: // Jika indeks 1, tampilkan HelpPage
                  return BookListPage();
                default: // Default ke HomePage jika indeks tidak dikenali
                  return ProfileScreen();
              }
            },
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: isLoading, // Menggunakan ValueNotifier untuk memantau status loading
          builder: (context, loading, child) {
            return loading ? const LoadingScreen() : const SizedBox.shrink(); // Tampilkan loading screen jika loading
          },
        ),
      ],
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key); // Konstruktor dengan key opsional

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')), // Judul untuk halaman login
      body: const Center(child: Text('Please log in')), // Konten halaman login
    );
  }
}

// Mendefinisikan LoadingScreen sebagai StatelessWidget
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key); // Konstruktor dengan key opsional

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(), // Menampilkan indikator loading
    );
  }
}