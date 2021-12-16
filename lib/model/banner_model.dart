
class BannerModel {
  BannerModel({
    this.id,
    this.sticky,
    this.type,
    this.title,
    this.subtitle,
    this.url,
    this.cover,
    this.createTime,
  });

  String id;
  int sticky;
  String type;
  String title;
  String subtitle;
  String url;
  String cover;
  String createTime;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    id: json["id"],
    sticky: json["sticky"],
    type: json["type"],
    title: json["title"],
    subtitle: json["subtitle"],
    url: json["url"],
    cover: json["cover"],
    createTime: json["createTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sticky": sticky,
    "type": type,
    "title": title,
    "subtitle": subtitle,
    "url": url,
    "cover": cover,
    "createTime": createTime,
  };
}
