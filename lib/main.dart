import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'data/loaddata.dart';
import 'domain/affirmation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => AffirmationList(),
      ),
      GoRoute(
        path: '/image',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          return ImagePage(
            imagePath: args['image'],
            desc: args['desc'],
            likes: args['likes'],
            dislikes: args['dislikes'],
          );
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class AffirmationList extends StatefulWidget {
  @override
  _AffirmationListState createState() => _AffirmationListState();
}

class _AffirmationListState extends State<AffirmationList> {
  final List<Affirmation> affirmations = loaddata();
  late List<int> likes;
  late List<int> dislikes;

  @override
  void initState() {
    super.initState();
    likes = List.generate(affirmations.length, (index) => 0);
    dislikes = List.generate(affirmations.length, (index) => 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Affirmation List")),
      body: ListView.builder(
        itemCount: affirmations.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(12),
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    context.push(
                      '/image',
                      extra: {
                        'image': affirmations[index].image,
                        'desc': affirmations[index].desc,
                        'likes': likes[index],
                        'dislikes': dislikes[index],
                      },
                    );
                  },
                  child: Image.asset(
                    affirmations[index].image,
                    height: 194,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    affirmations[index].desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up),
                      onPressed: () {
                        setState(() {
                          likes[index]++;
                        });
                      },
                    ),
                    Text('${likes[index]}'),
                    IconButton(
                      icon: Icon(Icons.thumb_down),
                      onPressed: () {
                        setState(() {
                          if (dislikes[index] > 0) dislikes[index]--;
                        });
                      },
                    ),
                    Text('${dislikes[index]}'),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ImagePage extends StatefulWidget {
  final String imagePath;
  final String desc;
  final int likes;
  final int dislikes;

  ImagePage({
    required this.imagePath,
    required this.desc,
    required this.likes,
    required this.dislikes,
  });

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  late int likes;
  late int dislikes;

  @override
  void initState() {
    super.initState();
    likes = widget.likes;
    dislikes = widget.dislikes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Detail"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.imagePath,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.desc,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: () {
                    setState(() {
                      likes++;
                    });
                  },
                ),
                Text('$likes'),
                IconButton(
                  icon: Icon(Icons.thumb_down),
                  onPressed: () {
                    setState(() {
                      if (dislikes > 0) dislikes--;
                    });
                  },
                ),
                Text('$dislikes'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
