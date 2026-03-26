import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/bookmarked.dart';
import 'package:tmdb/desc.dart';
import 'package:tmdb/herocard.dart';
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
  late PageController _pageController;
  double _currentPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    group = groupMoviesByGenre();
    _pageController = PageController(
      viewportFraction: 0.6,
      initialPage: 500,
      // 👈 shows side cards
    );
    _currentPage = 500;
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final topMovies = Movies.take(10).toList();
    final infiniteMovies = List.generate(
      1000,
      (index) => topMovies[index % topMovies.length],
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.h,
          backgroundColor: Colors.black,
          centerTitle: true,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Icon(Icons.menu, color: Colors.yellow, size: 40.h),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: IconButton(
                icon: Icon(Icons.search, color: Colors.yellow, size: 40.h),
                onPressed: () {
                  print("Search clicked");
                },
              ),
            ),
          ],
          title: Text(
            'TMDB',
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 30.h,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        drawer: Drawer(
          width: 250.w,
          backgroundColor: Colors.black,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: 400.h),
              ListTile(
                leading: Icon(Icons.bookmark, color: Colors.yellow, size: 60.h),
                title: Text(
                  "Bookmarked",
                  style: TextStyle(fontSize: 20.h, color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Bookmarked(),

                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },

                      transitionDuration: Duration(milliseconds: 300),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        backgroundColor: Colors.black,
        body: ListView(
          children: [
            SizedBox(
              height: 400.h,
              child: PageView.builder(
                controller: _pageController,
                itemCount: infiniteMovies.length,
                itemBuilder: (context, index) {
                  final movie = infiniteMovies[index];

                  // 🎯 scale calculation
                  double scale = (1 - (_currentPage - index).abs()).clamp(
                    0.75,
                    1.1,
                  );

                  return Transform.scale(
                    scale: scale,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 20.h,
                      ),
                      child: BigMovieCard(
                        imageUrl: movie.posterUrl,
                        title: movie.title,
                        genres: movie.genres,
                        year: movie.releaseYear,
                        rating: movie.rating,
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 10.h),
            ...group.entries.map((entry) {
              final genre = entry.key;
              final movies = entry.value;

              if (movies.isEmpty) return const SizedBox(); // skip empty genres

              return Padding(
                padding: EdgeInsets.symmetric(),
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
                          color: Colors.white,
                        ),
                      ),
                    ),

                    SizedBox(height: 5.h),

                    // 🎬 Horizontal movie list
                    SizedBox(
                      height: 220.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => Desc(id: movie.movieId),

                                    transitionsBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                          child,
                                        ) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },

                                    transitionDuration: Duration(
                                      milliseconds: 300,
                                    ),
                                  ),
                                );
                              },
                              child: MovieCard(
                                imageUrl: movie.posterUrl,
                                title: movie.title,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ].toList(),
        ),
      ),
    );
  }
}
