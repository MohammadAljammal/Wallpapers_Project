class WallpaperModel {
  int? id;
  int? width;
  int? height;
  String? url;
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  String? avgColor;
  Src? src;
  dynamic liked;
  String? alt;

  WallpaperModel(
      {this.id,
      this.width,
      this.height,
      this.url,
      this.photographer,
      this.photographerUrl,
      this.photographerId,
      this.avgColor,
      this.src,
      this.liked,
      this.alt});

  WallpaperModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    photographer = json['photographer'];
    photographerUrl = json['photographer_url'];
    photographerId = json['photographer_id'];
    avgColor = json['avg_color'];
    src = json['src'] != null ? Src.fromJson(json['src']) : null;
    liked = json['liked'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['width'] = width;
    data['height'] = height;
    data['url'] = url;
    data['photographer'] = photographer;
    data['photographer_url'] = photographerUrl;
    data['photographer_id'] = photographerId;
    data['avg_color'] = avgColor;
    if (src != null) {
      data['src'] = src!.toJson();
    }
    data['liked'] = liked;
    data['alt'] = alt;
    return data;
  }

  WallpaperModel.fromJsonSql(Map<String, dynamic> json) {
    id = json['id'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    photographer = json['photographer'];
    photographerUrl = json['photographer_url'];
    photographerId = json['photographer_id'];
    avgColor = json['avg_color'];
    final Map<String, dynamic> srcData = <String, dynamic>{
      'original': json['original'],
      'large2x': json['large2x'],
      'large': json['large'],
      'medium': json['medium'],
      'small': json['small'],
      'portrait': json['portrait'],
      'landscape': json['landscape'],
      'tiny': json['tiny']
    };
    src = Src.fromJson(srcData);
    liked = json['liked'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJsonSql() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['width'] = width;
    data['height'] = height;
    data['url'] = url;
    data['photographer'] = photographer;
    data['photographer_url'] = photographerUrl;
    data['photographer_id'] = photographerId;
    data['avg_color'] = avgColor;
    if (src != null) {
      data['original'] = src!.original;
      data['large2x'] = src!.large2x;
      data['large'] = src!.large;
      data['medium'] = src!.medium;
      data['small'] = src!.small;
      data['portrait'] = src!.portrait;
      data['landscape'] = src!.landscape;
      data['tiny'] = src!.tiny;
    }
    data['liked'] = liked.toString();
    data['alt'] = alt;
    return data;
  }
}

class Src {
  String? original;
  String? large2x;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  String? landscape;
  String? tiny;

  Src(
      {this.original,
      this.large2x,
      this.large,
      this.medium,
      this.small,
      this.portrait,
      this.landscape,
      this.tiny});

  Src.fromJson(Map<String, dynamic> json) {
    original = json['original'] ?? '';
    large2x = json['large2x'] ?? '';
    large = json['large'] ?? '';
    medium = json['medium'] ?? '';
    small = json['small'] ?? '';
    portrait = json['portrait'] ?? '';
    landscape = json['landscape'] ?? '';
    tiny = json['tiny'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['original'] = original;
    data['large2x'] = large2x;
    data['large'] = large;
    data['medium'] = medium;
    data['small'] = small;
    data['portrait'] = portrait;
    data['landscape'] = landscape;
    data['tiny'] = tiny;
    return data;
  }
}
