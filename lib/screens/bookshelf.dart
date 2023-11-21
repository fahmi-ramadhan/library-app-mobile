import 'package:flutter/material.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/screens/book_detail.dart';
import 'package:library_app/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookshelfPage extends StatefulWidget {
  final bool openedThroughDrawer;

  const BookshelfPage({Key? key, this.openedThroughDrawer = false})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookshelfPageState createState() => _BookshelfPageState();
}

class _BookshelfPageState extends State<BookshelfPage> {
  Future<List<Book>> fetchItem(request) async {
    var data = await request
        .get('https://fahmi-ramadhan21-tugas.pbp.cs.ui.ac.id/get-item/');

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
    final request = context.watch<CookieRequest>();
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
        future: fetchItem(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "Tidak ada data buku.",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              );
            } else {
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
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
                        Text(
                          "by ${snapshot.data![index].fields.author}",
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Amount: ${snapshot.data![index].fields.amount}",
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
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
