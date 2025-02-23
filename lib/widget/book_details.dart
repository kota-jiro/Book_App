import 'package:flutter/material.dart';
import '../model/book.dart';

class BookInfo extends StatelessWidget {
  final Book literature;

  const BookInfo({super.key, required this.literature});

  @override
  Widget build(BuildContext buildContext) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Book Image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  literature.imageUrl,
                  width: 140,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, trace) {
                    return Container(
                      width: 140,
                      height: 200,
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.broken_image,
                        size: 60,
                        color: Colors.redAccent,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Book Title
            Text(
              literature.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Author Name
            Text(
              "By: ${literature.author.name}",
              style: const TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
            ),
            Text(
              "Email: ${literature.author.email}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),

            // Book Description
            Text(
              literature.body,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20),

            // Divider
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              height: 20,
            ),

            // Close Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(buildContext),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 5,
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}