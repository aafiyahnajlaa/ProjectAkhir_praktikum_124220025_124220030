import 'package:flutter/material.dart';

class BookmarksPage extends StatelessWidget {
  final Set<String> bookmarkedBooks;

  BookmarksPage({required this.bookmarkedBooks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Books'),
      ),
      body: bookmarkedBooks.isEmpty
          ? const Center(child: Text('No books bookmarked yet!'))
          : ListView.builder(
              itemCount: bookmarkedBooks.length,
              itemBuilder: (context, index) {
                String bookKey = bookmarkedBooks.elementAt(index);
                return ListTile(
                  title: Text('Book $bookKey'), // Display the book's info here
                  subtitle: const Text('This is a bookmarked book'),
                );
              },
            ),
    );
  }
}
