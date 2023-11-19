import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/ContentController.dart';

class ContentView extends StatelessWidget {
  final List<String> data;
  final String type;
  final ContentController controller = Get.put(ContentController());
  Offset? _dragStart;
  ContentView({Key? key, required this.data, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.fetchData(data[2], type);
    return GestureDetector(
        onHorizontalDragStart: (details) {
          _dragStart = details.globalPosition;
        },
        onHorizontalDragEnd: (details) {
          if (_dragStart != null &&
              details.velocity.pixelsPerSecond.dx > 0 &&
              _dragStart!.dx < MediaQuery.of(context).size.width / 2) {
            Navigator.pop(context);
          } else if (_dragStart != null &&
              details.velocity.pixelsPerSecond.dx < 0 &&
              _dragStart!.dx > MediaQuery.of(context).size.width / 2) {
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(18.sp, 10.sp, 8.sp, 8.sp),
                    child: Text(
                      data[0],
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24.sp),
                    )),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Obx(
                    () => Text(
                      controller.responseText.value,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
