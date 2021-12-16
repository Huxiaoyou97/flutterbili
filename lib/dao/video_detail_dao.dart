import 'package:bilibili/http/core/hi_net.dart';
import 'package:bilibili/http/request/video_detail_request.dart';
import 'package:bilibili/model/video_detail_model.dart';

/// 详情页 dao
class VideoDetailDao {
  static get(String vid) async {
    VideoDetailRequest request = VideoDetailRequest();
    request.pathParams = vid;

    var result = await HiNet.getInstance().fire(request);

    print(result);
    return VideoDetailModel.fromJson(result["data"]);
  }
}
