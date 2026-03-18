import 'package:image_picker/image_picker.dart';

class MediaService {
  final ImagePicker _picker = ImagePicker();

  String? _imagePath;

  Future<String?> _openGallery() async{
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    return file?.path;
  }

  Future<String?> _openCamera() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.camera);
    return file?.path;
  }

  Future<String?> pickImage(ImageSource source) async {
    final String? imagePath = await (source == ImageSource.gallery ? _openGallery() : _openCamera());
    _imagePath = imagePath;
    return _imagePath;
  }
}