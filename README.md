# Proyek Akhir Semester Kelompok-E 03

## Anggota Kelompok-E 03:

1. Adjie Djaka Permana - 2106702485
2. Trias Ahmad Fairuz - 2106633645
3. Dhafiano Fadeyka Ghani Wiweko - 2106751631
4. Muhammad Reyvan Natechnoury - 2106654353
5. Muhammad Nabil Mahardika - 2106751871

## Deskripsi Aplikasi

GenerosiTree merupakan aplikasi yang menyediakan sebuah donasi, donasi yang kami implementasikan adalah donasi pohon. Jadi maksud dari donasi pohon ini adalah setiap orang yang menyumbangkan sebagian uangnya ke dalam aplikasi kami, maka uang tersebut akan ditukarkan menjadi sumbangan berbentuk pohon yang nantinya akan ditanam pada lokasi tertentu di seluruh wilayah Indonesia. Asal-usul ide kami datang dari sebuah masalah dunia yang dimana emisi karbon setiap tahunnya selalu meningkat, maka dari itu kami berharap aplikasi donasi pohon ini dapat mengurangi dampak kerugian dari emisi karbon yang biasanya dihasilkan oleh pabrik-pabrik. Selain penukaran uang untuk donasi pohon, kami juga terdapat penukaran uang untuk para pengguna yang melakukan donasi berupa koin, sehingga para pengguna dapat menukarkan koinnya dengan membeli berbagai macam barang yang bermanfaat. Barang-barang yang kami sediakan di marketplace juga memiliki visi dan misi yang sama dengan tujuan utama kami, yaitu melawan emisi karbon. Barang yang tersedia pada aplikasi kami ada tumblr, shopping bag, dan tempat makan. Selain itu kami juga terdapat fitur leaderboard dimana akan menampilkan user-user dari berbagai penjuru dunia yang berlomba untuk menghasilkan sumbangan paling banyak untuk donasi pohon. Kami berharap pada fitur ini untuk dapat mendorong pengguna lainnya dalam menyumbangkan kebaikan dan menyelamatkan planet bumi ini menjadi tempat yang subur, nyaman, dan lebih sehat untuk disinggahi.

Berikut adalah fitur dan peran dalam kelompok untuk pembentukan aplikasi GenerosiTree:

1. Implementasi User, Profile, dan History (Adjie Djaka Permana)
2. Donasi Pohon (Trias Ahmad Fairuz)
3. Leaderboard (Dhafiano Fadeyka Ghani Wiweko)
4. Marketplace (Muhammad Reyvan Natechnoury)
5. Pusat Bantuan (Muhammad Nabil Mahardika)

## Daftar fitur atau modul yang diimplementasikan

- Implementasi User dan Profile -> Adjie  
  Modul ini meliputi semua keperluan implementasi user, diantaranya: - Login, untuk memberikan autorisasi terhadap user yang sudah terdaftar. - Registrasi, untuk mendaftarkan akun user yang baru - Logout, untuk keluar dari suatu sesi

      Selain implementasi user, terdapat juga implementasi profil yang berkaitan tentang website ini, hal-hal tersebut dalam bentuk:
      - Tampilan data sebuah user, seperti user name, password, koin, dan field-field lain yang dimiliki sebuah user.
      - Pengaturan untuk mengubah username dan password, serta field lain yang diperlukan.
      - Riwayat transaksi donasi pohon, sekaligus menunjukkan laporan bulanan berupa jumlah donasi pohon yang telah dilakukan.

- Donasi Pohon -> Trias  
  Modul ini meliputi semua yang berkaitan dengan donasi pohon. Hal tersebut meliputi: - Form untuk jumlah donasi pohon yang diinginkan. - Pemilihan metode pembayaran yang diinginkan, serta pengunggahan bukti (tidak diimplementasikan secara nyata, dalam artian hanya berdasarkan jumlah input pada form) - Pemilihan lokasi donasi pohon dari sejumlah lokasi yang sudah ditentukan. - Setelah sebuah user melakukan donasi pohon, user tersebut akan mendapatkan poin yang proporsional dengan jumlah donasi pohon.

- Marketplace -> Reyvan  
  Modul ini meliputi semua keperluan sebuah marketplace, yang berfungsi seperti sebuah e-commerce, hal-hal tersebut diantaranya: - Tampilan barang-barang yang tersedia - Fitur keranjang belanja untuk menyimpan sejumlah barang-barang pada marketplace. - Fitur untuk membeli barang tersebut, yang mencakup form untuk menentukan kuantitas serta bukti transaksi.

- Leaderboard -> Dhafiano  
  Modul ini mencakup hal-hal yang berkaitan dengan leaderboard, antara lain: - Tampilan leaderboard berupa user-user dengan jumlah donasi terbanyak pada lokasi tertentu - Form yang bisa digunakan untuk menentukan lokasi mana yang ingin dilihat leaderboardnya.

- Pusat Bantuan -> Nabil  
  Modul ini berisi semua hal tentang pusat bantuan - Form yang berlaku seperti search bar untuk mencari bantuan mengenai hal spesifik. - Tampilan dan sejumlah Frequently Asked Questions

## Alur Pengintegrasian dengan Web Service

Dalam melakukan pengintegrasian aplikasi dengan web service, kami menggunakan library dart yaitu `http`. Kami menggunakan library tersebut untuk melakukan pertukaran data dengan aplikasi Django yang telah kami buat pada tugas pertengahan semester. Aplikasi Flutter yang kami buat akan melakukan hit pada endpoint yang dibutuhkan yang ada di aplikasi Django yang juga kami buat. Lalu, aplikasi Django tersebut akan mengirimkan data yang telah diolah ke Flutter dalam bentuk JSON. Selanjutnya, data tersebut akan didistribusikan di aplikasi Flutter.
