import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:josequal/model/wallpapers_model.dart';
import 'package:josequal/utils/constant.dart';

class WallpapersServices with ChangeNotifier {
  WallpapersServices() {
    fetchWallpapers(page: 1);
  }

  /// For Fetch Wallpapers
  List<WallpaperModel> wallpapers = [];
  bool hasMore = true;
  bool isLoading = false;

  void fetchWallpapers({int page = 1}) async {
    if (hasMore) {
      isLoading = true;
      notifyListeners();

      Uri url = Uri.parse('$BASEURL/curated?per_page=20&page=$page');
      await http.get(url, headers: {"Authorization": $APIKEY}).then((response) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> results =
              jsonDecode(response.body) as Map<String, dynamic>;
          if (results['next_page'] == null) {
            hasMore = false;
            notifyListeners();
          }
          List<dynamic> resultsPhotos = (jsonDecode(response.body)
              as Map<String, dynamic>)["photos"] as List<dynamic>;
          for (var element in resultsPhotos) {
            wallpapers
                .add(WallpaperModel.fromJson(element as Map<String, dynamic>));
          }
          isLoading = false;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
        }
      }).catchError((onError) {
        isLoading = false;
        wallpapers.clear();
        notifyListeners();
      });
    }
  }

  /// For Fetch Wallpapers For Search
  List<WallpaperModel> wallpapersSearch = [];
  bool hasMoreSearch = true;
  bool isLoadingSearch = false;
  String query = '';

  void fetchWallpapersSearch({int page = 1, String query = ''}) async {
    if (query != this.query) {
      clearSearchResult();
    }
    this.query = query;
    if (hasMoreSearch) {
      isLoadingSearch = true;
      notifyListeners();

      Uri url =
          Uri.parse('$BASEURL/search?query=$query&per_page=20&page=$page');
      await http.get(url, headers: {"Authorization": $APIKEY}).then((response) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> results =
              jsonDecode(response.body) as Map<String, dynamic>;
          if (results['next_page'] == null) {
            hasMoreSearch = false;
          }
          List<dynamic> resultsPhotos = (jsonDecode(response.body)
              as Map<String, dynamic>)["photos"] as List<dynamic>;
          for (var element in resultsPhotos) {
            wallpapersSearch
                .add(WallpaperModel.fromJson(element as Map<String, dynamic>));
          }
          isLoadingSearch = false;
          notifyListeners();
        } else {
          isLoadingSearch = false;
          notifyListeners();
        }
      }).catchError((onError) {
        isLoadingSearch = false;
        wallpapersSearch.clear();
        notifyListeners();
      });
    }
  }

  clearSearchResult() {
    wallpapersSearch.clear();
    isLoadingSearch = false;
    hasMoreSearch = true;
    query = '';
    notifyListeners();
  }
}
