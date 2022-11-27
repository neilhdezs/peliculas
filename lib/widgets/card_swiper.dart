import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

import '../models/models.dart';

class CardSwiper extends StatefulWidget {
  List<Movie> movies;
  final Function onNextPage;

  CardSwiper({super.key, required this.movies, required this.onNextPage});

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  final SwiperController swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (widget.movies.isEmpty) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: widget.movies.length,
        controller: swiperController,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.width * 0.9,
        loop: false,
        onIndexChanged: (int index) {
          print(index);
          if (index == widget.movies.length - 1) {
            widget.onNextPage();
            setState(() {});
          }
        },
        itemBuilder: (_, int index) {
          final Movie movie = widget.movies[index];

          movie.heroId = 'swiper-${movie.id}';

          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/loading.gif'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
