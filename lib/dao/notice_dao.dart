import 'package:bilibili/http/core/hi_net.dart';
import 'package:bilibili/http/request/base_request.dart';
import 'package:bilibili/http/request/notice_request.dart';
import 'package:bilibili/model/notice_model.dart';

class NoticeDao {
  static get({int pageIndex = 1, pageSize = 10}) async {
    BaseRequest request = NoticeRequest();

    request.add("pageIndex", pageIndex).add("pageSize", pageSize);

    var result = await HiNet.getInstance().fire(request);
    print(result);
    return NoticeModel.fromJson(result["data"]);
  }
}
