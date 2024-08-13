import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos/data/models/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    FirebaseStorage storage = FirebaseStorage.instance;
    CollectionReference refProduct =
        FirebaseFirestore.instance.collection('product');
    on<CartFetchProduct>((event, emit) async {
      try {
        QuerySnapshot querySnapshot = await refProduct.get();
        if (querySnapshot.docs.isEmpty) {
          emit(CartEmptyProduct());
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
          emit(CartLoadedProduct(productdata));
        }
      } catch (e) {
        emit(const CartFailed('Gagal Load Product'));
      }
    });
  }
}
