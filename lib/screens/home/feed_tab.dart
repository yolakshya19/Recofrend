import 'package:flutter/material.dart';
import 'package:recofrend/widgets/review_feed_card.dart';
import 'package:recofrend/data/dummy_feed_reviews.dart'; // You need to create this file

class FeedTab extends StatefulWidget {
  const FeedTab({super.key});

  @override
  State<FeedTab> createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> {
  final ScrollController _feedScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _feedScrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: dummyFeedReviews.length,
      itemBuilder: (context, index) {
        return FeedReviewCard(data: dummyFeedReviews[index]);
      },
    );
  }
}
