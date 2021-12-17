import 'package:bilibili/dao/profile_dao.dart';
import 'package:bilibili/http/core/hi_error.dart';
import 'package:bilibili/model/profile_model.dart';
import 'package:bilibili/util/toast.dart';
import 'package:bilibili/util/view_util.dart';
import 'package:bilibili/widget/hi_blur.dart';
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
      // 嵌套滚动组件
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              // 扩展高度
              expandedHeight: 160,
              // 标题栏是否固定
              pinned: true,
              // 定义滚动空间
              flexibleSpace: FlexibleSpaceBar(
                // 视差滚动
                collapseMode: CollapseMode.parallax,
                titlePadding: EdgeInsets.only(left: 0),
                title: _buildHead(),
                background: Stack(
                  children: [
                    Positioned.fill(
                        child: cachedImage(
                            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fdingyue.nosdn.127.net%2Fniyp0eJFDOGDCJNzc6MmHqQWdNH7eTmk5DNN2V0xO10Ra1522867823306compressflag.jpg&refer=http%3A%2F%2Fdingyue.nosdn.127.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1642313488&t=51cb35efe546c86ab097269f19f95d2f")),
                    Positioned.fill(
                        child: HiBlur(
                      sigma: 20,
                    ))
                  ],
                ),
              ),
            )
          ];
        },
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("标题$index"),
            );
          },
          itemCount: 20,
        ),
      ),
    );
  }

  void _loadData() async {
    try {
      ProfileModel result = await ProfileDao.get();
      print(result);

      setState(() {
        _profileModel = result;
      });
    } on NeedAuth catch (e) {
      showErrorToast(e.message);
    } on HiNetError catch (e) {
      showErrorToast(e.message);
    }
  }

  _buildHead() {
    if (_profileModel == null) return Container();
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(bottom: 30, left: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: cachedImage(_profileModel.face, width: 46, height: 46),
          ),
          hiSpace(width: 8),
          Text(
            _profileModel.name,
            style: const TextStyle(fontSize: 11, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
