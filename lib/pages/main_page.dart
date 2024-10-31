import 'dart:ui';
import 'package:flickd_app/models/search_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class MainPage extends ConsumerWidget {
  late double _deviceHeight;
  late double _devicewidth;

  late TextEditingController _searchTextFieldController;

  MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _devicewidth = MediaQuery.of(context).size.width;
    _searchTextFieldController = TextEditingController();

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
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
      width: _deviceHeight * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _topBarWidget(),
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
        underline: Container(),
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        value: SearchCategory.popular,
        dropdownColor: Colors.black54,
        items: [
          DropdownMenuItem(
            value: SearchCategory.popular,
            child: Text(
              SearchCategory.popular,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          DropdownMenuItem(
            value: SearchCategory.newItems,
            child: Text(
              SearchCategory.newItems,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          DropdownMenuItem(
            value: SearchCategory.none,
            child: Text(
              SearchCategory.none,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
        onChanged: (value) {});
  }
}
