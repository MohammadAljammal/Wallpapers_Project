import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:josequal/components/input/app_text_fields.dart';
import 'package:josequal/pages/explore_page/search_page/search_for_wallpapers.dart';
import 'package:josequal/pages/wallpaper_pages/wallpapers_cart.dart';
import 'package:josequal/services/favorite_servise.dart';
import 'package:josequal/services/wallpapers_servise.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({
    super.key,
  });

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final ScrollController _scrollController = ScrollController();
  int pageNumber = 1;

  @override
  Widget build(BuildContext context) {
    WallpapersServices wallpapersServices = Provider.of(context);
    FavoriteServices favoriteServices = Provider.of(context);

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              wallpapersServices.hasMore &&
              !wallpapersServices.isLoading) {
            wallpapersServices.fetchWallpapers(page: ++pageNumber);
          }
          return scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent &&
              wallpapersServices.hasMore &&
              !wallpapersServices.isLoading;
        },
        child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                    height: 100,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: AppTextField(
                          controller: TextEditingController(),
                          hintText: 'Search for wallpapers',
                          readOnly: true,
                          prefixIcon: Icons.search,
                          prefixIconColor: Colors.grey,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SearchForWallpapers(),
                              ),
                            );
                          },
                        ))),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .66, //1.5,
                    mainAxisSpacing: 1.3),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return WallpapersCart(
                      wallpaperModel: wallpapersServices.wallpapers[index],
                    );
                  },
                  childCount: wallpapersServices.wallpapers.length,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              if (wallpapersServices.isLoading &&
                  wallpapersServices.wallpapers.isEmpty)
                SliverToBoxAdapter(
                  child: Center(
                    child: SpinKitFadingCircle(
                      color: Theme.of(context).primaryColor,
                      size: 25,
                    ),
                  ),
                ),
            ]),
      ),
      bottomSheet: !(wallpapersServices.isLoading &&
              wallpapersServices.wallpapers.isNotEmpty)
          ? const SizedBox(
              height: 0,
            )
          : SizedBox(
              height: 100,
              child: Center(
                child: SpinKitFadingCircle(
                  color: Theme.of(context).primaryColor,
                  size: 25,
                ),
              ),
            ),
    );
  }
}
