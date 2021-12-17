import 'package:bilibili/dao/profile_dao.dart';
import 'package:bilibili/http/core/hi_error.dart';
import 'package:bilibili/model/profile_model.dart';
import 'package:bilibili/util/toast.dart';
import 'package:flutter/material.dart';


 /// 我的
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  ProfileModel _profileModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text("我的"),
      ),
    );
  }

  void _loadData() async {
    try {
      ProfileModel result = ProfileDao.get();
      print(result);

      setState(() {
        _profileModel = result;
      });
    } on NeedAuth catch(e) {
      showErrorToast(e.message);
    } on HiNetError catch(e) {
      showErrorToast(e.message);
    }
  }
}
