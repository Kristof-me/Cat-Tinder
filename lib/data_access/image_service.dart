import 'package:cat_tinder/data_access/cat_information.dart';
import 'package:dio/dio.dart';

class ImageService {
  final dio = Dio();
  final int limit = 10;
  final String base = 'https://cataas.com';

  Future<List<CatInformation>> getImages() {
    return dio.get('$base/api/cats?limit=$limit').then((response) {
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(response.data);

      List<CatInformation> cats = [];

      for (Map<String, dynamic> info in data) {
        String id = info['_id'] as String;
        List<String> tags = [];

        if (info.keys.contains('tags')) {
          tags = List<String>.from(info['tags']);
          
        }

        cats.add(CatInformation(
          id: id,
          imageUrl: '$base/cat/$id',
          tags: tags
        ));
      }

      return cats;
    });
  }
}
