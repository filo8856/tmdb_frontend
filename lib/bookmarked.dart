import 'package:flutter/material.dart';
import 'package:tmdb/desc.dart';
import 'package:tmdb/models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bookmarked extends StatefulWidget {
  const Bookmarked({super.key});

  @override
  State<Bookmarked> createState() => _BookmarkedState();
}

class _BookmarkedState extends State<Bookmarked> {
  List<Movie> showbook = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var x in Movies) {
      if (bookmarked.contains(x.movieId.toString())) showbook.add(x);
    }
    print(showbook);
  }

  void loadBookmarks() {
    showbook = Movies.where((m) => bookmarked.contains(m.movieId.toString())).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Bookmarked',
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 30.h,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.yellow, size: 40.h),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        toolbarHeight: 100.h,
      ),
      body: ListView.builder(
        itemCount: showbook.length,
        itemBuilder: (context, index) {
          final movie = showbook[index];

          return GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Desc(id: movie.movieId),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );

              if (result == true) {
                loadBookmarks(); // 🔥 reload list
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0F1B2D), // dark blue like your image
                borderRadius: BorderRadius.circular(12.r),
              ),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🎬 Poster
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      movie.posterUrl,
                      height: 80.h,
                      width: 60.w,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(width: 12.w),

                  // 📄 Movie Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          movie.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 4.h),

                        // Year • Rating
                        Row(
                          children: [
                            Text(
                              "${movie.releaseYear}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.w,
                              ),
                            ),

                            SizedBox(width: 10.w),

                            Icon(Icons.star, color: Colors.yellow, size: 14.w),

                            SizedBox(width: 4.w),

                            Text(
                              "${movie.rating}",
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 12.w,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 4.h),

                        // Genre
                        Text(
                          movie.genres ?? "Unknown",
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 12.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
