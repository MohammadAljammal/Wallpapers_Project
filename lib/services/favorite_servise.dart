import 'package:flutter/foundation.dart';
import 'package:josequal/model/wallpapers_model.dart';
import 'package:josequal/services/database_sqflite.dart';

class FavoriteServices with ChangeNotifier {
  FavoriteServices() {
    fetchFavoriteWallpapers();
  }

  List<WallpaperModel> wallpapersSearchFavorite = [];
  bool isLoading = true;
  final databaseSqfLite = DatabaseSqfLite.instance;

  /// For Fetch Favorite Wallpapers
  fetchFavoriteWallpapers() async {
    isLoading = true;
    notifyListeners();

    List<Map<String, dynamic>> data = await databaseSqfLite.queryAllRows();
    data.forEach((element) {
      wallpapersSearchFavorite.add(WallpaperModel.fromJsonSql(element));
    });

    isLoading = false;
    notifyListeners();
  }

  /// For Add Wallpaper To Favorite
  addWallpaperFavorite({required WallpaperModel wallpaperModel}) async {
    try {
      await databaseSqfLite.insert(wallpaperModel);
      wallpapersSearchFavorite.add(wallpaperModel);
      notifyListeners();
    } catch (e) {}
  }

  /// For Delete Wallpaper From Favorite
  deleteWallpaperFavorite({required WallpaperModel wallpaperModel}) async {
    try {
      await databaseSqfLite.delete(wallpaperModel.id!);
      wallpapersSearchFavorite
          .removeWhere((element) => element.id == wallpaperModel.id);
      notifyListeners();
    } catch (e) {}
  }

  /// For Check Wallpaper If on Favorite
  bool checkWallpaperFavorite({required int id}) {
    return wallpapersSearchFavorite
        .where((element) => element.id! == id)
        .isEmpty;
  }
}
