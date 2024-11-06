import 'package:flickd_app/models/movie.dart';
import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  const MovieTile(
      {super.key,
      required this.movie,
      required this.height,
      required this.width});

  final double height;
  final double width;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _moviePosterWidget(movie.posterURL()),
          _movieInfoWidget(),
        ],
      ),
    );
  }

  Widget _movieInfoWidget() {
    return Container(
      height: height,
      width: width * 0.66,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width * 0.50,
                child: Text(
                  movie.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                movie.rating.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
            child: Text(
              '${movie.language.toUpperCase()} | R: ${movie.isAdult} | ${movie.releaseDate}',
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
            child: Text(
              movie.description,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Widget _moviePosterWidget(String imageUrl) {
    return Container(
      height: height,
      width: width * 0.35,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(movie.posterURL())),
      ),
    );
  }
}
