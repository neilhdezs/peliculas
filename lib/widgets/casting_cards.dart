import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'package:peliculas/models/models.dart';

class CastingCards extends StatelessWidget {
  final int movieId;
  CastingCards({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 50),
            margin: EdgeInsetsDirectional.only(start: (size.width/2)-25, end: (size.width/2)-25),
            width: 50,
            height: 50,
            child: const CircularProgressIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) =>
                _CastCard(actor: cast[index]),
          ),
        );

      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
