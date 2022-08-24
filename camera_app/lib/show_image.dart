import 'dart:io';

import 'package:camera_app/after_delete.dart';
import 'package:camera_app/functions/db_functions.dart';
import 'package:camera_app/open_camer.dart';
import 'package:flutter/material.dart';

class ShowImage extends StatefulWidget {
  const ShowImage({
    Key? key,
    required this.image,
    required this.index,
  }) : super(key: key);

  final String image;
  final int index;

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 600,
                  width: 500,
                  child: Image.file(
                    File(widget.image),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: (() async {}),
                      icon: const Icon(
                        Icons.edit,
                      ),
                      label: const Text('Edit'),
                    ),
                    ElevatedButton.icon(
                      onPressed: (() async {
                        deleteImage(widget.index);
                      }),
                      icon: const Icon(
                        Icons.delete,
                      ),
                      label: const Text('Delete'),
                    ),
                    ElevatedButton.icon(
                      onPressed: (() async {}),
                      icon: const Icon(
                        Icons.share_outlined,
                      ),
                      label: const Text('Share'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteImage(index) async {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: const Text(
              'Image will be deleted permenantly.\nDo you want to continue ?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  deleteImage(index);
                  deleteImages(index);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const OpenCam(),
                    ),
                    (route) => false,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Image deleted successfully'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text('Yex'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
            ],
          );
        });
  }
}
