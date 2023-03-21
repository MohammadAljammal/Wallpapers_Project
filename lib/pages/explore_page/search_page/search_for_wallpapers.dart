import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:josequal/components/input/app_text_fields.dart';
import 'package:josequal/pages/wallpaper_pages/wallpapers_cart.dart';
import 'package:josequal/services/wallpapers_servise.dart';
import 'package:provider/provider.dart';

class SearchForWallpapers extends StatefulWidget {
  const SearchForWallpapers({Key? key}) : super(key: key);

  @override
  State<SearchForWallpapers> createState() => _SearchForWallpapersState();
}

class _SearchForWallpapersState extends State<SearchForWallpapers> {
  int pageNumber = 1;
  final ScrollController _scrollController = ScrollController();
  TextEditingController searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WallpapersServices wallpapersServices = Provider.of(context);

    return WillPopScope(
      onWillPop: () async {
        wallpapersServices.clearSearchResult();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Search',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                wallpapersServices.hasMoreSearch &&
                !wallpapersServices.isLoadingSearch) {
              wallpapersServices.fetchWallpapersSearch(
                  page: ++pageNumber,
                  query: searchEditingController.text.trim());
            }
            return scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                wallpapersServices.hasMoreSearch &&
                !wallpapersServices.isLoadingSearch;
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
                            controller: searchEditingController,
                            hintText: 'Search for wallpapers',
                            prefixIcon: Icons.search,
                            prefixIconColor: Colors.grey,
                            onSubmit: (value) {
                              setState(() {
                                pageNumber = 1;
                              });
                              wallpapersServices.fetchWallpapersSearch(
                                  page: pageNumber,
                                  query: value.toString().trim());
                            },
                          ))),
                ),
                if (!wallpapersServices.isLoadingSearch &&
                    wallpapersServices.wallpapersSearch.isEmpty)
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
                              'assets/images/wallpaperEmpty.png',
                              fit: BoxFit.fill,
                              width: 100,
                              height: 100,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text('Not found any Wallpapers'),
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
                            wallpapersServices.wallpapersSearch[index],
                      );
                    },
                    childCount: wallpapersServices.wallpapersSearch.length,
                  ),
                ),
                if (wallpapersServices.isLoadingSearch &&
                    wallpapersServices.wallpapersSearch.isEmpty)
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
        bottomSheet: !(wallpapersServices.isLoadingSearch &&
                wallpapersServices.wallpapersSearch.isNotEmpty)
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
      ),
    );
  }
}
