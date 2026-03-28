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
      height:200.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔳 Image Card
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              height: 150.h,
              color: Colors.grey.shade200,
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),

          SizedBox(height: 5.h),

          // 🎬 Title
          Flexible(
            child: SizedBox(
              width:100.h,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.h,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}