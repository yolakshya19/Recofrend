import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedReviewCard extends StatefulWidget {
  final Map<String, dynamic> data;

  const FeedReviewCard({super.key, required this.data});

  @override
  State<FeedReviewCard> createState() => _FeedReviewCardState();
}

class _FeedReviewCardState extends State<FeedReviewCard> {
  bool showComments = false;
  bool isLiked = false;
  int likeCount = 0;
  final commentController = TextEditingController();

  List<Map<String, dynamic>> comments = [
    {
      'user': 'Ananya',
      'avatar': 'assets/logo.jpg',
      'text': 'Loved this review!',
      'time': '2h ago',
    },
    {
      'user': 'Karan',
      'avatar': 'assets/logo.jpg',
      'text': 'Agreed, this show is a gem.',
      'time': '5h ago',
    },
  ];

  @override
  void initState() {
    super.initState();
    likeCount = widget.data['review']['likes'];
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }

  void toggleComments() {
    setState(() {
      showComments = !showComments;
    });
  }

  void postComment() {
    final text = commentController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        comments.add({
          'user': 'You',
          'avatar': 'assets/logo.jpg',
          'text': text,
          'time': 'Just now',
        });
        commentController.clear();
      });
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.data['user'];
    final review = widget.data['review'];
    final mediaList = review['media'] as List;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(15),
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
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            user['name'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (user['isTopVoice'])
                          Container(
                            margin: const EdgeInsets.only(left: 6),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.purple[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Top Voice',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      review['time'], // e.g. "2 hours ago"
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 116, 116, 116),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 4),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Text(user['isFollowing'] ? 'Unfollow' : 'Follow'),
                  ),
                  if (user['instagram'] != null)
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.instagram,
                        color: Colors.pinkAccent,
                      ),
                      onPressed: () {},
                    ),
                  if (user['youtube'] != null)
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.youtube,
                        color: Colors.red,
                      ),
                      onPressed: () {},
                    ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text.rich(
            TextSpan(
              style: const TextStyle(color: Colors.black87),
              children: [
                TextSpan(
                  text: review['title'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' • ${review['category']} • ${review['platform']}',
                ),
              ],
            ),
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
              InkWell(
                hoverColor: Colors.grey,
                splashColor: Colors.grey,
                onTap: toggleLike,
                child: Row(
                  children: [
                    Icon(
                      isLiked
                          ? FontAwesomeIcons.solidHeart
                          : FontAwesomeIcons.heart,
                      size: 20,
                      color: Colors.lightBlue,
                    ),
                    const SizedBox(width: 4),
                    Text('$likeCount'),
                  ],
                ),
              ),
              InkWell(
                onTap: toggleComments,
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.comment,
                      size: 20,
                      color: Colors.lightBlue,
                    ),
                    const SizedBox(width: 4),
                    Text('${comments.length}'),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.shareFromSquare,
                  color: Colors.lightBlue,
                ),
              ),
            ],
          ),
          if (showComments)
            Column(
              children: [
                const SizedBox(height: 12),
                ...comments
                    .take(3)
                    .map(
                      (comment) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: AssetImage(comment['avatar']),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment['user'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(comment['text']),
                                  const SizedBox(height: 4),
                                  Text(
                                    comment['time'],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage('assets/logo.jpg'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        decoration: const InputDecoration(
                          hintText: 'Add a comment...',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    ElevatedButton(
                      onPressed: postComment,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(1),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text('Post'),
                    ),
                  ],
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
