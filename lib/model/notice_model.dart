import 'banner_model.dart';

class NoticeModel {
  NoticeModel({
    this.total,
    this.list,
  });

  int total;
  List<BannerModel> list;

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
    total: json["total"],
    list: List<BannerModel>.from(json["list"].map((x) => BannerModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

