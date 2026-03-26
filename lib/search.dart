import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/desc.dart';
import 'package:tmdb/models.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final FocusNode _focusNode = FocusNode();
  List<Movie> filtered = Movies; // start with all movies
  String query = "";
  void searchMovies(String value) {
    setState(() {
      query = value;

      filtered = Movies.where((movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            'Search',
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
              Navigator.pop(
                context,
                true,
              ); // 🔥 tell previous screen to refresh
            },
          ),
        ),
      ),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: EdgeInsets.all(12.w),
            child: TextField(
              focusNode: _focusNode,
              onChanged: searchMovies,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search movies...",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.yellow),
                filled: true,
                fillColor: Colors.grey.shade900,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 🎬 Posters Grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: filtered.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 👈 number of posters per row
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
                childAspectRatio: 0.65, // poster ratio
              ),
              itemBuilder: (context, index) {
                final movie = filtered[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Desc(id: movie.movieId),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.network(movie.posterUrl, fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
