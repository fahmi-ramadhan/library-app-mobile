import 'package:flutter/material.dart';
import 'package:library_app/screens/bookshelf_form.dart';
import 'package:library_app/widgets/book_card.dart';
import 'package:library_app/widgets/left_drawer.dart';

class BookshelfPage extends StatefulWidget {
  const BookshelfPage({super.key});

  @override
  State<BookshelfPage> createState() => _BookshelfPageState();
}

class _BookshelfPageState extends State<BookshelfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Bookshelf',
          ),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return BookCard(books[index]);
        },
      ),
    );
  }
}

class Book {
  final String title;
  final String author;
  final String category;
  final int amount;
  final String description;

  Book(
      {required this.title,
      required this.author,
      required this.category,
      required this.amount,
      required this.description});
}
