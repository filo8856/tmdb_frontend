import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/models.dart';
import 'package:tmdb/moviecard.dart';
import 'package:tmdb/fetch.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, List<Movie>> group = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    group = groupMoviesByGenre();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: group.entries.map((entry) {
            final genre = entry.key;
            final movies = entry.value;
        
            if (movies.isEmpty) return const SizedBox(); // skip empty genres
        
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🎯 Genre Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      genre,
                      style: TextStyle(
                        fontSize: 18.w,
                        fontWeight: FontWeight.bold,
                        color:Colors.white
                      ),
                    ),
                  ),
        
                  SizedBox(height: 10.h),
        
                  // 🎬 Horizontal movie list
                  SizedBox(
                    height: 270.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
        
                        return MovieCard(
                          imageUrl: movie.posterUrl,
                          title: movie.title,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
