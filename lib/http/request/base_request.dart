/// 请求类型
enum HttpMethod { POST, GET, DELETE }

abstract class BaseRequest {
  /// 请求参数
  var pathParams;

  /// 是否开启https
  var useHttps = true;

  /// 域名
  String authority() {
    return "api.devio.org";
  }

  /// 请求方法
  HttpMethod httpMethod();

  /// path
  String path();

  /// url 方法
  String url() {
    Uri uri;
    var pathStr = path();

    /// 拼接 path 参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }

    /// http 与 https切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }

    print("url:${uri.toString()}");

    return uri.toString();
  }

  /// 是否需要登录
  bool needLogin();

  /// 请求参数
  Map<String, String> params = Map();

  /// 链式调用添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  /// header 鉴权
  Map<String, String> header = Map();

  /// 添加header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
