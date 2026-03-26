import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/fetch.dart';

class Desc extends StatefulWidget {
  final int id;
  Desc({super.key, required this.id});
  @override
  State<Desc> createState() => _DescState();
}

class _DescState extends State<Desc> {
  Map<String, dynamic>? movie;
  bool isLoading = true;
  bool isExpanded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadMovie();
  }

  Future<void> loadMovie() async {
    try {
      final data = await ApiService.fetchMovieById(widget.id);

      setState(() {
        movie = data;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.black),
        backgroundColor: Colors.black,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.yellow),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 200.h,
                        width: 350.w,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30.h),

                    // 🎬 Title
                    Text(
                      movie?['title'] ?? "No Title",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.w,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // 📅 Year • ⏱ Runtime • ⭐ Rating
                    Text(
                      "${movie?['release_year'] ?? '-'} • "
                      "${movie?['runtime_mins'] ?? '-'} mins • "
                      "${movie?['rating'] ?? '-'} ⭐",

                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.w,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 50.h),

                            // 📝 Description
                            GestureDetector(
                              onTap: () {
                                print('Pressed');
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: Text(
                                movie?['description'] ??
                                    "No description available.",
                                maxLines: isExpanded ? null : 3, // 🔥 key line
                                overflow: isExpanded
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey.shade300,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.w,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.network(
                                  movie?['poster_url'] ?? "",
                                  height: 200.h,
                                  width: 140.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            // 🎭 Genres
                            Text.rich(
                              TextSpan(
                                text: "Genres: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 13.w,
                                ),
                                children: [
                                  TextSpan(
                                    text: movie?['genres'] ?? "-",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 6.h),

                            // 🏢 Studios
                            Text.rich(
                              TextSpan(
                                text: "Studios: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 13.w,
                                ),
                                children: [
                                  TextSpan(
                                    text: movie?['studios'] ?? "-",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 6.h),

                            // 🎬 Actors
                            Text.rich(
                              TextSpan(
                                text: "Actors: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 13.w,
                                ),
                                children: [
                                  TextSpan(
                                    text: movie?['actors'] ?? "-",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 6.h),

                            // 🎥 Directors
                            Text.rich(
                              TextSpan(
                                text: "Directors: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 13.w,
                                ),
                                children: [
                                  TextSpan(
                                    text: movie?['directors'] ?? "-",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 6.h),

                            // ✍️ Writers
                            Text.rich(
                              TextSpan(
                                text: "Writers: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 13.w,
                                ),
                                children: [
                                  TextSpan(
                                    text: movie?['writers'] ?? "-",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 6.h),

                            // 🎬 Producers
                            Text.rich(
                              TextSpan(
                                text: "Producers: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 13.w,
                                ),
                                children: [
                                  TextSpan(
                                    text: movie?['producers'] ?? "-",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
