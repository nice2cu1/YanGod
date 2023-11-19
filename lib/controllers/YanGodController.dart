import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class YanGodController extends GetxController {
  List<List<String>> items = [];
  int page = 0;
  bool hasMore = true;
  bool isLoading = false;

  Future<List<List<String>>> fetchItems() async {
    if (!hasMore || isLoading) return Future.value(items);

    isLoading = true;
    List<List<String>> newItems = await fetchData(page * 10, 10);
    if (newItems.length < 10) {
      hasMore = false;
    }
    items.addAll(newItems);
    page++;
    isLoading = false;
    update();
    return Future.value(items);
  }

  Future<List<List<String>>> fetchData(int start, int count) async {
    dio.Dio dioClient = dio.Dio();
    dio.Response response = await dioClient
        .get('https://yangod.nice2cu1.top/ys_home_data', queryParameters: {
      'start': start,
      'count': count,
    });
    List data = response.data;
    return data
        .map((item) => [
              item['title'].toString(),
              item['des'].toString(),
              item['url'].toString()
            ])
        .toList();
  }
}
