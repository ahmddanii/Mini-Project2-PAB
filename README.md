<h1 align="center">💸 KasFlow</h1>
<p align="center">
  <b>Modern Cashflow Tracker for UMKM</b>

</p>

<div align="center">
    <img height="500" alt="Image" src="https://github.com/user-attachments/assets/d84be607-5ae7-4014-bd62-09ed5378bc7f" />
    <img height="500" alt="Image" src="https://github.com/user-attachments/assets/b74abd5b-c5a9-4dab-9afb-0cb58d9a0868" />
</div>


## 👨‍💻 Developed By

**Ahmad Dani**   
2409116074

## 📃 Deskripsi Aplikasi 
KasFlow adalah aplikasi mobile berbasis Flutter yang dirancang untuk membantu pelaku UMKM dalam mengelola dan memantau arus kas usaha secara sederhana, cepat, dan efisien.
Aplikasi ini memungkinkan pengguna untuk mencatat pemasukan dan pengeluaran, menghitung saldo secara otomatis, serta mengelola transaksi dengan fitur CRUD lengkap (Create, Read, Update, Delete).

## ⚙️ Fitur Aplikasi
1. **Create (Tambah Data)**  
  <img height="500" alt="Image" src="https://github.com/user-attachments/assets/415f0d96-34b5-4ba5-a4fe-1841880195e5" />

   Pengguna dapat menambahkan transaksi baru dengan mengisi:
   - Nama Transaksi
   - Jumlah Transaksi
   - Kategori (Pemasukan / Pengeluaran)
   - Tanggal Transaksi

2. **Read (Tampilkan Data)**  
  <img height="500" alt="Image" src="https://github.com/user-attachments/assets/b74abd5b-c5a9-4dab-9afb-0cb58d9a0868" />

   Menampilkan daftar seluruh transaksi dalam bentuk list yang informatif.

3. **Update (Edit Data)**  
  <img height="500" alt="Image" src="https://github.com/user-attachments/assets/0d4eed1d-0d0e-40ef-853d-ef517ce06595" />
  
   Pengguna dapat mengedit data transaksi yang telah dibuat sebelumnya.

4. **Delete (Hapus Data)**  
  <img height="500" alt="image" src="https://github.com/user-attachments/assets/846a45be-9c7c-42c1-b6f4-6d0f68c974f8" />

   Pengguna dapat menghapus transaksi, dan saldo akan otomatis diperbarui.

5. **Perhitungan Saldo Otomatis**  
  <img height="500" alt="image" src="https://github.com/user-attachments/assets/5e763bb8-1429-4d26-b465-c7aaa5e7f296" />

   Saldo dihitung berdasarkan total pemasukan dikurangi total pengeluaran.

6. **Multi Page Navigation**  
   Aplikasi terdiri dari beberapa halaman:
   - Home Page (Dashboard)
    <img height="500" alt="Screenshot 2026-02-28 202355" src="https://github.com/user-attachments/assets/f1133930-ed5b-438f-9730-cba6e1ebc299" />
     
   - Add Transaction Page
    <img height="500" alt="image" src="https://github.com/user-attachments/assets/64c2453d-ab28-429a-96f0-814c3822dd55" />
     
   - Edit Transaction Page
    <img height="500" alt="image" src="https://github.com/user-attachments/assets/8c9cf8f5-f6d5-4a62-82d7-26cb0af21ac7" />

### **⚙️ Fitur Baru (Update untuk Minpro 2)**     
1. **Register Page**
<img height="500" alt="Image" src="https://github.com/user-attachments/assets/797f2de3-209c-41af-8ce1-7f1d7149c8ec" />

Pengguna dapat register untuk melakukan pencatatan di aplikasi KasFlow, register disini menggunakan fungsi authentication default dari supabase.

3. **Login Page**
<img height="500" alt="Image" src="https://github.com/user-attachments/assets/c1aa14a0-80be-450a-9a21-f7e23d5ca91a" />

Jika pengguna sudah memiliki akun, pengguna dapat melakukan login untuk mencatat setiap transaksi yang dilakukannya

4. **Dark & Light Mode**
<img height="500" alt="Image" src="https://github.com/user-attachments/assets/b74abd5b-c5a9-4dab-9afb-0cb58d9a0868" />

Tampilan aplikasi dalam light mode


<img height="500" alt="Image" src="https://github.com/user-attachments/assets/d84be607-5ae7-4014-bd62-09ed5378bc7f" />

Tampilan aplikasi dalam dark mode

---

## 🧱 Widget yang Digunakan

Dalam pengembangan aplikasi KasFlow, digunakan berbagai widget Flutter untuk membangun tampilan dan fungsionalitas aplikasi secara optimal. Berikut pengelompokan widget berdasarkan fungsinya:

🔹 Struktur Dasar Aplikasi

- GetMaterialApp → Konfigurasi utama aplikasi

- Scaffold → Struktur dasar halaman

- AppBar → Menampilkan judul halaman

- GetX Navigation → Mengatur perpindahan antar halaman

🔹 Layout & Tampilan

- Container → Styling UI seperti card dan summary

- Column & Row → Layout vertikal dan horizontal

- Expanded → Mengatur pembagian ruang dalam layout

- ListView.builder → Menampilkan daftar transaksi secara dinamis

- CircleAvatar → Menampilkan ikon transaksi

🔹 Input & Interaksi

- TextField → Input data transaksi

- DropdownButton → Memilih kategori transaksi

- ElevatedButton → Tombol simpan dan update transaksi

- FloatingActionButton → Tombol tambah transaksi

- IconButton → Tombol hapus transaksi

- GestureDetector → Navigasi ke halaman edit transaksi

🔹 Feedback & Notifikasi

- Get.snackbar() → Menampilkan notifikasi kepada pengguna

- Get.defaultDialog() → Menampilkan dialog konfirmasi

🔹 State Management

- GetX Controller → Mengelola state transaksi dan saldo
