import 'package:flutter/material.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Populares', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

          ),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (_, int index) => _MoviePoster() // Extraido en un metodo no en una clase, atento por si da error
            ),
          ),

        ],
      ),
    );
  }



  Container _MoviePoster() {
    return Container(
      width: 130,
      height: 190,
      color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: const [
          
          FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'), 
            image: NetworkImage('https://via.placeholder.com/300x400'),
            width: 130,
            height: 190,
            fit: BoxFit.cover,
          ),

          SizedBox(height: 5,),

          Text(
            'Starwars',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )


        ],
      ),
    );
  }
}
