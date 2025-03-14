<p align="center">

  <img width="350" height="350" src="images/logo.jpg">

</p>

<div align="center">
  
#  StatLink Database : Portal Jurusan Statistika di Indonesia


[Tentang](#notebook-tentang)
•
[Dashboard Database](#desktop_computer-dashboard-database)


</div>

## :bookmark_tabs: Menu

- [Tentang](#notebook-tentang)
- [INFO](#bookmark_tabs-INFO)
- [Palet Warna](#desktop_computer-palet-warna)
- [User Flow](#desktop_computer-user-flow)
- [Wireframe](#desktop_computer-wireframe)
- [Alur Wireframe](#desktop_computer-alur-wireframe)
- [Dashboard Database](#desktop_computer-dashboard-database)
- [Requirements](#exclamation-requirements)
- [Skema Database](#film_strip-skema-database)
- [ERD](#chart_with_downwards_trend-erd)
- [Deskripsi Data](#postbox-deskripsi-data)
- [Struktur Folder](#open_file_folder-struktur-folder)
- [Tim Pengembang](#ninja-tim-pengembang)

## :notebook: Tentang 

<div align="justify">

📊**Mau Jadi Ahli Data di Era Digital? Pilih Jurusan Statistika!** 🚀

Statistika adalah ilmu yang mempelajari cara mengumpulkan, mengelola,
menganalisis, dan menginterpretasikan data untuk mendapatkan informasi
yang akurat dan bermanfaat. Dengan statistika, kita bisa memahami pola,
membuat prediksi, dan mengambil keputusan berdasarkan data yang valid.

Di jurusan ini, kamu akan belajar banyak hal menarik, seperti:

**Statistika & Probabilitas** – Dasar untuk memahami dan mengolah data
dengan benar.

**Matematika & Pemodelan** – Fondasi penting dalam analisis data.

**Pemrograman & Analisis Data** – Menggunakan software seperti Python,
R, dan SQL untuk mengolah data.

**Machine Learning & Big Data** – Menemukan pola dan membuat prediksi
dengan kecerdasan buatan.

**Statistika Terapan** – Penerapan di berbagai bidang seperti bisnis,
kesehatan, ekonomi, dan teknologi.

**Kenapa harus masuk Jurusan Statistika?**

**Dibutuhkan di Banyak Industri** – Semua sektor, dari bisnis hingga
teknologi, membutuhkan ahli statistik. 💰

**Gaji Kompetitif & Peluang Karier Besar** – Analis data, data
scientist, aktuaris, dan masih banyak lagi! 📈

**Kemampuan Berpikir Kritis & Problem Solving** – Skill yang berguna
untuk karier dan kehidupan sehari-hari.

### :bookmark_tabs: INFO 

**Temukan Kampus Statistika Terbaik di Statlink!** 🚀

**Statlink** adalah portal informasi paling lengkap untuk jurusan
Statistika di Indonesia! Dengan berbagai pilihan perguruan tinggi mulai
dari Universitas, Institut, hingga Sekolah Tinggi Statlink membantumu
menemukan kampus terbaik untuk jenjang Sarjana (S1), Magister (S2),
hingga Doktor (S3).

**🔎 Kenapa Harus Pakai Statlink?**

✅ Akses lebih dari 30 program Statistika di seluruh Indonesia

✅ Temukan kampus impianmu dari Sabang hingga Merauke

✅ Fitur pencarian lokasi kampus yang memudahkan pencarian

🎯**Saatnya Wujudkan Masa Depanmu di Dunia Data!** Jangan lewatkan
kesempatan untuk memilih kampus terbaik yang sesuai dengan passion dan
karier impianmu. **Cek Statlink sekarang dan jadilah bagian dari
generasi ahli data masa depan! 🚀🌍**

## :desktop_computer: Palet Warna 

Salah satu elemen penting dalam desain adalah pemilihan warna yang tepat. Palet warna yang digunakan dalam StatLink dirancang untuk memberikan tampilan yang profesional, bersih, dan nyaman di mata pengguna.

<p align="center">
  <img width="800" height="650" src="images/StatLink Color 2.png">
</p>

Dengan kombinasi warna yang harmonis, StatLink diharapkan dapat memberikan pengalaman yang menyenangkan saat digunakan.

## :desktop_computer: User Flow 

Sebelum masuk ke tahap pengembangan, kami terlebih dahulu menentukan **alur pengguna (user flow)** untuk memahami bagaimana pengguna akan berinteraksi dengan aplikasi. 

<p align="center">
  <img width="900" height="550" src="images/StatLink Userflow 2.png">
</p>

Diagram ini membantu tim dalam merancang fitur yang lebih intuitif, memudahkan navigasi, dan mengoptimalkan pengalaman pengguna saat menggunakan StatLink.

## :desktop_computer: Wireframe

Tahap awal dalam pengembangan antarmuka adalah dengan membuat **wireframe**, yaitu rancangan sederhana yang menggambarkan tata letak dan elemen-elemen utama di aplikasi. 

<p align="center">
  <img width="900" height="650" src="images/StatLink Wireframe 1.png">
</p>

<p align="center">
  <img width="900" height="550" src="images/StatLink Wireframe 2.png">
</p>

## :desktop_computer: Alur Wireframe

Setelah wireframe dibuat, langkah berikutnya adalah menentukan **alur navigasi antar halaman**. Diagram ini menunjukkan bagaimana setiap halaman terhubung dan bagaimana pengguna akan berpindah dari satu bagian ke bagian lainnya dalam aplikasi 

<p align="center">
  <img width="900" height="650" src="images/StatLink Wireframe Flow - Beranda.png">
</p>

Dengan perancangan alur yang jelas, pengembangan aplikasi bisa berjalan lebih lancar dan efisien, serta memastikan pengguna mendapatkan pengalaman yang seamless saat menggunakan StatLink.

## :desktop_computer: Dashboard Database 

Berikut merupakan tampilan awal dari Portal StatHub Database

<p align="center">
  <img width="900" height="450" src="images/tampilan_dashboard.jpeg">
</p>

## :film_strip: Skema Database 

Struktur Primary Key dan Foreign Key digunakan untuk membangun hubungan
antara tabel Wilayah, Universitas, Program Studi, dan Jalur Masuk dalam
database. Relasi ini memastikan keterkaitan antar entitas sehingga data
dapat terorganisir dengan baik.

Berikut adalah skema database dari **Portal StatLink** : Database

<p align="center">
  <img width="600" height="400" src="images/Skema Database.png">
</p>

## :exclamation: Requirements 

-   Sistem RDBMS yang digunakan dalam proyek ini adalah PostgreSQL yang dijalankan     secara lokal menggunakan DBngin dan dikelola dengan TablePlus.
-   Pembuatan dashboard memanfaatkan beberapa package R, yaitu shiny,
    shinythemes, bs4Dash, DT, dan dplyr, untuk memastikan tampilan yang
    interaktif dan fungsional.

## :chart_with_downwards_trend: ERD 

ERD (Entity Relationship Diagram) menggambarkan hubungan antara entitas
dan atribut dalam sistem. Pada proyek ini, Wilayah memiliki atribut
id_wilayah, yang berelasi dengan entitas Universitas.

Selanjutnya, Universitas memiliki atribut id_univ, yang terhubung dengan
dua entitas lainnya, yaitu Prodi StatHub melalui id_univ dan Jalur Masuk
melalui id_univ.

Selain itu, Prodi StatHub juga berelasi dengan Jalur Masuk melalui
id_prodi, yang menunjukkan hubungan antara program studi dengan jalur
penerimaan mahasiswa.

<p align="center">
  <img width="600" height="500" src="images/ERD.png">
</p>

## :postbox: Deskripsi Data 

Statlink adalah portal database yang menyediakan informasi lengkap
mengenai universitas negeri di Indonesia yang memiliki jurusan
Statistika. Data yang ditampilkan bersumber dari PDDIKTI serta situs
resmi masing-masing universitas.

Informasi yang tersedia mencakup Universitas, Wilayah Universitas,
Program Studi (termasuk jumlah dosen dan mahasiswa), serta Jalur Masuk
yang dapat ditempuh untuk masuk ke jurusan Statistika di berbagai
perguruan tinggi.

Selain itu, Statlink juga menyediakan tabel-tabel yang digunakan dalam
sistem, lengkap dengan sintaks SQL DDL (CREATE) untuk pengelolaan
database.

### Create Database

Database STATLINK menyimpan informasi yang mewakili atribut data yang
saling berhubungan untuk kemudian dianalisis.

``` sql
tryCatch({
  dbExecute(con, glue("CREATE DATABASE IF NOT EXISTS {db_config$dbname}"))
  message("Database ", db_config$dbname, " berhasil dibuat/ditemukan")
 }, error = function(e) {
  message("Gagal membuat database: ", e$message)
 })
```

### Create Table Wilayah

Tabel Wilayah berisi informasi mengenai lokasi universitas, sehingga
pengguna dapat mengetahui ID Wilayah, Nama Kabupaten/Kota, serta Nama
Provinsi tempat universitas tersebut berada.

Berikut adalah deskripsi dari setiap atribut dalam tabel Wilayah:

| Attribute    | Type                   | Description   |
|:-------------|:-----------------------|:--------------|
| id_wilayah   | character varying(15)  | Id Wilayah    |
| nama_kabkota | character varying(100) | Nama Kab/Kota |
| nama_prov    | character varying(100) | Nama Provinsi |

dengan script SQL sebagai berikut:

``` sql
CREATE TABLE IF NOT EXISTS wilayah (
    id_wilayah CHAR(15) NOT NULL PRIMARY KEY,
    nama_kabkota VARCHAR(100) NOT NULL,
    nama_prov VARCHAR(100) NOT NULL
);

select * from wilayah
```

### Create Table Universitas

Tabel Universitas menyediakan informasi yang membantu pengguna dalam
mengidentifikasi universitas yang memiliki jurusan Statistika. Informasi
ini mencakup ID Universitas, ID Wilayah, Nama Universitas, serta
Akreditasi Universitas.

Berikut adalah deskripsi dari setiap atribut dalam tabel Universitas:

| Attribute  | Type                   | Description            |
|:-----------|:-----------------------|:-----------------------|
| id_univ    | integer                | Id Universitas         |
| id_wilayah | character varying(15)  | Id Wilayah             |
| nama_univ  | character varying(150) | Nama Universitas       |
| akred_univ | character varying(50)  | Akreditasi Universitas |
| QS_Rank    | character varying(50)  | QS Ranking             |
dengan script SQL sebagai berikut:

``` sql
CREATE TABLE IF NOT EXISTS Universitas (
      id_univ INT AUTO_INCREMENT PRIMARY KEY,
      id_wilayah VARCHAR(15) NOT NULL,
      nama_univ VARCHAR(150),
      akred_univ VARCHAR(50),
      qs_rank VARCHAR(50),
      FOREIGN KEY (id_wilayah) REFERENCES Wilayah(id_wilayah)
    )
```

### Create Table Prodi

Tabel Prodi menyediakan informasi mengenai program studi yang tersedia
di suatu universitas. Melalui tabel ini, pengguna dapat mengetahui ID
Program Studi, ID Universitas, Nama Program Studi, Jumlah Dosen, Jumlah
Mahasiswa, Akreditasi Program Studi, serta Jenjang Pendidikan.

Berikut adalah deskripsi dari setiap atribut dalam tabel Prodi:

| Attribute        | Type                   | Description        |
|:-----------------|:-----------------------|:-------------------|
| id_prodi         | integer                | Id prodi           |
| id_univ          | integer                | Id universitas     |
| nama_prodi       | character varying(150) | Nama program studi |
| jumlah_dosen     | integer                | Jumlah dosen       |
| jumlah_mahasiswa | integer                | Jumlah mahasiswa   |
| akred_prodi      | character varying(50)  | Akreditasi prodi   |
| jenjang          | character varying(10)  | Jenjang pendidikan |

dengan script SQL sebagai berikut:

``` sql
CREATE TABLE IF NOT EXISTS Prodi_StatHub (
      id_prodi INT AUTO_INCREMENT PRIMARY KEY,
      id_univ INT,
      nama_prodi VARCHAR(150),
      jumlah_dosen INT,
      jumlah_mahasiswa INT,
      akred_prodi VARCHAR(50),
      jenjang VARCHAR(10),
      FOREIGN KEY (id_univ) REFERENCES Universitas(id_univ)
    );
```

Penilaian Peringkat Akreditasi Program Studi berdasarkan:

a.  Unggul;

Predikat Unggul diberikan BAN-PT kepada perguruan tinggi yang mendapat
nilai akreditasi A dan memenuhi syarat masuk predikat Unggul atau strata
tertinggi dalam akreditasi.

b.  Baik Sekali;

Predikat Baik Sekali diberikan oleh BAN-PT kepada perguruan tinggi yang
mendapat nilai akreditasi A namun belum memenuhi seluruh syarat predikat
Unggul.

c.  Baik;

Predikat Baik diberikan kepadapa perguruan tinggi yang mencapai nilai
akreditasi B dengan nilai akreditasi di atas 200 poin.

d.  A;

Akreditasi A menunjukkan nilai akreditasi antara 361-400 poin.

e.  B; dan

Akreditasi B menunjukkan nilai akreditasi antara 301-360 poin.

f.  C;

Akreditasi C dengan nilai akreditasi antara 200-300 poin.

### Create Table Jalur

Tabel Jalur menyediakan informasi lengkap mengenai berbagai jalur masuk
bagi calon mahasiswa yang ingin mendaftar ke universitas pilihan mereka.
Selain informasi mengenai jalur penerimaan, pengguna juga dapat
mengetahui kapasitas daya tampung serta situs resmi pendaftaran
universitas.

Tabel ini mencakup informasi spesifik seperti id program studi, id
universitas, jenis jalur masuk, daya tampung, dan website pendaftaran.
Berikut adalah deskripsi untuk setiap atribut dalam tabel Jalur. 
| Attribute        | Type                   | Description    |
|:-----------------|:-----------------------|:---------------|
| id_univ          | integer                | Id Universitas |
| id_prodi         | integer                | Id Prodi       |
| website          | character varying(255) | Website        |	
| jalur_masuk      | character varying(100) | Jalur Masuk    |
| daya_tampung     | integer                | Daya Tampung   |


dengan script SQL sebagai berikut:

``` sql
CREATE TABLE IF NOT EXISTS Jalur_Masuk (
      id_prodi INT,
      id_univ INT,
      jalur_masuk VARCHAR(100),
      daya_tampung INT,
      website VARCHAR(255),
      FOREIGN KEY (id_prodi) REFERENCES Prodi_StatHub(id_prodi),
      FOREIGN KEY (id_univ) REFERENCES Universitas(id_univ)
    );
```

## :open_file_folder: Struktur Folder 

```         
.
├── Source       
│
├── App 
│   
├── Data
│   
├── Images     
| 
└── README.md
```

## :ninja: Tim Pengembang 

-   💃Database Manager : [Logananta Puja
    Kusuma](https://github.com/logankusuma) (M0501241028)
-   👩‍🍳Frontend Developer : [Mauizatun
    Hasanah](https://github.com/Mauizatunhasanah) (M0501241081)
-   👩‍🍳Backend Developer : [Destriana Aulia
    Rifaldi](https://github.com/destrianaaulia) (M0501241079)
-   🏄‍♀️Technical Writer : [Mahda Al Maida](https://github.com/mahdaalma)
    (M0501241088)
-   🏗 Database Designer : [Yani Prihantini
    Hola](https://github.com/yanihiola) (M0501241026)
