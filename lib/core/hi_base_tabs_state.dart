// 列表常驻缓存 AutomaticKeepAliveClientMixin
import 'package:bilibili/core/hi_state.dart';
import 'package:bilibili/http/core/hi_error.dart';
import 'package:bilibili/util/color.dart';
import 'package:bilibili/util/toast.dart';
import 'package:bilibili/widget/loading_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 通用底层带分页和刷新的页面框架
// M 作为 Dao 返回数据模型， L为列表数据模型， T为具体widget
abstract class HiBaseTabState<M, L, T extends StatefulWidget> extends HIState<T>
    with AutomaticKeepAliveClientMixin {
  List<L> dataList = [];

  final ScrollController scrollController = ScrollController();

  int pageIndex = 1;

  bool loading = false;

  get contentChild;

  bool _isLoading = true;

  bool flag = true; //默认可以请求

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      var dis = scrollController.position.maxScrollExtent -
          scrollController.position.pixels;
      // print("dis:$dis");
      // 当距离底部不足300时 加载更多
      if (dis < 300 &&
          !loading &&
          // fix 当列表高度不满屏幕高度时不执行加载更多
          scrollController.position.maxScrollExtent != 0) {
        loadData(loadMore: true);
      }
    });
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // 使用mixin 请调用super 否则会有警告出现
    return RefreshIndicator(
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: contentChild,
      ),
      onRefresh: loadData,
      color: primary,
    );
  }

  // 获取对应页码的数据
  Future<M> getData(int pageIndex);

  // 从 MO 中解析list数据
  List<L> parseList(M result);

  Future loadData({loadMore = false}) async {
    if (loading) {
      print("上次加载还没完成...");
      return;
    }

    loading = true;
    if (!loadMore) {
      pageIndex = 1;
    }

    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    print("currentIndex---$currentIndex");
    try {
      var result = await getData(currentIndex);

      setState(() {
        if (loadMore) {
          // 合成新数组
          dataList = [...dataList, ...parseList(result)];
          if (parseList(result).isNotEmpty) {
            pageIndex++;
          }
        } else {
          dataList = parseList(result);
        }
      });

      Future.delayed(const Duration(milliseconds: 1000), () {
        loading = false;
      });
    } on NeedAuth catch (e) {
      loading = false;
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      loading = false;
      print(e);
      showWarnToast(e.message);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
