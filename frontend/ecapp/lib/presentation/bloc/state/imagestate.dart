// ignore_for_file: non_constant_identifier_names

import 'dart:io';

abstract class ImageState{}

class ImagestateSuccess extends ImageState{
  List<File> Images = []; 
  ImagestateSuccess({required this.Images});
}

class ImagestateFailure extends ImageState{
  String message;
  ImagestateFailure({required this.message});
}
class ImagestatePending extends ImageState{}
class ImagestateInitial extends ImageState{}