import 'package:bilibili/http/core/hi_net.dart';
import 'package:bilibili/http/request/base_request.dart';
import 'package:bilibili/http/request/cancel_favorite_request.dart';
import 'package:bilibili/http/request/favorite_request.dart';
import 'package:bilibili/http/request/my_favorites_request.dart';
import 'package:bilibili/model/favorite_model.dart';

class FavoriteDao {
  static favorite(String vid, bool favorite) async {
    BaseRequest request =
        favorite ? FavoriteRequest() : CancelFavoriteRequest();

    request.pathParams = vid;

    var result = await HiNet.getInstance().fire(request);
    print(result);

    return result;
  }

  static favorites({int pageIndex = 1, pageSize = 10}) async {
    BaseRequest request = MyFavoritesRequest();
    request.add("pageIndex", pageIndex).add("pageSize", pageSize);

    var result = await HiNet.getInstance().fire(request);
    print(result);

    return FavoriteModel.fromJson(result["data"]);
  }
}
