# Library Management System Mobile

Nama: Fahmi Ramadhan<br>
NPM: 2206026473<br>
Kelas: PBP A<br>

# Tugas 8: Flutter Navigation, Layouts, Forms, and Input Elements

<details open>

## Jelaskan perbedaan antara `Navigator.push()` dan `Navigator.pushReplacement()`, disertai dengan contoh mengenai penggunaan kedua method tersebut yang tepat!

`Navigator.push()` digunakan untuk menavigasi ke halaman baru dan menambahkannya ke _navigation stack_. Halaman sebelumnya tetap ada di _stack_, jadi jika pengguna menekan tombol kembali, mereka akan kembali ke halaman sebelumnya. Contoh penggunaannya:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const BookshelfFormPage()
  ),
);
```

Sementara itu, `navigator.pushReplacement()` digunakan untuk menavigasi ke halaman baru dengan menggantikan halaman saat ini di _stack_ dengan halaman baru. Jadi, jika pengguna menekan tombol kembali, mereka tidak akan kembali ke halaman sebelumnya karena halaman tersebut sudah digantikan. Contoh penggunaannya:
```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => const BookshelfFormPage(),
  ),
);
```

## Jelaskan masing-masing _layout widget_ pada Flutter dan konteks penggunaannya masing-masing!

1. _Single-child layout widgets_ (Hanya dapat memiliki satu _child widget_ di dalamnya, digunakan untuk mengelola tata letak untuk satu _widget_)

- `Align` : sebuah _widget_ yang digunakan untuk melakukan _alignment_ pada _child_-nya terhadap dirinya sendiri.
- `AspectRatio` : sebuah _widget_ yang digunakan untuk mengatur ukuran _child_-nya dengan suatu aspek rasio tertentu.
- `Baseline` : _widget_ yang memposisikan _child_-nya berdasarkan _baseline_ dari _child_ tersebut.
- `Center` : _Alignment block_ yang memposisikan _child_-nya di tengah-tengah dirinya sendiri secara horizontal dan vertikal
- `ConstrainedBox` : sebuah _widget_ yang memberikan _constraints_ tambahan pada _child_-nya.
- `Container` : _wrapper widget_ yang menggabungkan widget umum untuk _painting_, _positioning_, dan _sizing_ pada _children_-nya.
- dll.

2. _Multi-child layout widgets_ (Dapat memiliki lebih dari satu _child widget_ di dalamnya, digunakan untuk mengelola tata letak beberapa _widget_)

- `Row` : _widget_ yang menampilkan _child_-nya dalam urutan horizontal.
- `Column` : _widget_ yang menampilkan _child_-nya dalam urutan vertikal.
- `GridView` : _widget_ yang menampilkan _child_-nya dalam grid dua dimensi.
- `Flow` : _widget_ yang mengimplementasikan algoritma _flow layout_.
- dll.


3. _Sliver widgets_ (Digunakan untuk menciptakan efek _scroll_ yang kustom dan lazim digunakan dalam `CustomScrollView`)

- `SliverAppBar` : sebuah `AppBar` yang dapat berubah ukurannya saat pengguna melakukan _scroll_. Biasanya digunakan untuk membuat efek _collapsing toolbar_.
- `SliverList` dan `SliverGrid` : Digunakan untuk menampilkan _list_ atau _grid_ yang dapat di-_scroll_.
- `SliverToBoxAdapter`: _widget_ yang memungkinkan kita untuk menempatkan _widget_ biasa (box) di dalam `CustomScrollView`.
- dll.


## Sebutkan apa saja elemen input pada _form_ yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!

Pada tugas kali ini, saya menggunakan 5 `TextFormField` untuk mendapatkan input berupa judul buku, penulis, kategori, jumlah, dan deskripsi. `TextFormField` digunakan karena input yang diterima hanya berupa teks atau angka (untuk angka, dilakukan validasi dengan mengecek apakah `int.tryParse(value)` bernilai null) 

## Bagaimana penerapan _clean architecture_ pada aplikasi Flutter?

Penerapan _clean architecture_ pada aplikasi Flutter biasanya melibatkan pemisahan kode menjadi tiga lapisan: Presentation, Domain, dan Data.

1. Presentation Layer: berisi kode yang berinteraksi langsung dengan pengguna, termasuk _widget_ dan _state management_.

2. Domain Layer: berisi entitas bisnis dan logika bisnis (_use cases_). Entitas adalah objek sederhana yang mewakili data yang relevan untuk aplikasi. _Use cases_ mewakili semua tindakan yang dapat dilakukan pengguna dalam aplikasi.

3. Data Layer: berisi kode yang berinteraksi dengan sumber data, seperti API dan database. Ini biasanya termasuk _repository_ dan _data source_.

Contoh struktur direktori:

```
lib/
|- presentation/
|  |- pages/
|  |- widgets/
|  |- blocs/ or providers/
|- domain/
|  |- entities/
|  |- use_cases/
|- data/
|  |- repositories/
|  |- data_sources/
```

## Implementasi _checklist_

### 1. Membuat minimal satu halaman baru pada aplikasi, yaitu halaman formulir tambah item baru.

### 2. Mengarahkan pengguna ke halaman form tambah item baru ketika menekan tombol `Tambah Item` pada halaman utama.

### 3. Memunculkan data sesuai isi dari formulir yang diisi dalam sebuah `pop-up` setelah menekan tombol Save pada halaman formulir tambah item baru.

### 4. Membuat sebuah drawer pada aplikasi.

</details>

# Tugas 7: Elemen Dasar Flutter

<details>

## Apa perbedaan utama antara _stateless_ dan _stateful widget_ dalam konteks pengembangan aplikasi Flutter?

- _**Stateless widget**_ adalah sebuah _widget_ yang di-_build_ hanya dengan konfigurasi awal yang telah diinisiasi sejak awal. _Stateless widget_ tidak memiliki _state_ internal yang dapat berubah selama masa hidupnya. Contoh dari _stateless widget_ adalah `Text` dan `Icon`.

- _**Stateful widget**_ adalah sebuah _widget_ yang memiliki objek _state_ yang menyimpan sebuah informasi yang dapat berubah-ubah. _Stateful widget_ dapat merubah tampilan karena bersifat _mutable_ dan dapat di-_render_ ulang berkali kali selama masa hidupnya. Contoh dari _stateful widget_ adalah `Checkbox`, `Slider`, dan `TextField`.

## Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.

1. `MaterialApp`: Widget tingkat atas untuk aplikasi Material Design yang menyediakan konfigurasi seperti tema, navigasi, dan judul aplikasi.
2. `ThemeData`: Widget untuk mengonfigurasi tema global untuk aplikasi Material.
3. `ColorScheme`: Widget untuk mengatur skema warna yang digunakan oleh aplikasi.
4. `MyApp`: Root widget aplikasi yang me-_return_ `MaterialApp` widget.
5. `MyHomePage`: Widget kustom sebagai halaman utama aplikasi.
6. `Scaffold`: Widget yang menyediakan struktur visual dasar untuk aplikasi Material Design.
7. `AppBar`: Widget yang menampilkan bar aplikasi di bagian atas `Scaffold`.
8. `Text`: Widget yang menampilkan baris teks sederhana.
9. `SignleChildScrollView`: Widget _wrapper_ yang dapat di-_scroll_ jika _child_-nya melebihi layar.
10. `Padding`: Widget yang memberikan padding ke _child_-nya.
11. `Column`: Widget yang menampilkan _child_-nya dalam urutan vertikal.
12. `GridView.count`: Widget yang menampilkan _child_-nya dengan jumlah kolom tetap.
13. `ItemCard`: Widget kustom untuk menampilkan item.
14. `Material`: Widget yang memberikan efek visual Material Design.
15. `InkWell`: Widget berupa area responsif terhadap sentuhan.
16. `Container`: Widget _wrapper_ yang menggabungkan widget umum untuk _painting_, _positioning_, dan _sizing_ pada _children_-nya.
17. `Center`: Widget yang membuat _child_-nya berada di tengah.
18. `Icon`: Widget yang menampilkan ikon Material Design.
19. `SnackBar`: Widget yang menampilkan pesan ringan di bagian bawah layar.

## Implementasi _Checklist_

### 1. Membuat sebuah program Flutter baru dengan tema inventory seperti tugas-tugas sebelumnya.

- Membuat proyek Flutter baru dengan menjalankan perintah `flutter create library_app` kemudian membuka direktori proyek tersebut di dalam Visual Studio Code.

- Menghapus _widget_ `MyHomePage` dan class _state_-nya dari `main.dart` kemudian membuat _stateless widget_ bernama `MyHomePage` di dalam berkas baru bernama `menu.dart`.

```dart
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ...
    );
  }
}
```

### 2. Membuat tiga tombol sederhana dengan ikon dan teks untuk melihat daftar item, menambah item, dan logout.

- Menambahkan class `Item` dan stateless widget `ItemCard` pada `menu.dart`. Class `Item` memiliki atribut name, icon, dan color (**BONUS**)

```dart
class Item {
  final String name;
  final IconData icon;
  final Color color;

  Item(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

- Melakukan modifikasi pada widget `MyHomePage` dengan membuat _item_ tombol dan mengisi _widget_ `Scaffold` untuk menampilkan `AppBar` dan tiga tombol untuk melihat daftar item, menambah item, dan logout. Setiap tombol diberi warna yang berbeda (**BONUS**).

```dart
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<Item> items = [
    Item("Lihat Item", Icons.checklist, Colors.teal.shade700),
    Item("Tambah Item", Icons.add_circle_outline, Colors.teal.shade800),
    Item("Logout", Icons.logout, Colors.teal.shade900),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          style: TextStyle(color: Colors.white),
          'Library Management System',
        ),
      ),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Bookshelf', // Text yang menandakan bookshelf
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((Item item) {
                  // Iterasi untuk setiap item
                  return ItemCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 3. Memunculkan snackbar ketika suatu tombol ditekan.

- Melakukan modifikasi pada _widget_ `InkWell` dengan menambahkan _property_ `onTap`.

```dart
class ItemCard extends StatelessWidget {
  ...
  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        },
        ...
      ),
    );
  }
}
```

</details>