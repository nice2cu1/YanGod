// ignore_for_file: file_names

import 'package:cupertino_modal_sheet/cupertino_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yangod/views/YanGodView.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/':
                return CupertinoModalSheetRoute(
                    settings: settings,
                    builder: (BuildContext context) {
                      return Scaffold(
                        backgroundColor: const Color(0xFFFFFFFF),
                        appBar: AppBar(
                          elevation: 0,
                          backgroundColor: const Color(0xFFFFFFFF),
                          title: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF8F9FA),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.all(10.sp),
                                          child: const Row(children: [
                                            Icon(
                                              Icons.search_rounded,
                                              color: Color.fromARGB(
                                                  255, 200, 201, 203),
                                            ),
                                            Text(
                                              "搜你所想",
                                              style: TextStyle(
                                                  color: Color(0xFFB0B4BC),
                                                  fontSize: 16),
                                            ),
                                          ])),
                                    ),
                                  ),
                                ],
                              ), // 搜索框
                              // SizedBox(height: 5.h), // 组件间隔
                              // TabBar
                            ],
                          ),
                          toolbarHeight: 120.sp,
                        ),
                        body: DefaultTabController(
                          length: 4,
                          child: Column(
                            children: [
                              TabBar(
                                splashBorderRadius: BorderRadius.circular(5.sp),
                                dividerHeight: 0,
                                indicatorSize: TabBarIndicatorSize.label,
                                tabs: [
                                  Tab(
                                      child: Text("盐神",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold))),
                                  Tab(
                                      child: Text("趣集",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold))),
                                  Tab(
                                      child: Text("盐选文库",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold))),
                                  Tab(
                                      child: Text("星球屋",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold))),
                                ],
                              ),
                              SizedBox(height: 20.sp),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25.sp),
                                        topRight: Radius.circular(25.sp),
                                      ),
                                      color: const Color(0xFFF7F9FA)),
                                  child: TabBarView(
                                    children: [
                                      YanGodView(
                                        key: PageStorageKey('YanGodView'),
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
            }
            return null;
          },
          title: '我不是盐神',
          theme: ThemeData(
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(68, 138, 255, 1)),
          ),
        );
      },
    );
  }
}
