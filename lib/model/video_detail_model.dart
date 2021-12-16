// To parse this JSON data, do
//
//     final demo = demoFromJson(jsonString);

import 'dart:convert';

import 'package:bilibili/model/video_model.dart';

class VideoDetailModel {
  VideoDetailModel({
    this.isFavorite,
    this.isLike,
    this.videoInfo,
    this.videoList,
  });

  bool isFavorite;
  bool isLike;
  VideoModel videoInfo;
  List<VideoModel> videoList;

  factory VideoDetailModel.fromJson(Map<String, dynamic> json) => VideoDetailModel(
        isFavorite: json["isFavorite"],
        isLike: json["isLike"],
        videoInfo: VideoModel.fromJson(json["videoInfo"]),
        videoList:
            List<VideoModel>.from(json["videoList"].map((x) => VideoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isFavorite": isFavorite,
        "isLike": isLike,
        "videoInfo": videoInfo.toJson(),
        "videoList": List<dynamic>.from(videoList.map((x) => x.toJson())),
      };
}



enum Tname { EMPTY }

final tnameValues = EnumValues({"鬼畜调教": Tname.EMPTY});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
