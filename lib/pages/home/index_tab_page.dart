
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

import '../history/history_page.dart';
import '../history/logic.dart';
import '../set/set_page.dart';
import 'home_page.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreenPage> with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LazyLoadIndexedStack(
        index: currentIndex,
        children:  const [HomePage(), HistoryPage(), SetPage()],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Image.asset("assets/images/ic_home.png",
              width: 22.w,
              excludeFromSemantics: true, //去除图片语义
              gaplessPlayback: true),
          activeIcon: Image.asset("assets/images/ic_home_s.png",
              width: 22.w,
              excludeFromSemantics: true, //去除图片语义
              gaplessPlayback: true),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/images/ic_his.png",
              width: 22.w,
              excludeFromSemantics: true, //去除图片语义
              gaplessPlayback: true),
          activeIcon: Image.asset("assets/images/ic_his_s.png",
              width: 22.w,
              excludeFromSemantics: true, //去除图片语义
              gaplessPlayback: true),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/images/ic_set.png",
              width: 22.w,
              excludeFromSemantics: true, //去除图片语义
              gaplessPlayback: true),
          activeIcon: Image.asset("assets/images/ic_set_s.png",
              width: 22.w,
              excludeFromSemantics: true, //去除图片语义
              gaplessPlayback: true),
          label: 'Other',
        ),
      ],
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
          if(currentIndex ==1){
            HistoryLogic.to.getList();
          }
        });
      },
    );
  }
}
