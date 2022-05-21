import 'package:image_picker/image_picker.dart';

class ImageFunctions {
  Future<XFile?> imageFromGalary() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    return image;
  }

  Future<XFile?> imageFromCamera() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return null;
    return image;
  }

  Future<List<XFile>?> selectMultiImages() async {
    final List<XFile>? images = await ImagePicker().pickMultiImage();
    if (images == null) return null;
    return images;
  }
}
