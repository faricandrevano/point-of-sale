import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/blocs/product_bloc/product_bloc.dart';
import 'package:pos/presentation/constants/colors.dart';

import 'package:pos/presentation/constants/styles.dart';

class CustomMultiImage extends StatefulWidget {
  const CustomMultiImage({super.key});
  @override
  State<CustomMultiImage> createState() => _CustomMultiImageState();
}

class _CustomMultiImageState extends State<CustomMultiImage> {
  // List<File> images = [];
  // final picker = ImagePicker();

  // Future getImage() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       images.add(File(pickedFile.path));
  //     }
  //   });
  // }
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
        BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            List data = [];
            if (state is ProductImageLoaded) {
              data = state.images;
              return SizedBox(
                height: 160,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const ScrollPhysics(),
                  // itemCount: images.length + 1,
                  itemCount: data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == data.length) {
                      return GestureDetector(
                        // onTap: getImage,
                        onTap: () => context
                            .read<ProductBloc>()
                            .add(ProductPickedImage()),
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
                              Text('Add image',
                                  style: TextStyle(color: Colors.blue)),
                              Text('or Drop Image to Upload',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
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
                            data[index],
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
                                  context
                                      .read<ProductBloc>()
                                      .add(ProductRemoveImage(index));
                                  // images.removeAt(index);
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
              );
            }
            return SizedBox(
              height: 160,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                itemCount: data.length + 1,
                itemBuilder: (context, index) {
                  if (index == data.length) {
                    return GestureDetector(
                      onTap: () =>
                          context.read<ProductBloc>().add(ProductPickedImage()),
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
                            Text('Add image',
                                style: TextStyle(color: Colors.blue)),
                            Text('or Drop Image to Upload',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
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
                          data[index],
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
                                context
                                    .read<ProductBloc>()
                                    .add(ProductRemoveImage(index));
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
            );
          },
        ),
      ],
    );
  }
}
