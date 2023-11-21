# Library Management System Mobile

Nama: Fahmi Ramadhan<br>
NPM: 2206026473<br>
Kelas: PBP A<br>

# Tugas 9: Integrasi Layanan Web Django dengan Aplikasi Flutter

<details open>

## Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?

Ya, kita dapat mengambil data JSON tanpa membuat model terlebih dahulu, misalnya dengan menyimpan data-data JSON tersebut di dalam map. Namun, hal tersebut tidak lebih baik daripada membuat model sebelum melakukan pengambilan data JSON karena akan lebih rumit dan menurunkan tingkat _readability_ kode. Dengan membuat model, kode akan lebih teratur dan terabstraksi, yang mana itu adalah manfaat dari OOP.

## Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

`CookieRequest` adalah sebuah kelas yang digunakan untuk mengelola HTTP request dan cookie yang terkait dengan request tersebut. Kelas ini memiliki beberapa method untuk melakukan operasi seperti `login`, `get`, `post`, dan `logout`.

_Instance_ `CookieRequest` perlu dibagikan ke semua komponen di aplikasi Flutter agar semua komponen dalam aplikasi dapat melakukan HTTP request yang terotentikasi dan semua komponen akan memiliki akses ke data pengguna yang sama. 

Misalnya, pada tugas kali ini, _Instance_ `CookieRequest` dibagikan ke semua komponen melalui `Provider` dan diakses di `BookshelfFormPage` dengan `context.watch<CookieRequest>()` untuk melakukan permintaan HTTP POST ke server untuk mengirimkan data buku baru ke server saat tombol "save" ditekan.

## Jelaskan mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter.

Berikut adalah mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada tugas kali ini.

1. Fungsi `fetchItem` membuat permintaan HTTP GET ke URL yang ditentukan. Ini dilakukan secara asinkron menggunakan `http.get`.

```dart
var url = Uri.parse('http://fahmi-ramadhan21-tugas.pbp.cs.ui.ac.id/json/');
var response = await http.get(
  url,
  headers: {"Content-Type": "application/json"},
);
```

2. Respons dari server kemudian di-_decode_ menjadi bentuk JSON menggunakan `jsonDecode`.

```dart
var data = jsonDecode(utf8.decode(response.bodyBytes));
```

3. Data JSON kemudian di-_convert_ menjadi objek `Book` menggunakan method `formJson` yang didefinisikan dalam kelas `Book` yang kemudian objek-objek tersebut ditambahkan ke dalam `listBook`.

```dart
List<Book> listBook = [];
for (var d in data) {
  if (d != null) {
    listBook.add(Book.fromJson(d));
  }
}
```

4. Dalam method `build`, `FutureBuilder` digunakan untuk menunggu `fetchItem` selesai dan membangun UI berdasarkan hasilnya. Jika data masih dimuat, `CircularProgressIndicator` ditampilkan. Jika data telah dimuat, `ListView.builder` digunakan untuk membuat daftar buku.

## Jelaskan mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.

Berikut adalah mekanisme autentikasi pada tugas kali ini.

1. Pengguna memasukkan _username_ dan _password_ melalui dua `TextField`.

2. Aplikasi kemudian membuat permintaan HTTP POST ke _endpoint_ _login_ Django menggunakan `CookieRequest`. Data _username_ dan _password_ dikirimkan sebagai bagian dari _body request_.

```dart
final response = await request.login(
  "http://fahmi-ramadhan21-tugas.pbp.cs.ui.ac.id/auth/login/",
  {
    'username': username,
    'password': password,
  }
);
```

3. Django memproses permintaan login, memeriksa apakah _username_ dan _password_ valid, dan mengirimkan respons. Respons ini kemudian diterima oleh aplikasi Flutter dan Flutter dan diperiksa. Jika login berhasil (`request.loggedIn` adalah `true`), aplikasi navigasi ke `MyHomePage` dan menampilkan pesan selamat datang. Jika login gagal, aplikasi menampilkan pesan kesalahan.

## Sebutkan seluruh widget yang kamu pakai pada tugas ini dan jelaskan fungsinya masing-masing.

