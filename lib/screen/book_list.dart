import 'package:flutter/material.dart';
import 'dart:convert';
import '../model/book.dart';
import '../widget/book_details.dart';
import '../data/book_data.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  BookListState createState() => BookListState();
}

class BookListState extends State<BookList> {
  List<Book> allBooks = [];
  List<Book> displayedBooks = [];
  final TextEditingController queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  void loadBooks() {
    List<dynamic> parsedJson = jsonDecode(libraryData);
    allBooks = parsedJson.map((json) => Book.fromJson(json)).toList();
    displayedBooks = allBooks;
  }

  void searchBooks(String searchTerm) {
    setState(() {
      displayedBooks = allBooks.where((book) {
        final bookTitle = book.title.toLowerCase();
        final searchQuery = searchTerm.toLowerCase();
        return bookTitle.contains(searchQuery);
      }).toList();
    });
  }

  void openBookDetails(BuildContext context, Book selectedBook) {
    showDialog(
      context: context,
      builder: (context) => BookInfo(literature: selectedBook),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Book Library",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          buildSearchField(),
          buildBookList(),
        ],
      ),
    );
  }

  Widget buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: queryController,
        decoration: InputDecoration(
          hintText: "Search for books...",
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onChanged: searchBooks,
      ),
    );
  }

  Widget buildBookList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: displayedBooks.length,
        itemBuilder: (context, index) {
          final currentBook = displayedBooks[index];
          return buildBookCard(currentBook);
        },
      ),
    );
  }

  Widget buildBookCard(Book currentBook) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () => openBookDetails(context, currentBook),
        child: Container(
          height: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade50, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              buildBookImage(currentBook),
              buildBookInfo(currentBook),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBookImage(Book currentBook) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
      child: Image.network(
        currentBook.imageUrl,
        width: 160,
        height: 240,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 160,
            height: 240,
            color: Colors.grey[300],
            child: const Icon(Icons.image_not_supported),
          );
        },
      ),
    );
  }

  Widget buildBookInfo(Book currentBook) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentBook.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              "By ${currentBook.author.name}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                currentBook.body,
                style: const TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}