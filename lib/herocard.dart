import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BigMovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String genres;
  final int year;
  final String rating;

  const BigMovieCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.genres,
    required this.year,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: Stack(
            children: [
              // 🖼️ Background
              Positioned.fill(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                ),
              ),

              // 🌑 Gradient
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // 📄 Content
              Positioned(
                left: 12.w,
                right: 12.w,
                bottom: 12.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🎬 Title
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.w,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    // ⭐ Info row (THIS is what you wanted)
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "$genres • $year • ⭐ $rating",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12.w,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    // 🔘 Buttons
                    // Center(
                    //   child: ElevatedButton.icon(
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: Colors.grey.shade800,
                    //       foregroundColor: Colors.white,
                    //     ),
                    //     onPressed: () {},
                    //     icon: const Icon(Icons.info_outline),
                    //     label: const Text("More Info"),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}