- `AlertDialog` : untuk menampilkan dialog peringatan atau pesan ke pengguna.
- `TextButton` : untuk menampilkan tombol dengan teks.
- `TextField` : untuk menerima input teks dari pengguna.
- `InputDecoration` : untuk mendefinisikan penampilan dan gaya dari `TextField`.
- `SizedBox` : untuk memberikan jarak antara dua widget.
- `ElevatedButton` : untuk menampilkan tombol.
- `Navigator` : untuk mengelola stack rute dalam aplikasi.
- `MaterialPageRoute` : untuk menyediakan efek transisi saat berpindah antar halaman.
- `FloatingActionButton` : untuk menampilkan tombol aksi yang mengambang, pada tugas ini digunakan untuk tombol kembali.
- `CircularProgressIndicator` : untuk menampilkan indikator loading.
- `ListView.builder` : untuk membuat list yang efisien dengan item yang di-_build_ saat mereka diputar ke dalam tampilan.
- `GestureDetector` : untuk mendeteksi gestur, pada tugas ini digunakan untuk mendeteksi ketuka pada item `ListView`.
- `FutureBuilder` : untuk membuat widget berdasarkan hasil Future, pada tugas ini dugunakan untuk membangun `ListView` berdasarkan hasil dari `fetchItem()`.
- `Provider` : untuk menyediakan objek yang dapat dibaca oleh widget lain yang berada di bawahnya di widget tree, pada tugas ini digunakan untuk menyediakan _instance_ `CookieRequest` ke widget lain.
- `LoginPage` : widget kustom untuk menampilkan halaman login.
- `BookshelfPage` : widget kuston umtuk menampilkan halaman _bookshelf_ (daftar buku).
- `BookDetailPage` : widget kustom untuk menampilkan halaman detail buku.
- `ScaffoldMessenger` : untuk menampilkan `SnackBar`.

## Implementasi _Checklist_

### 1. Memastikan deployment proyek tugas Django kamu telah berjalan dengan baik.

- Melakukan _push_ ulang dengan memberikan sedikit perbedaan pada kode aplikasi untuk mengatasi masalah _blue screen_ saat membuka _web app_.

### 2. Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter.

- Membuat `django-app` baru bernama `authentication` dan menambahkannya ke `INSTALLED_APPS` di `settings.py` aplikasi Django.
- Menginstall `django-cors-headers` dan menambahkannya ke `INSTALLED_APPS` dan `requirements.txt`, serta menambahkan `corsheaders.middleware.CorsMiddleware` ke `MIDDLEWARE` di `settings.py`
- Menambahkan beberapa konfigurasi berikut ke `settings.py`:
```python
CORS_ALLOW_ALL_ORIGINS = True
CORS_ALLOW_CREDENTIALS = True
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SAMESITE = 'None'
SESSION_COOKIE_SAMESITE = 'None'
SECURE_CROSS_ORIGIN_OPENER_POLICY = 'None'
```
- Membuat _method view_ untuk login dan logout pada `authentication/views.py` 
```python
@csrf_exempt
def login(request):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(username=username, password=password)
    if user is not None:
        if user.is_active:
            auth_login(request, user)
            return JsonResponse({
                "username": user.username,
                "status": True,
                "message": "Login sukses!"
            }, status=200)
        else:
            return JsonResponse({
                "status": False,
                "message": "Login gagal, akun dinonaktifkan."
            }, status=401)

    else:
        return JsonResponse({
            "status": False,
            "message": "Login gagal, periksa kembali email atau kata sandi."
        }, status=401)

@csrf_exempt
def logout(request):
    username = request.user.username

    try:
        auth_logout(request)
        return JsonResponse({
            "username": username,
            "status": True,
            "message": "Logout berhasil!"
        }, status=200)
    except:
        return JsonResponse({
        "status": False,
        "message": "Logout gagal."
        }, status=401)
```
- Membuat berkas `urls.py` pada direktori `authentication` dan menambahkan URL _routing_ terhadap _method view_ yang sudah dibuat.
```python
from django.urls import path
from authentication.views import login, logout

app_name = 'authentication'

urlpatterns = [
    path('login/', login, name='login'),
    path('logout/', logout, name='logout'),
]
```
- Menambahkan `path('auth/', include('authentication.urls')),` pada berkas `library_app/urls.py`


