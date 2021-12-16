// To parse this JSON data, do
//
//     final demo = demoFromJson(jsonString);


import 'package:bilibili/model/video_model.dart';

class RankingModel {
  RankingModel({
    this.total,
    this.list,
  });

  int total;
  List<VideoModel> list;

  factory RankingModel.fromJson(Map<String, dynamic> json) => RankingModel(
    total: json["total"],
    list: List<VideoModel>.from(json["list"].map((x) => VideoModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

