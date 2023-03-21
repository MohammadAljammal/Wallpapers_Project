import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:josequal/model/wallpapers_model.dart';
import 'package:josequal/pages/wallpaper_pages/wallpaper_details_page.dart';

class WallpapersCart extends StatelessWidget {
  final WallpaperModel wallpaperModel;

  const WallpapersCart({Key? key, required this.wallpaperModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  WallpaperDetailsPage(wallpaperModel: wallpaperModel),
            ),
          );
        },
        child: Container(
          color: const Color(0xffFAFAFC),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: (wallpaperModel.src?.original ?? '').isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: wallpaperModel.src?.original ?? '',
                      )
                    : Image.asset(
                        'assets/images/user_avatar.png',
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Taken by",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                      Text(
                        wallpaperModel.photographer ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
