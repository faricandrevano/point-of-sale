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
            emit(ProductSuccess(message: 'Sukses Update Image', event: event));
            emit(
              ProductImageLoaded(updatedImages),
            );
          } else {
            emit(
                ProductSuccess(message: 'Sukses Adding 1 Image', event: event));
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
        emit(ProductSuccess(message: 'Sukses delete Image', event: event));
        emit(ProductImageLoaded(data));
      } catch (e) {
        emit(const ProductFailed('Gagal Hapus Image'));
      }
    });

    on<ProductAdded>((event, emit) async {
      try {
        if (state is ProductImageLoaded) {
          final currentState = state as ProductImageLoaded;
          emit(ProductLoading());
          await refProduct.add(event.data.toMap());
          for (var image in currentState.images) {
            await storage
                .ref()
                .child('product_images')
                .child(event.data.sku)
                .child((Random().nextInt(99) * 99).toString())
                .putFile(File(image.path));
          }
          emit(const ProductUploadData("Sukses Simpan Product"));
        } else {
          emit(const ProductFailed('Image product dibutuhkan'));
        }
      } catch (e) {
        emit(const ProductFailed('Gagal Simpan Product'));
      }
    });
    on<ProductFetch>((event, emit) async {
      try {
        QuerySnapshot querySnapshot = await refProduct.get();
        if (querySnapshot.docs.isEmpty) {
          emit(ProductEmpty());
        } else {
          List<ProductModel> productdata =
              await Future.wait(querySnapshot.docs.map((doc) async {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            final imagesRef = storage
                .ref()
                .child('product_images')
                .child(data['sku'].toString());

            final ListResult result = await imagesRef.listAll();

            List<String> imageUrls = await Future.wait(
                result.items.map((ref) => ref.getDownloadURL()));

            data['images'] = imageUrls;
            data['id'] = doc.id;

            return ProductModel.fromJson(data);
          }));
          emit(ProductLoaded(productdata));
        }
      } catch (e) {
        emit(const ProductFailed('Gagal Load Product'));
      }
    });
    on<ProductDelete>((event, emit) async {
      try {
        await refProduct.doc(event.id).delete();
        final refImage = await storage
            .ref()
            .child('product_images')
            .child(event.sku.toString())
            .listAll();
        for (var image in refImage.items) {
          await image.delete();
        }
        emit(ProductSuccess(message: 'Product Sukses delete', event: event));
      } catch (e) {
        emit(const ProductFailed('Gagal hapus Product'));
      }
    });
  }
}
