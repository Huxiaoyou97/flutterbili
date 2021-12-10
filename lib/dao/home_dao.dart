import 'package:bilibili/http/core/hi_net.dart';
import 'package:bilibili/http/request/home_request.dart';
import 'package:bilibili/model/home_model.dart';

/// 首页接口
class HomeDao {
  static get(String categoryName, {int pageIndex = 1, int pageSize = 1}) async {
    HomeRequest request = HomeRequest();

    request.pathParams = categoryName;
    request.add("pageIndex", pageIndex).add("pageSize", pageSize);

    var result = await HiNet.getInstance().fire(request);
    return HomeModel.fromJson(result["data"]);
  }
}
