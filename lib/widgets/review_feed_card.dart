import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedReviewCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const FeedReviewCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final user = data['user'];
    final review = data['review'];
    final mediaList = review['media'] as List;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(user['profileImage']),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  user['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              if (user['isTopVoice'])
                Container(
                  margin: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Top Voice',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: Colors.blue),
                child: Text(user['isFollowing'] ? 'Unfollow' : 'Follow'),
              ),
              if (user['instagram'] != null)
                IconButton(
                  icon: const Icon(
                    FontAwesomeIcons.instagram,
                    color: Colors.purpleAccent,
                  ),
                  onPressed: () {},
                ),
              if (user['youtube'] != null)
                IconButton(
                  icon: const Icon(FontAwesomeIcons.youtube, color: Colors.red),
                  onPressed: () {},
                ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            '${review['title']} • ${review['category']} • ${review['platform']}',
            style: const TextStyle(color: Colors.black87),
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${review['ratingEmoji']} ${review['ratingLabel']}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),

          const SizedBox(height: 12),

          Text(review['description'], style: const TextStyle(fontSize: 15)),

          const SizedBox(height: 12),

          if (mediaList.isNotEmpty)
            SizedBox(
              height: 180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: mediaList.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      mediaList[index],
                      width: 250,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),

          const Divider(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconWithCount(
                icon: FontAwesomeIcons.thumbsUp,
                count: review['likes'],
              ),
              IconWithCount(
                icon: FontAwesomeIcons.comment,
                count: review['comments'],
              ),
              const Icon(
                FontAwesomeIcons.shareFromSquare,
                color: Colors.lightBlue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class IconWithCount extends StatelessWidget {
  final IconData icon;
  final int count;

  const IconWithCount({super.key, required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.lightBlue),
        const SizedBox(width: 4),
        Text(count.toString()),
      ],
    );
  }
}
