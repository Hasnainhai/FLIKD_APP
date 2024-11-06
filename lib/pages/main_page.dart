import 'dart:ui';
import 'package:flickd_app/models/main_page_data.dart';
import 'package:flickd_app/models/movie.dart';
import 'package:flickd_app/models/search_category.dart';
import 'package:flickd_app/widgets/movie_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/main_page_data_controller.dart';

final mainPageDataControllerProvider =
    StateNotifierProvider<MainPageDataController, MainPageData>(
  (ref) => MainPageDataController(),
);

// ignore: must_be_immutable
class MainPage extends ConsumerWidget {
  late double _deviceHeight;
  late double _devicewidth;

  late TextEditingController _searchTextFieldController;
  late MainPageDataController _mainPageDataController;
  late MainPageData _mainPageData;

  MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _devicewidth = MediaQuery.of(context).size.width;
    _searchTextFieldController = TextEditingController();

    // Access mainPageDataController state notifier
    _mainPageDataController =
        ref.watch(mainPageDataControllerProvider.notifier);
    // Access the MainPageData (state)
    _mainPageData = ref.watch(mainPageDataControllerProvider);

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
        height: _deviceHeight,
        width: _devicewidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backgroundWidget(),
            _foregroundWidgets(),
          ],
        ),
      ),
    );
  }

  Widget _backgroundWidget() {
    return Container(
      height: _deviceHeight,
      width: _devicewidth,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          height: _deviceHeight,
          width: _devicewidth,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      ),
    );
  }

  Widget _foregroundWidgets() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, _deviceHeight * 0.02, 0.0, 0.0),
      width: _devicewidth * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _topBarWidget(),
          Container(
            height: _deviceHeight * 0.83,
            padding: const EdgeInsets.symmetric(vertical: 0.01),
            child: _movieListViewWidget(),
          ),
        ],
      ),
    );
  }

  Widget _topBarWidget() {
    return Container(
      height: _deviceHeight * 0.08,
      decoration: BoxDecoration(
          color: Colors.black54, borderRadius: BorderRadius.circular(20.0)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _searchFieldWidget(),
            _categorySelectionWidget(),
          ],
        ),
      ),
    );
  }

  Widget _searchFieldWidget() {
    const border = InputBorder.none;
    return SizedBox(
      height: _deviceHeight * 0.05,
      width: _devicewidth * 0.50,
      child: TextField(
        controller: _searchTextFieldController,
        decoration: const InputDecoration(
          focusedBorder: border,
          hintText: 'Search here...',
          prefixIconColor: Colors.white,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          border: border,
        ),
      ),
    );
  }

  Widget _categorySelectionWidget() {
    return DropdownButton(
        value: _mainPageData.searchCategory,
        dropdownColor: Colors.black54,
        underline: Container(),
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        items: const [
          DropdownMenuItem(
            value: SearchCategory.popular,
            child: Text(
              SearchCategory.popular,
              style: TextStyle(color: Colors.white),
            ),
          ),
          DropdownMenuItem(
            value: SearchCategory.upComing,
            child: Text(
              SearchCategory.upComing,
              style: TextStyle(color: Colors.white),
            ),
          ),
          DropdownMenuItem(
            value: SearchCategory.none,
            child: Text(
              SearchCategory.none,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        onChanged: (value) => value.toString().isNotEmpty
            ? _mainPageDataController.updateSearchCategories(value.toString())
            : null);
  }

  Widget _movieListViewWidget() {
    List<Movie> _movies = _mainPageData.movies;

    // for (var i = 0; i < 20; i++) {
    //   _movies.add(Movie(
    //       name: 'hasnain',
    //       language: 'urdu',
    //       isAdult: true,
    //       description: 'hasna movie is a great movie you have to watch it once',
    //       posterPath: 'assets/images/bg.png',
    //       backdropPath: 'assets/images/bg.png',
    //       rating: 7.7,
    //       releaseDate: '20-1-23'));
    // }

    if (_movies.isNotEmpty) {
      return ListView.builder(
          itemCount: _movies.length,
          itemBuilder: (BuildContext context, int _count) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: _deviceHeight * 0.01, horizontal: 0),
              child: GestureDetector(
                child: MovieTile(
                    movie: _movies[_count],
                    height: _deviceHeight * 0.20,
                    width: _devicewidth * 0.85),
              ),
            );
          });
    } else {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    }
  }
}