### 3. Membuat halaman login pada proyek tugas Flutter.

- Meng-_install_ _package_ Flutter untuk melakukan kontak dengan _web service Django_ dengan menjalankan perintah `flutter pub add provider` dan `flutter pub add pbp_django_auth`
- Memodifikasi _root widget_ untuk menyediakan `CookieRequest` _library_ ke semua _child widgets_ dengan menggunakan `Provider`.

Hasil modifikasi:
```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Library Management System',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: LoginPage(),
      ),
    );
  }
}
```
- Membuat berkas `login.dart` pada folder `screens` dan mengisinya dengan kode berikut:
```dart
import 'package:library_app/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text;
                String password = _passwordController.text;
                final response =
                    await request.login(
                        "http://fahmi-ramadhan21-tugas.pbp.cs.ui.ac.id/auth/login/",
                        {
                      'username': username,
                      'password': password,
                    });

                if (request.loggedIn) {
                  String message = response['message'];
                  String uname = response['username'];
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        content: Text("$message Selamat datang, $uname.")));
                } else {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Login Gagal'),
                      content: Text(response['message']),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
``` 

- Mengubah konfigurasi `home` pada _Widget_ `MaterialApp` di berkas `main.dart` dari `home: MyHomePage()` menjadi `home: LoginPage()`.
- Mengimplementasikan fitur _logout_ dengan menambahkan kode berikut pada `menu_card.dart`
```dart
class MenuCard extends StatelessWidget {
  ...
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    ...
        // Area responsive terhadap sentuhan
        onTap: () async {
          ...
          else if (menuItem.name == "Logout") {
            final response = await request.logout(
                "http://fahmi-ramadhan21-tugas.pbp.cs.ui.ac.id/auth/logout/");
            String message = response["message"];
            if (response['status']) {
              String uname = response["username"];
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message Sampai jumpa, $uname."),
              ));
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            } else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message),
              ));
            }
          }
        },
    ...
  }
}
```

### 4. Membuat model kustom sesuai dengan proyek aplikasi Django.

