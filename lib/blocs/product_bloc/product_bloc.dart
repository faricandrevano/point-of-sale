import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    final picker = ImagePicker();
    final CollectionReference refProduct =
        FirebaseFirestore.instance.collection('product');
    final FirebaseStorage storage = FirebaseStorage.instance;
    on<ProductPickedImage>((event, emit) async {
      try {
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          if (state is ProductImageLoaded) {
            final currentState = state as ProductImageLoaded;
            final updatedImages = List<File>.from(currentState.images)
              ..add(File(pickedFile.path));
            emit(const ProductSuccess('Sukses Update Image'));
            emit(
              ProductImageLoaded(updatedImages),
            );
          } else {
            emit(const ProductSuccess('Sukses Adding 1 Image'));
            emit(
              ProductImageLoaded([File(pickedFile.path)]),
            );
          }
        }
      } catch (e) {
        emit(const ProductFailed('Gagal Upload Image'));
      }
    });
    on<ProductRemoveImage>((event, emit) {
      try {
        final data = (state as ProductImageLoaded).images;
        data.removeAt(event.index);
        emit(const ProductSuccess('Sukses delete Image'));
        emit(ProductImageLoaded(data));
      } catch (e) {
        emit(const ProductFailed('Gagal Hapus Image'));
      }
    });

    on<ProductAdded>((event, emit) async {
      try {
        if (state is ProductImageLoaded) {
          emit(ProductLoading());
          await refProduct.add(event.data.toMap());
          final currentState = state as ProductImageLoaded;
          for (var image in currentState.images) {
            await storage
                .ref()
                .child('proudct_images')
                .child(event.data.sku)
                .child((Random().nextInt(99) * 99).toString())
                .putFile(File(image.path));
          }
          emit(const ProductUploadData("Sukses Simpan Product"));
        } else {
          emit(const ProductFailed('Image product dibutuhkan'));
        }
      } catch (e) {
        print(e.toString());
        emit(const ProductFailed('Gagal Simpan Product'));
      }
    });
  }
}
