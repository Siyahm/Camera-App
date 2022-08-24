import 'dart:io';
import 'dart:ui';

import 'package:camera_app/functions/db_functions.dart';
import 'package:camera_app/model/data_model.dart';
import 'package:camera_app/open_camer.dart';
import 'package:camera_app/show_image.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class Deleted extends StatefulWidget {
  const Deleted({Key? key}) : super(key: key);

  @override
  State<Deleted> createState() => _DeletedState();
}

class _DeletedState extends State<Deleted> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getAllImages();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        centerTitle: true,
        leading: IconButton(
          onPressed: (() => const OpenCam()),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: ImageListNotifier,
        builder:
            (BuildContext context, List<ImageModel> imageList, Widget? child) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: imageList.isEmpty
                ? const Center(
                    child: Text('No Image'),
                  )
                : Expanded(
                    child: SizedBox(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 3,
                                mainAxisSpacing: 3),
                        itemCount: imageList.length,
                        itemBuilder: (cotex, index) {
                          return InkWell(
                            child: Image.file(
                              File(
                                imageList[index].image,
                              ),
                              fit: BoxFit.fill,
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ShowImage(
                                    image: imageList[index].image,
                                    index: index,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  File? _image;

  void openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    } else {
      final imageTemp = File(image.path);
      setState(() {
        _image = imageTemp;
      });
    }
    final camera = ImageModel(
      image: _image!.path,
    );
    await getImage(
      camera,
    );
  }
}
