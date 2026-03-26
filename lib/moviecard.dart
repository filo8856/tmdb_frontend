import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const MovieCard({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔳 Image Card
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              height: 200.h,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 10.h),

          // 🎬 Title
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.w,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}