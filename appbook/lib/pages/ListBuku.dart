import 'dart:convert';
import 'package:appbook/pages/bookmark.dart';
import 'package:appbook/pages/bookmark.dart'; // Import halaman Bookmark
import 'package:appbook/pages/ulasan_ratting.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'MyDetailsBooks.dart'; // Impor halaman BookDetailsPage

class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<dynamic> bookData = [];
  Set<String> bookmarkedBooks =
      Set<String>(); // Set untuk menyimpan buku yang disukai

  @override
  void initState() {
    super.initState();
    fetchBookData();
  }

  void fetchBookData() async {
    final response = await http.get(Uri.parse(
        'https://openlibrary.org/people/mekBot/books/want-to-read.json'));
    if (response.statusCode == 200) {
      setState(() {
        bookData = jsonDecode(response.body)['reading_log_entries'];
      });
    } else {
      print('Error fetching book data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Book List'),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // Navigasi ke halaman bookmark
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BookmarksPage(bookmarkedBooks: bookmarkedBooks),
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: bookData.length,
        itemBuilder: (context, index) {
          final book = bookData[index]['work'];
          final coverUrl = book['cover_edition_key'] != null
              ? 'https://covers.openlibrary.org/b/olid/${book['cover_edition_key']}-M.jpg'
              : 'https://via.placeholder.com/300x400?text=No+Cover';

          bool isBookmarked = bookmarkedBooks
              .contains(book['key']); // Cek apakah buku sudah disukai

          return GestureDetector(
            onTap: () {
              // Navigasi ke halaman detail buku
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailsPage(bookKey: book['key']),
                ),
              );
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      coverUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          book['author_names'].join(', '),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'First published: ${book['first_publish_year']}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        IconButton(
                          icon: Icon(
                            isBookmarked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isBookmarked ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isBookmarked) {
                                bookmarkedBooks.remove(book['key']);
                              } else {
                                bookmarkedBooks.add(book['key']);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
