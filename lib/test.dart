import 'package:flutter/material.dart';
import './url_strategy_native.dart' if (dart.library.html) './url_strategy_web.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        colorSchemeSeed: const Color(0xff006f18),
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: 'Montserrat'),
    home: Scaffold(
        body: Container(
      margin: const EdgeInsets.all(20.0),
      child: const PostCard(
        avatarUrl: 'https://example.com/avatar.png',
        name: 'John Doe',
        title: 'My Awesome Post',
        content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        timestamp: 'March 19, 2023',
        likes: 42,
      ),
    )),
  ));
  urlConfig();
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo'),
      ),
      body: Center(
        child: FilledButton.tonalIcon(
          onPressed: () {},
          label: const Text("sdgszdfcrgb"),
          icon: const Icon(
            Icons.add,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final String avatarUrl;
  final String name;
  final String title;
  final String content;
  final String timestamp;
  final int likes;

  const PostCard({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.title,
    required this.content,
    required this.timestamp,
    required this.likes,
  });

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  Color borderColor = Colors.grey[300]!;
  Color _borderColor = Colors.grey[300]!;
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to full screen page
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovering = true;
            _borderColor = Theme.of(context).colorScheme.primary;
            borderColor = Theme.of(context).colorScheme.primary;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovering = false;
            _borderColor = Colors.grey[300]!;
            borderColor = Colors.grey[300]!;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: borderColor,
              width: 4.0,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.avatarUrl),
                    radius: 20.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    widget.timestamp,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                widget.content,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Icon(
                    Icons.thumb_up_alt_outlined,
                    color: _isHovering ? Theme.of(context).colorScheme.primary : Colors.grey[600],
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    '${widget.likes}',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Icon(
                    Icons.comment_outlined,
                    color: _isHovering ? Theme.of(context).colorScheme.primary : Colors.grey[600],
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    '42',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
