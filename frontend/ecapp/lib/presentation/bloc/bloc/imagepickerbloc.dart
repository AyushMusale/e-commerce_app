import 'dart:io';

import 'package:ecapp/presentation/bloc/events/imagepickerevent.dart';
import 'package:ecapp/presentation/bloc/state/imagestate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Imagepickerbloc extends Bloc<Imagepickerevent, ImageState> {
  final ImagePicker picker = ImagePicker();
  Imagepickerbloc() : super(ImagestateInitial()) {
    on<Imagepickerevent>((event, emit) async {
      try{
        final File? file = await pickImage();
        if (file == null) {
          return;
        }
        List<File> currentImages = [];
        if (state is ImagestateSuccess) {
          currentImages = List.from((state as ImagestateSuccess).imageUrl);
        }
        currentImages.add(file);
        emit(ImagestateSuccess(imageUrl: currentImages));
      }
      catch(e){
        emit(ImagestateFailure(message: e.toString()));
      }
    });
  }

  Future<File?> pickImage() async {
    final XFile? imageFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (imageFile == null) {
      return null;
    }
    return File(imageFile.path);
  }
}
