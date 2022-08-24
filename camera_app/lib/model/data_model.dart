import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class ImageModel {
  @HiveField(0)
  late final String image;

  ImageModel({required this.image});
}
