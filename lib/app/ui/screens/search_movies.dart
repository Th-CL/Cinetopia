import 'package:flutter/material.dart';
import 'package:cine_topia/app/ui/components/movie_card.dart';

class SearchMovies extends StatelessWidget {
  const SearchMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF1D0E44),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(child: Image.asset("assets/movie.png", height: 80, width: 80,),),
          SliverToBoxAdapter(child: Text("Filmes populares"),),
          SliverToBoxAdapter(child: TextField(),),
          SliverList.builder(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: MovieCard(),
            ), 
            itemCount: 10,
          ),
        ],
      ),
    );
  }
}