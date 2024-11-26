import 'package:flutter/material.dart';
import 'data/loaddata.dart';
import 'domain/affirmation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Activity 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScaffoldSample(),
    );
  }
}

class ScaffoldSample extends StatelessWidget {
  const ScaffoldSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Affirmations"),
      ),
      body: const AffirmationList(),
    );
  }
}

class AffirmationCard extends StatefulWidget {
  final String imagePath;
  final String title;

  const AffirmationCard({super.key, required this.imagePath, required this.title});

  @override
  _AffirmationCardState createState() => _AffirmationCardState();
}

class _AffirmationCardState extends State<AffirmationCard> {
  int likeCount = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            widget.imagePath,
            height: 194,
            width: 600,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.thumb_up),
                onPressed: () {
                  setState(() {
                    likeCount++;
                  });
                },
              ),
              Text('$likeCount'),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.thumb_down),
                onPressed: () {
                  setState(() {
                    if (likeCount > 0) likeCount--;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AffirmationList extends StatelessWidget {
  const AffirmationList({super.key});

  @override
  Widget build(BuildContext context) {
    final affirmations = loaddata();

    return ListView.builder(
      itemCount: affirmations.length,
      itemBuilder: (context, index) {
        final affirmation = affirmations[index];
        return AffirmationCard(
          imagePath: affirmation.image,
          title: affirmation.desc,
        );
      },
    );
  }
}
