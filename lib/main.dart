import 'package:flutter/material.dart';
import 'screen/book_list.dart';

void main() {
  runApp(const BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Book List',
      debugShowCheckedModeBanner: false, 
      home: BookList(),
    );
  }
}