- Memanfaatkan [Quicktype](https://app.quicktype.io/) untuk membuat model dengan data JSON dari [`http://fahmi-ramadhan21-tugas.pbp.cs.ui.ac.id/json/`](http://fahmi-ramadhan21-tugas.pbp.cs.ui.ac.id/json/).
- Membuat berkas baru bernama `book.dart` pada direktori `lib/models` dan mengisinya dengan kode model dari [Quicktype](https://app.quicktype.io/) tadi.

### 5. Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah kamu deploy.

- Menambahkan _package_ [`http`](https://pub.dev/packages/http) dengan menjalankan perintah `flutter pub add http`.
- Menambahkan kode `<uses-permission android:name="android.permission.INTERNET" />` pada berkas `android/app/src/main/AndroidManifest.xml` untuk memperbolehkan akses internet pada aplikasi Flutter.
- Membuat berkas baru bernama `bookshelf.dart` pada direktori `lib/screens` dan mengisinya dengan kode berikut:
```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:library_app/models/book.dart';
import 'package:library_app/widgets/left_drawer.dart';

class BookshelfPage extends StatefulWidget {
  final bool openedThroughDrawer;

  const BookshelfPage({Key? key, this.openedThroughDrawer = false})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookshelfPageState createState() => _BookshelfPageState();
}

class _BookshelfPageState extends State<BookshelfPage> {
  Future<List<Book>> fetchItem() async {
    var url = Uri.parse('http://fahmi-ramadhan21-tugas.pbp.cs.ui.ac.id/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Book
    List<Book> listBook = [];
    for (var d in data) {
      if (d != null) {
        listBook.add(Book.fromJson(d));
      }
    }
    return listBook;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bookshelf',
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      drawer: widget.openedThroughDrawer ? const LeftDrawer() : null,
      body: FutureBuilder(
        future: fetchProduct(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Tidak ada data produk.",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${snapshot.data![index].fields.name}",
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "by ${snapshot.data![index].fields.author}",
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Category: ${snapshot.data![index].fields.category}",
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Amount: ${snapshot.data![index].fields.amount}",
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Description: ${snapshot.data![index].fields.description}",
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
```

- Menambahkan halaman `bookshelf.dart` ke `widgets/left_drawer.dart` dengan menambahkan kode berikut:
```dart
...
ListTile(
  leading: const Icon(Icons.checklist),
  title: const Text('Lihat Item'),
  // Bagian redirection ke BookshelfPage
  onTap: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const BookshelfPage(openedThroughDrawer: true),
      ),
    );
  },
),
...
```

- Mengubah fungsi tombol `Lihat Item` pada halaman utama agar mengarahkan ke halaman `BookshelfPage` dengan menambahkan kode berikut pada `widgets/menu_card.dart`: 
```dart
...
else if (menuItem.name == "Lihat Item") {
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const BookshelfPage()),
);
...
```

#### Melakukan integrasi _form_ Flutter dengan Layanan Django

- Membuat fungsi _view_ baru pada `main/views.py` aplikasi Django dan menambahkan _path_-nya pada `main/urls.py`: `path('create-flutter/', create_product_flutter, name='create_product_flutter'),`
```python
@csrf_exempt
def create_item_flutter(request):
    if request.method == 'POST':
        
        data = json.loads(request.body)

        new_item = Item.objects.create(
            user = request.user,
            name = data["name"],
            author = data["author"],
            category = data["category"],
            amount = int(data["amount"]),
            description = data["description"]
        )

        new_item.save()

        return JsonResponse({"status": "success"}, status=200)
    else:
        return JsonResponse({"status": "error"}, status=401)
```

- Menghubungkan halaman `bookshelf_form.dart` dengan `CookieRequest` dengan menambahkan `final request = context.watch<CookieRequest>();` pada `_BookshelfFormPageState` kemudian memodifikasi perintah `onPressed: ()` menjadi seperti berikut:
```dart
...
onPressed: () async {
  if (_formKey.currentState!.validate()) {
    // Kirim ke Django dan tunggu respons
    final response = await request.postJson(
        "http://fahmi-ramadhan21-tugas.pbp.cs.ui.ac.id/create-flutter/",
        jsonEncode(<String, String>{
          'name': _name,
          'author': _author,
          'category': _category,
          'amount': _amount.toString(),
          'description': _description,
        }));
    if (response['status'] == 'success') {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text("Produk baru berhasil disimpan!"),
      ));
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage()),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text(
            "Terdapat kesalahan, silakan coba lagi."),
      ));
    }
  }
},
...
```

### 6. Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar Item.

- Membuat berkas baru bernama `book_detail.dart` pada direktori `lib/screens` dan mengisinya dengan kode berikut:

```dart
import 'package:flutter/material.dart';
import 'package:library_app/models/book.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Detail',
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              book.fields.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            Text(
              'by ${book.fields.author}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Category: ${book.fields.category}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Amount: ${book.fields.amount}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Description: ${book.fields.description}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
```

- Mengimport halaman `BookDetailPage` ke `bookshelf.dart` dan melakukan modifikasi pada berkas `bookshelf.dart` dengan menambahkan `onTap` pada setiap _item_ buku.

```dart
...
return ListView.builder(
  itemCount: snapshot.data!.length,
  itemBuilder: (_, index) => GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BookDetailPage(book: snapshot.data![index]),
        ),
      );
    },
    child: Container(
      ...
    ),
  ),
);
...
```

</details>

# Tugas 8: Flutter Navigation, Layouts, Forms, and Input Elements

<details>

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

Penerapan _clean architecture_ pada aplikasi Flutter biasanya melibatkan pemisahan kode menjadi tiga _layer_: Presentation, Domain, dan Data.

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

### 1. Membuat sebuah drawer pada aplikasi.

Pertama-tama, saya membuat sebuah _stateless widget_ baru bernama `LeftDrawer` pada sebuah berkas baru `left_drawer.dart` di direktori baru `widgets`.

```dart
class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            child: Column(
              children: [
                Text(
                  'Library Management System',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Kelola bukumu dengan mudah di sini!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Tambah Item'),
            // Bagian redirection ke BookshelfPage
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookshelfFormPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
```

Selanjutnya, saya menambahkan konfigurasi drawer pada _widget_ `MyHomePage` di berkas `menu.dart`.

```dart
class MyHomePage extends StatelessWidget {
  ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ...
      ),
      drawer: LeftDrawer(),
      body: SingleChildScrollView(
        ...
      ),
    );
  }
}
```

### 2. Mengarahkan pengguna ke halaman form tambah item baru ketika menekan tombol `Tambah Item` pada halaman utama.

Selanjutnya, pada _widget_ `ItemCard` di berkas `item_card.dart`, saya menambahkan kode untuk navigasi ke halaman _form_ tambah _item_ ketika tombol `Tambah Item` ditekan.

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
          ...
          // Navigate ke route yang sesuai (tergantung jenis tombol)
          if (item.name == "Tambah Item") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const BookshelfFormPage()),
            );
          }
        },
        ...
      ),
    );
  }
}
```

### 3. Membuat minimal satu halaman baru pada aplikasi, yaitu halaman formulir tambah item baru.

Pada tahap ini, saya membuat sebuah _stateful widget_ `BookshelfFormPage` pada berkas `bookshelf_form.dart`.

```dart
class BookshelfFormPage extends StatefulWidget {
  const BookshelfFormPage({super.key});

