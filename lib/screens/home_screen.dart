import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    // PROVIDER El listener permite que se repinten, si es un metodo normalente es false, por que no se pueden redibujar
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);


    print(moviesProvider.onDisplayMovies);



    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            CardSwiper(
              movies: moviesProvider.onDisplayMovies,
              onNextPage: () => moviesProvider.getOnDisplayMovies(),),

            MovieSlider( 
              movies: moviesProvider.popularMovies,
              title: 'Populares',
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),
            
          ],
        ),
      )
    );
  }
}
