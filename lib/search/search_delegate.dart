import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar Pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return _EmptyContainer();
    }

    final moviesProviders = Provider.of<MoviesProvider>(context, listen: false);

    return futureBuilder(moviesProviders, query, _EmptyContainer());
  }

  Widget _EmptyContainer() {
    return Container(
      child: const Center(
          child: Icon(
        Icons.movie_creation_outlined,
        color: Colors.black38,
        size: 130,
      )),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _EmptyContainer();
    }

    final moviesProviders = Provider.of<MoviesProvider>(context, listen: false);

    return futureBuilder(moviesProviders, query, _EmptyContainer());
  }
}

Widget futureBuilder(MoviesProvider moviesProviders, String query, Widget emptyContainer ) {
  return FutureBuilder(
        future: moviesProviders.searchMovie(query),
        builder: ((_, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) return emptyContainer;

          final movies = snapshot.data;

          return ListView.builder(
              itemCount: movies!.length,
              itemBuilder: (_, int index) => _MovieItem(
                    movie: movies[index],
                  ));
        }));
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}