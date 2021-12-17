import 'package:bilibili/http/core/hi_net.dart';
import 'package:bilibili/http/request/base_request.dart';
import 'package:bilibili/http/request/profile_request.dart';
import 'package:bilibili/model/profile_model.dart';

class ProfileDao {
  static get() async {
    ProfileRequest request = ProfileRequest();

    var result = await HiNet.getInstance().fire(request);
    print(result);
    return ProfileModel.fromJson(result['data']);
  }
}
