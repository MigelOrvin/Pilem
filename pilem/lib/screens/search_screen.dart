import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:pilem/services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _searchResult = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchMovies);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _searchMovies() async {
    if (_searchController.text.isEmpty) {
      setState(() {
        _searchResult.clear();
      });
      return;
    }

    final List<Map<String, dynamic>> searchData =
        await _apiService.searchMovies(_searchController.text);
    setState(() {
      _searchResult = searchData.map((e) => Movie.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          hintText: "Search movies...",
                          border: InputBorder.none),
                    ),
                  ),
                  Visibility(
                    visible: _searchController.text.isNotEmpty,
                    child: IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchResult.clear();
                          });
                        },
                        icon: Icon(Icons.clear)),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ListView.builder(itemBuilder: (context, index) {})
          ],
        ),
      ),
    );
  }
}
