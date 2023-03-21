import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:josequal/pages/wallpaper_pages/wallpapers_cart.dart';
import 'package:josequal/services/favorite_servise.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    FavoriteServices favoriteServices = Provider.of(context);

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          slivers: [
            if (!favoriteServices.isLoading &&
                favoriteServices.wallpapersSearchFavorite.isEmpty)
              SliverToBoxAdapter(
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          'assets/images/favoratesEmpty.png',
                          fit: BoxFit.fill,
                          width: 100,
                          height: 100,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text('No Wallpapers added to Favorites'),
                      ],
                    ),
                  ),
                ),
              ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .66, //1.5,
                  mainAxisSpacing: 1.3),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return WallpapersCart(
                    wallpaperModel:
                        favoriteServices.wallpapersSearchFavorite[index],
                  );
                },
                childCount: favoriteServices.wallpapersSearchFavorite.length,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            if (favoriteServices.isLoading &&
                favoriteServices.wallpapersSearchFavorite.isEmpty)
              SliverToBoxAdapter(
                child: Center(
                  child: SpinKitFadingCircle(
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
                ),
              ),
          ]),
    ));
  }
}
