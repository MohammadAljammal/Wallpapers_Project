import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:josequal/model/wallpapers_model.dart';
import 'package:josequal/pages/wallpaper_pages/wallpaper_full_page.dart';
import 'package:josequal/services/favorite_servise.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class WallpaperDetailsPage extends StatefulWidget {
  final WallpaperModel wallpaperModel;

  const WallpaperDetailsPage({Key? key, required this.wallpaperModel})
      : super(key: key);

  @override
  State<WallpaperDetailsPage> createState() => _WallpaperDetailsPageState();
}

class _WallpaperDetailsPageState extends State<WallpaperDetailsPage> {
  bool isLoading = false;

  void downloadWallpaper() async {
    setState(() {
      isLoading = true;
    });
    String? message;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      final http.Response response =
          await http.get(Uri.parse(widget.wallpaperModel.src?.original ?? ''));

      final dir = await getTemporaryDirectory();

      var filename = '${dir.path}/${widget.wallpaperModel.id}.png';

      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'Image saved to disk';
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      message = 'An error occurred while saving the image';
      setState(() {
        isLoading = false;
      });
    }

    if (message != null) {
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    FavoriteServices favoriteServices = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wallpaper Details',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.25,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if ((widget.wallpaperModel.src?.original ?? '').isNotEmpty)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WallpaperFullPage(
                            url: widget.wallpaperModel.src?.original ?? ''),
                      ),
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: widget.wallpaperModel.src?.original ?? '',
                  ),
                )
              else
                Image.asset(
                  'assets/images/user_avatar.png',
                ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                          text: 'Taken by: ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      TextSpan(
                        text: widget.wallpaperModel.photographer ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      )
                    ]),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if (!favoriteServices.checkWallpaperFavorite(
                          id: widget.wallpaperModel.id!)) {
                        favoriteServices.deleteWallpaperFavorite(
                            wallpaperModel: widget.wallpaperModel);
                      } else {
                        favoriteServices.addWallpaperFavorite(
                            wallpaperModel: widget.wallpaperModel);
                      }
                    },
                    child: Icon(
                      !favoriteServices.checkWallpaperFavorite(
                              id: widget.wallpaperModel.id!)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 32,
                      color: !favoriteServices.checkWallpaperFavorite(
                              id: widget.wallpaperModel.id!)
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: SizedBox(
          height: 75,
          child: InkWell(
            onTap: isLoading ? () {} : downloadWallpaper,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: isLoading
                      ? SpinKitFadingCircle(
                          color: Theme.of(context).backgroundColor,
                          size: 25,
                        )
                      : Text(
                          'Download Wallpaper',
                          style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                ),
              ),
            ),
          )),
    );
  }
}
