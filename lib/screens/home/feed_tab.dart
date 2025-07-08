import 'package:flutter/material.dart';
import 'package:recofrend/widgets/review_feed_card.dart';
import 'package:recofrend/data/dummy_feed_reviews.dart';

class FeedTab extends StatefulWidget {
  final int selectedFeedTab;

  const FeedTab({super.key, required this.selectedFeedTab});

  @override
  State<FeedTab> createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> {
  final ScrollController _feedScrollController = ScrollController();
  final List<Map<String, dynamic>> allReviews = dummyFeedReviews;

  List<Map<String, dynamic>> get filteredReviews {
    if (widget.selectedFeedTab == 0) {
      return allReviews
          .where((r) => r['review']['isTrending'] == true)
          .toList();
    } else {
      return allReviews.where((r) => r['user']['isFollowing'] == true).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (filteredReviews.isEmpty) {
      return const Center(
        child: Text(
          'No reviews to show.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      controller: _feedScrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: filteredReviews.length,
      itemBuilder: (context, index) {
        return FeedReviewCard(data: filteredReviews[index]);
      },
    );
  }
}
