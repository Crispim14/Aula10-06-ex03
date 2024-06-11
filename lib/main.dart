import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Movie List App',
      home: MovieListScreen(),
    );
  }
}

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Movie> _movies = [];

  void _addMovie() {
    final String movieName = _controller.text;
    if (movieName.isNotEmpty) {
      setState(() {
        _movies.add(Movie(name: movieName));
      });
      _controller.clear();
    }
  }

  void _toggleLike(Movie movie) {
    setState(() {
      movie.isLiked = !movie.isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Filmes - Exercicio 4  '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Digite o filme: ',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addMovie,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  final movie = _movies[index];
                  return ListTile(
                    title: Text(movie.name),
                    trailing: Icon(
                      movie.isLiked ? Icons.thumb_up : Icons.thumb_up_off_alt,
                      color: movie.isLiked ? Colors.blue : null,
                    ),
                    onTap: () => _toggleLike(movie),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Movie {
  final String name;
  bool isLiked;

  Movie({required this.name, this.isLiked = false});
}
