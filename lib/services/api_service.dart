import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/image_model.dart';

class ImageService {
  // Replace with your Unsplash API key
  static const String _apiKey = 'mR9Kz2COg10kW6JNCTY8uuMLt62jqt4hFTRMeBPyOmw';
  static const String _url = 'https://api.unsplash.com/photos/random';

  // Fetch a batch of 10 images from Unsplash with pagination
  Future<List<ImageModel>> fetchImages({int page = 1}) async {
    try {
      // Modify the URL to include the page number for pagination
      final response = await http
          .get(Uri.parse('$_url?client_id=$_apiKey&count=10&page=$page'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        // Extract the URLs of the images from the API response
        return data
            .map<ImageModel>((item) => ImageModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load images');
      }
    } catch (e) {
      print('Error fetching images: $e');
      throw Exception('Error fetching images');
    }
  }
}
