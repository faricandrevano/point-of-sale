import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'dart:io';

import 'package:pos/presentation/constants/styles.dart';

class CustomMultiImage extends StatefulWidget {
  const CustomMultiImage({super.key});
  @override
  State<CustomMultiImage> createState() => _CustomMultiImageState();
}

class _CustomMultiImageState extends State<CustomMultiImage> {
  List<File> images = [];
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        images.add(File(pickedFile.path));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Photo Product',
          style: bodyL.copyWith(
            fontWeight: semiBold,
            color: neutral90,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Recommended minimum width 1080px X 1080px, with a max size of 5MB. *.png, *.jpg and *.jpeg image files are accepted.',
            style: bodyM.copyWith(
              color: neutral50,
              fontWeight: regular,
            ),
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const ScrollPhysics(),
            itemCount: images.length + 1,
            itemBuilder: (context, index) {
              if (index == images.length) {
                return GestureDetector(
                  onTap: getImage,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      border: Border.all(color: neutral40),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.blue, size: 40),
                        Text('Add image', style: TextStyle(color: Colors.blue)),
                        Text('or Drop Image to Upload',
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Stack(
                  children: [
                    Image.file(
                      images[index],
                      fit: BoxFit.cover,
                      width: 160,
                      height: 160,
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            images.removeAt(index);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
