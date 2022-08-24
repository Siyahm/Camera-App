import 'package:camera_app/model/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<ImageModel>> ImageListNotifier = ValueNotifier([]);

Future<void> getImage(ImageModel vlaue) async {
  final imageDB = await Hive.openBox<ImageModel>('image_db');
  await imageDB.add(vlaue);
  ImageListNotifier.value.add(vlaue);
  ImageListNotifier.notifyListeners();
}

Future<void> createDB() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(
    ImageModelAdapter().typeId,
  )) {
    Hive.registerAdapter(
      ImageModelAdapter(),
    );
  }
}

Future<void> getAllImages() async {
  final imageDB = await Hive.openBox<ImageModel>('image_db');
  ImageListNotifier.value.clear();
  ImageListNotifier.value.addAll(imageDB.values);
  ImageListNotifier.notifyListeners();
}

Future<void> deleteImages(int index) async {
  final imageDB = await Hive.openBox<ImageModel>('image_db');
  await imageDB.deleteAt(index);
  getAllImages();
}
