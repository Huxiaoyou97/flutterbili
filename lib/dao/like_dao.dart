import 'package:bilibili/http/core/hi_net.dart';
import 'package:bilibili/http/request/base_request.dart';
import 'package:bilibili/http/request/like_request.dart';

// 点赞 取消点赞
class LikeDao {
  static like(String vid, bool isLike) async {
    BaseRequest request = isLike ? LikeRequest() : UnLikeRequest();
    request.pathParams = vid;

    var result = await HiNet.getInstance().fire(request);
    print(result);

    return result;
  }
}
