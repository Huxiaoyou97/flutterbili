class TestMo {
  TestMo({
    this.id,
    this.vid,
    this.title,
    this.tname,
    this.url,
    this.cover,
    this.pubdate,
    this.desc,
    this.view,
    this.duration,
    this.owner,
    this.reply,
    this.favorite,
    this.like,
    this.coin,
    this.share,
    this.createTime,
    this.size,
  });

  String? id;
  String? vid;
  String? title;
  String? tname;
  String? url;
  String? cover;
  int? pubdate;
  String? desc;
  int? view;
  int? duration;
  Owner? owner;
  int? reply;
  int? favorite;
  int? like;
  int? coin;
  int? share;
  DateTime? createTime;
  int? size;

  factory TestMo.fromJson(Map<String, dynamic> json) => TestMo(
        id: json["id"],
        vid: json["vid"],
        title: json["title"],
        tname: json["tname"],
        url: json["url"],
        cover: json["cover"],
        pubdate: json["pubdate"],
        desc: json["desc"],
        view: json["view"],
        duration: json["duration"],
        owner: Owner.fromJson(json["owner"]),
        reply: json["reply"],
        favorite: json["favorite"],
        like: json["like"],
        coin: json["coin"],
        share: json["share"],
        createTime: DateTime.parse(json["createTime"]),
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vid": vid,
        "title": title,
        "tname": tname,
        "url": url,
        "cover": cover,
        "pubdate": pubdate,
        "desc": desc,
        "view": view,
        "duration": duration,
        "owner": owner?.toJson(),
        "reply": reply,
        "favorite": favorite,
        "like": like,
        "coin": coin,
        "share": share,
        "createTime": createTime?.toIso8601String(),
        "size": size,
      };
}

class Owner {
  Owner({
    this.name,
    this.face,
    this.fans,
  });

  String? name;
  String? face;
  int? fans;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        name: json["name"],
        face: json["face"],
        fans: json["fans"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "face": face,
        "fans": fans,
      };
}
