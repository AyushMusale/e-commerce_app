import 'dart:io';

abstract class ImageState{}

class ImagestateSuccess extends ImageState{
  List<File> imageUrl = []; 
  ImagestateSuccess({required this.imageUrl});
}

class ImagestateFailure extends ImageState{
  String message;
  ImagestateFailure({required this.message});
}
class ImagestatePending extends ImageState{}
class ImagestateInitial extends ImageState{}