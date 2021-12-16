import 'package:bilibili/model/video_model.dart';

class FavoriteModel {
  FavoriteModel({
    this.total,
    this.list,
  });

  int total;
  List<VideoModel> list;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    total: json["total"],
    list: List<VideoModel>.from(json["list"].map((x) => VideoModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