  @override
  State<BookshelfFormPage> createState() => _BookshelfFormPageState();
}
```

Selanjutnya, saya membuat _class state_-nya untuk _widget_ `BookshelfFormPage` yang menyimpan data judul, penulis, kategori, jumlah, dan deskripsi buku.

```dart
class _BookshelfFormPageState extends State<BookshelfFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _author = "";
  String _category = "";
  int _amount = 0;
  String _description = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Tambah Buku',
          ),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(),
        ),
      ),
    );
  }
}
```

Selanjutnya, `Column()` diisi dengan beberapa _input field_ pada _form_.

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Judul Buku",
          labelText: "Judul Buku",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: (String? value) {
          setState(() {
            _name = value!;
          });
        },
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "Judul buku tidak boleh kosong!";
          }
          return null;
        },
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Penulis",
          labelText: "Penulis",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: (String? value) {
          setState(() {
            _author = value!;
          });
        },
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "Penulis tidak boleh kosong!";
          }
          return null;
        },
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Kategori",
          labelText: "Kategori",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: (String? value) {
          setState(() {
            _category = value!;
          });
        },
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "Kategori tidak boleh kosong!";
          }
          return null;
        },
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Jumlah",
          labelText: "Jumlah",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: (String? value) {
          setState(() {
            _amount = int.parse(value!);
          });
        },
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "Jumlah tidak boleh kosong!";
          }
          if (int.tryParse(value) == null) {
            return "Jumlah harus berupa angka!";
          }
          return null;
        },
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Deskripsi",
          labelText: "Deskripsi",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: (String? value) {
          setState(() {
            _description = value!;
          });
        },
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "Deskripsi tidak boleh kosong!";
          }
          return null;
        },
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.teal),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Item berhasil tersimpan"),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text('Judul: $_name'),
                            Text('Penulis: $_author'),
                            Text('Kategori: $_category'),
                            Text('Jumlah: $_amount'),
                            Text('Deskripsi: $_description'),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
                _formKey.currentState!.reset();
              }
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ),
  ],
),
```

### 4. Memunculkan data sesuai isi dari formulir yang diisi dalam sebuah `pop-up` setelah menekan tombol Save pada halaman formulir tambah item baru.

Menambahkan _children_ baru pada _widget_ `Column()` untuk tombol _save_.

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    ...
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.teal),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Item berhasil tersimpan"),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text('Judul: $_name'),
                            Text('Penulis: $_author'),
                            Text('Kategori: $_category'),
                            Text('Jumlah: $_amount'),
                            Text('Deskripsi: $_description'),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
                _formKey.currentState!.reset();
              }
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ),
  ],
),
```

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