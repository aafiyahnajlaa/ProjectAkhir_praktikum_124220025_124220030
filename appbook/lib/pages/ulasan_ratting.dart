import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/api_detailbuku.dart';
import 'detailbooks.dart';

class BookDetailsPage extends StatefulWidget {
  final String bookKey;

  BookDetailsPage({required this.bookKey});

  @override
  _BookDetailsPageState createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  late Detailbooks bookDetail;
  double _rating = 0.0;
  TextEditingController _reviewController = TextEditingController();
  List<Map<String, dynamic>> reviews = [];

  @override
  void initState() {
    super.initState();
    fetchBookDetail();
    fetchReviews(); // Fetch existing reviews from Firestore
  }

  // Fetch book detail from API
  void fetchBookDetail() async {
    final response = await http.get(Uri.parse('https://openlibrary.org${widget.bookKey}.json'));

    if (response.statusCode == 200) {
      setState(() {
        bookDetail = Detailbooks.fromJson(jsonDecode(response.body));
      });
    } else {
      print('Error fetching book detail: ${response.statusCode}');
    }
  }

  // Fetch reviews from Firestore
  void fetchReviews() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('book_reviews')
        .doc(widget.bookKey) // Use bookKey as document ID
        .collection('reviews')
        .get();

    setState(() {
      reviews = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  // Save review and rating to Firestore
  void _saveReview() async {
    if (_reviewController.text.isNotEmpty && _rating > 0) {
      final reviewData = {
        'review': _reviewController.text,
        'rating': _rating,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('book_reviews')
          .doc(widget.bookKey)
          .collection('reviews')
          .add(reviewData);

      // Clear review text after saving
      _reviewController.clear();
      _rating = 0.0;

      // Update local reviews list
      fetchReviews(); // Refresh the reviews list
    }
  }

  // Update review and rating in Firestore
  void _updateReview(String reviewId, int index) async {
    final updatedReviewData = {
      'review': _reviewController.text,
      'rating': _rating,
    };

    await FirebaseFirestore.instance
        .collection('book_reviews')
        .doc(widget.bookKey)
        .collection('reviews')
        .doc(reviewId)
        .update(updatedReviewData);

    // Update local reviews list
    fetchReviews(); // Refresh the reviews list
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Review and Rating updated successfully!')),
    );
  }

  // Delete review from Firestore
  void _deleteReview(String reviewId) async {
    await FirebaseFirestore.instance
        .collection('book_reviews')
        .doc(widget.bookKey)
        .collection('reviews')
        .doc(reviewId)
        .delete();

    // Update local reviews list
    fetchReviews(); // Refresh the reviews list
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Review and Rating deleted successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookDetail.title ?? 'Book Detail'),
      ),
      body: bookDetail.title == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bookDetail.covers != null && bookDetail.covers!.isNotEmpty
                ? Image.network(
              'https://covers.openlibrary.org/b/id/${bookDetail.covers!.first}-L.jpg',
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            )
                : Container(),
            SizedBox(height: 16.0),
            Text(
              bookDetail.title ?? 'No Title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'By: ${bookDetail.authors?.map((author) => author.key).join(', ') ?? 'Unknown'}',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 16.0),
            Text(
              bookDetail.firstSentence?.value ?? 'No description available.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              'Published: ${bookDetail.publishDate ?? 'Unknown'}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16.0),
            Text(
              'Rate this book:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40.0,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Your Review:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _reviewController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Write your review here...',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveReview,
              child: Text('Save Review & Rating'),
            ),
            SizedBox(height: 16.0),
            reviews.isNotEmpty
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All Reviews:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                ...reviews.map((reviewData) {
                  String reviewId = reviewData['id']; // Assuming you store the document ID
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rating: ${reviewData['rating'].toStringAsFixed(1)}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            reviewData['review'] ?? 'No review provided.',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _reviewController.text = reviewData['review'];
                                  _rating = reviewData['rating'];
                                  _updateReview(reviewId, reviews.indexOf(reviewData));
                                },
                                child: Text('Update'),
                              ),
                              SizedBox(width: 8.0),
                              ElevatedButton(
                                onPressed: () => _deleteReview(reviewId),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                ),
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}