# Your Wish 
### Nama: Khairunisa Aprilia
### Kelas: B Sistem Informasi 2024
### NIM: 2409116060

# Deskripsi Aplikasi
YourWish adalah aplikasi wishlist sederhana berbasis Flutter yang membantu pengguna mencatat, mengelola, dan memantau barang impian mereka.

Aplikasi ini dirancang dengan tampilan clean dan aesthetic sehingga mudah digunakan untuk kebutuhan sehari-hari. Pengguna dapat menambahkan wishlist baru, mengedit, menghapus, mencari dan memfilter wishlist berdasarkan kategori.

Untuk meningkatkan kenyamanan penggunaan, aplikasi ini dilengkapi dengan dark mode dan light mode sehingga pengguna dapat menyesuaikan tampilan aplikasi sesuai preferensi mereka.


# Fitur Aplikasi
## 1. Menambahkan wishlist baru
<p align="center">
  <img alt="image" src="https://github.com/user-attachments/assets/1892efb3-9e9f-4c30-94a6-cdb3a35dc182" width="30%" height="auto">
</p>

Dengan 3 TextField yaitu Title, Price, dan Notes. Dan 1 Dropdown Category.Title digunakan untuk nama barang, Price untuk perkiraan harga, Notes untuk catatan tambahan, dan Category dipilih melalui dropdown untuk mengelompokkan wishlist.

Form ini juga memiliki validasi input. Field Title dan Category wajib diisi, sedangkan Price dan Notes bersifat opsional. Namun jika Price diisi, maka nilainya harus berupa angka yang valid. Validasi ini dilakukan agar data yang disimpan tetap benar dan sesuai format yang diharapkan oleh aplikasi.

## 2. Mengupdate wishlist yang ada
<p align="center">
 <img alt="image" src="https://github.com/k149191/Assets_Kai/blob/main/image/pab/update.png" width="30%" height="auto">
</p>

## 3. Menghapus wishlist dengan konfirmasi
<p align="center">
  <img alt="image" src="https://github.com/user-attachments/assets/3f12388d-3db7-4c89-bfaf-7f3a89e60d93" width="30%" height="auto">
</p>

## 4. Menampilkan daftar wishlist
<p align="center">
  <img alt="image" src="https://github.com/user-attachments/assets/1077d065-03ad-4e8b-9790-a49790c031ec" width="30%" height="auto">
</p>

## 5. Pencarian wishlist
<p align="center">
  <img alt="image" src="https://github.com/user-attachments/assets/1fa5a09e-07c1-487e-b4f2-8fae9ef2971b" width="30%" height="auto">
</p>

## 6. Filter wishlist berdasarkan kategori
<p align="center">
  <img alt="image" src="https://github.com/user-attachments/assets/d5b32ba4-9e68-4234-beeb-ba0cf07499ea" width="30%" height="auto">
</p>

## 7. Home Page
<p align="center">
  <img alt="image" src="https://github.com/k149191/Assets_Kai/blob/main/image/pab/homepage.png" width="30%" height="auto">
</p>

## 8. Multi Navigation Page
<p align="center">
  <img alt="image"src="https://github.com/user-attachments/assets/9b8dfb83-ad89-4c73-8349-e82dcadcc9f2" width="30%" height="auto">
</p>

- Menggunakan Bottom Navigation Bar untuk berpindah antar halaman (Home, Add, Wishlist).
- Tombol “Start adding your dream items.” pada halaman Home berfungsi sebagai shortcut menuju halaman Add Wish.

## 9. Register
<p align="center">
<img alt="image" src="https://github.com/k149191/Assets_Kai/blob/main/image/pab/regis.png" width="30%" height="auto">
</p>

- Digunakan untuk membuat akun baru agar pengguna dapat menggunakan aplikasi.
- Pengguna mengisi username, email, dan password pada form registrasi.
- Sistem melakukan validasi input untuk memastikan data terisi dengan benar.
- Username tidak boleh sama dengan pengguna lain agar setiap akun memiliki identitas yang unik.
- Jika data valid, akun akan berhasil dibuat dan pengguna dapat melakukan login ke aplikasi.

## 10. Login
<p align="center">
<img alt="image" src="https://github.com/k149191/Assets_Kai/blob/main/image/pab/login.png" width="30%" height="auto">
</p>

```
demo account
username: kai
pass: Kai123
```

- Digunakan agar pengguna dapat masuk ke dalam aplikasi menggunakan akun yang sudah terdaftar.
- Pengguna mengisi username dan password pada form login.
- Sistem akan memeriksa apakah username dan password sesuai dengan data yang tersimpan di database.
- Jika username atau password salah, sistem akan menampilkan pesan kesalahan.
- Jika data benar, pengguna akan berhasil login dan dapat mengakses fitur wishlist.

## 11. Dark Mode & Light Mode
  ###  1). Dark Mode
<p align="center">
<img alt="image" src="https://github.com/k149191/Assets_Kai/blob/main/image/pab/homepage%20dark%20mode.png" width="30%" height="auto">
</p>

<p align="center">
<img alt="image" src="https://github.com/k149191/Assets_Kai/blob/main/image/pab/add%20dark%20mode.png" width="30%" height="auto">
</p>

<p align="center">
<img alt="image" src="https://github.com/k149191/Assets_Kai/blob/main/image/pab/list%20dark%20mode.png" width="30%" height="auto">
</p>

  ### 2). Light Mode
<p align="center">
<img alt="image" src="https://github.com/k149191/Assets_Kai/blob/main/image/pab/homepage.png" width="30%" height="auto">
</p>

<p align="center">
<img alt="image" src="https://github.com/user-attachments/assets/1892efb3-9e9f-4c30-94a6-cdb3a35dc182" width="30%" height="auto">
</p>

<p align="center">
<img alt="image" src="https://github.com/user-attachments/assets/1077d065-03ad-4e8b-9790-a49790c031ec" width="30%" height="auto">
</p>

# Widget yang Digunakan
Aplikasi ini dibangun menggunakan berbagai widget Flutter, antara lain:
* Scaffold
* AppBar
* Column
* Row
* Expanded
* Padding
* Container
* SizedBox
* SingleChildScrollView
* ListView.builder
* TextField
* DropdownButtonFormField
* SnackBar
* IconButton
* ElevatedButton
* TextButton
* AlertDialog
* Navigator
* BoxDecoration
* BorderRadius
* BoxShadow
* OutlineInputBorder

