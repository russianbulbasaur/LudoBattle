import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class  ScreenshotBloc extends Cubit<XFile?>{
  ScreenshotBloc():super(XFile(""));
  void imageSelected(XFile? file) => emit(file);
}