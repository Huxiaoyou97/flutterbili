import 'package:bilibili/db/hi_cache.dart';
import 'package:bilibili/http/core/hi_net.dart';
import 'package:bilibili/http/request/base_request.dart';
import 'package:bilibili/http/request/login_request.dart';
import 'package:bilibili/http/request/register_request.dart';

class LoginDao {
  static const BOARDING_PASS = "boarding-pass";

  static login(String userName, String password) {
    return _send(userName, password);
  }

  static register(
      String userName, String password, String imoocId, String orderId) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(String userName, password, {imoocId, orderId}) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegisterRequest();
    } else {
      request = LoginRequest();
    }

    request
        .add("userName", userName)
        .add("password", password)
        .add("imoocId", imoocId ?? "")
        .add("orderId", orderId ?? "");

    var result = await HiNet.getInstance().fire(request);

    if (result["code"] == 0 && result["data"] != null) {
      // 保存登录令牌
      HiCache.getInstance().setString(BOARDING_PASS, result["data"]);
    }
    return result;
  }

  static getBoardingPass() {
    print(HiCache.getInstance().get(BOARDING_PASS));
    return HiCache.getInstance().get(BOARDING_PASS);
  }
}
