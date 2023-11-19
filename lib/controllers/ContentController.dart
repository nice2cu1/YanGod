import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ContentController extends GetxController {
  var responseText = ''.obs;

  void fetchData(String data, String type) async {
    var dio = Dio();
    try {
      switch (type) {
        case 'yangod':
          var response = await dio.post(
            'https://yangod.nice2cu1.top/ys_article_data',
            data: data,
          );
          responseText.value = response.data;
      }
    } catch (e) {
      print(e);
    }
  }
}
