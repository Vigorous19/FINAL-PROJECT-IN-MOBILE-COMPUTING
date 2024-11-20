import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: IntroScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/details': (context) => DetailScreen(),
      },
    );
  }
}

// Intro Screen with Fade-In Animation
class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/home');
      },
      child: Scaffold(
        body: AnimatedOpacity(
          duration: Duration(seconds: 2),
          opacity: _opacity,
          child: Container(
            color: Colors.deepPurple,
            child: Center(
              child: Text(
                "Movie List App",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Home Screen with ListView of Movies
class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> movies = [
    {"title": "Inception", "description": "A mind-bending thriller."},
    {"title": "Interstellar", "description": "A journey to the stars."},
    {"title": "The Dark Knight", "description": "Gotham's savior."},
    {"title": "Tenet", "description": "Time runs out."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie List"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Placeholder for search functionality
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.movie, color: Colors.deepPurple),
              title: Text(movies[index]["title"]!),
              subtitle: Text(movies[index]["description"]!),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: movies[index],
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Placeholder for adding a new movie
        },
      ),
    );
  }
}

// Detail Screen to Show Movie Details
class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, String>? movie =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie?["title"] ?? "Movie Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie?["title"] ?? "",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              movie?["description"] ?? "",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
