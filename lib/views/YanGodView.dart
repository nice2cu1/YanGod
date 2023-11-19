import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:yangod/views/ContentView.dart';
import '../anim/flutter_staggered_animations.dart';
import '../controllers/YanGodController.dart';
import 'package:cupertino_modal_sheet/cupertino_modal_sheet.dart';

class YanGodView extends StatelessWidget {
  final YanGodController controller;
  final ScrollController scrollController;
  bool isInitialLoad;

  YanGodView({Key? key})
      : controller = Get.put(YanGodController()),
        scrollController = ScrollController(keepScrollOffset: true),
        isInitialLoad = true,
        super(key: key) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !controller.isLoading &&
          controller.hasMore) {
        isInitialLoad = false;
        controller.fetchItems();
      }
    });
    controller.fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<YanGodController>(
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {
            controller.page = 0;
            controller.items.clear();
            isInitialLoad = true;
            await controller.fetchItems();
            isInitialLoad = false;
          },
          child: controller.items.isEmpty && isInitialLoad
              ? Center(
                  child: Lottie.asset('assets/anim/RefreshAnim.json'),
                )
              : Center(
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount:
                        controller.items.length + (controller.hasMore ? 1 : 0),
                    separatorBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 330),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(15.sp, 0, 15.sp, 10.sp),
                              child: Container(
                                decoration: DottedDecoration(
                                    shape: Shape.line,
                                    linePosition: LinePosition.bottom,
                                    strokeWidth: 2),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemBuilder: (context, index) {
                      if (index >= controller.items.length) {
                        if (controller.hasMore) {
                          controller.fetchItems();
                          return isInitialLoad
                              ? Lottie.asset('assets/anim/RefreshAnim.json')
                              : Lottie.asset('assets/anim/RefreshAnim.json');
                        } else {
                          return const SizedBox.shrink(
                            child: Text("data"),
                          );
                        }
                      } else {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 330),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: ListTile(
                                title: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0, 10.sp, 0, 5.sp),
                                  child: Text(
                                    controller.items[index][0],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0, 10.sp, 0, 10.sp),
                                  child: Text(
                                    controller.items[index][1],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                ),
                                onTap: () {
                                  showCupertinoModalSheet(
                                    context: context,
                                    builder: (context) => ContentView(
                                        data: controller.items[index],
                                        type: "yangod"),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
        );
      },
    );
  }

  onItemClick(String p1) {}
}
