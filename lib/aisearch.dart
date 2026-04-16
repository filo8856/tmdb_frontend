import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/desc.dart';
import 'package:tmdb/fetch.dart';
import 'package:tmdb/models.dart';

class AiSearch extends StatefulWidget {
  const AiSearch({super.key});

  @override
  State<AiSearch> createState() => _AiSearchState();
}

class _AiSearchState extends State<AiSearch> {
  final TextEditingController _controller = TextEditingController();
  List<int> ids = [];
  bool _isload = false;
  final FocusNode _focusNode = FocusNode();
  List<Movie> filtered = []; // start with all movies
  String query = "";
  Future<void> searchMovies(String value) async {
    setState(() {
      _isload = true;
    });
    final resultIds = await ApiService.aiSearchIds(value);

    setState(() {
      ids = resultIds;

      filtered = Movies.where((m) => ids.contains(m.movieId)).toList();
      _isload = false;
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
    _controller.dispose(); // ✅ add this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          ' AI Search',
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
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    style: TextStyle(color: Colors.white),

                    maxLines: null, // 🔥 allows infinite lines
                    keyboardType: TextInputType.multiline,

                    decoration: InputDecoration(
                      hintText: "Ask anything...",
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey.shade900,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  searchMovies(_controller.text);
                },
                icon: Icon(Icons.arrow_forward, color: Colors.yellow),
              ),
            ],
          ),

          // 🎬 Posters Grid
          _isload
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.yellow),
                )
              : Expanded(
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
                          child: Image.network(
                            movie.posterUrl,
                            fit: BoxFit.cover,
                          ),
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
