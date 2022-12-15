class Photo {
  int? id;
  int? width;
  int? height;
  String? url;
  String? photographer;
  String? photographerurl;
  int? photographerid;
  String? avgcolor;
  Src? src;
  bool? liked;
  String? alt;

  Photo({this.id, this.width, this.height, this.url, this.photographer, this.photographerurl, this.photographerid, this.avgcolor, this.src, this.liked, this.alt});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    photographer = json['photographer'];
    photographerurl = json['photographer_url'];
    photographerid = json['photographer_id'];
    avgcolor = json['avg_color'];
    src = json['src'] != null ? Src?.fromJson(json['src']) : null;
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
    data['photographer_url'] = photographerurl;
    data['photographer_id'] = photographerid;
    data['avg_color'] = avgcolor;
    data['src'] = src!.toJson();
    data['liked'] = liked;
    data['alt'] = alt;
    return data;
  }
}

class ImageData {
  int? page;
  int? perpage;
  List<Photo?>? photos;
  int? totalresults;
  String? nextpage;
  String? error;

  ImageData({
    this.page,
    this.perpage,
    this.photos,
    this.totalresults,
    this.nextpage,
    this.error,
  });

  // ImageData.copyWith({this.page}) {
  //   return ImageData(page: this.page);
  // }

  ImageData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perpage = json['per_page'];
    if (json['photos'] != null) {
      photos = <Photo>[];
      json['photos'].forEach((v) {
        photos!.add(Photo.fromJson(v));
      });
    }
    totalresults = json['total_results'];
    nextpage = json['next_page'];
    // error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perpage;
    data['photos'] = photos != null ? photos!.map((v) => v?.toJson()).toList() : null;
    data['total_results'] = totalresults;
    data['next_page'] = nextpage;
    // data['error'] = error;
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

  Src({this.original, this.large2x, this.large, this.medium, this.small, this.portrait, this.landscape, this.tiny});

  Src.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    large2x = json['large2x'];
    large = json['large'];
    medium = json['medium'];
    small = json['small'];
    portrait = json['portrait'];
    landscape = json['landscape'];
    tiny = json['tiny'];
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
