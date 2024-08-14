import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pos/data/models/product_model.dart';

part 'cashier_event.dart';
part 'cashier_state.dart';

class CashierBloc extends Bloc<CashierEvent, CashierState> {
  CashierBloc() : super(CashierInitial()) {
    CollectionReference refProduct =
        FirebaseFirestore.instance.collection('product');
    FirebaseStorage storage = FirebaseStorage.instance;

    on<CashierFetchProduct>((event, emit) async {
      try {
        QuerySnapshot querySnapshot = await refProduct.get();
        if (querySnapshot.docs.isEmpty) {
          emit(CashierEmptyProduct());
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
          emit(CashierLoadedProduct(productdata));
        }
      } catch (e) {
        emit(const CashierFailed('Gagal Load Product'));
      }
    });
  }
}
