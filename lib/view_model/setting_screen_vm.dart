import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';


class SettingScreenVM {

    late WidgetRef _ref;

    SettingScreenVM(this._ref);

    var selectedLan = StateProvider<String?>((ref) => null);

    final isLoading = StateProvider<bool>((ref) => false);

    final imageFile = StateProvider<File?>((ref) => null);

    imagePicker(ImageSource source) async {

      try{

        _ref.refresh(isLoading.notifier).state = true;

        final image =await ImagePicker().pickImage(source: source);
        File? imagePath = File(image?.path??"");

        _ref.refresh(imageFile.notifier).state = imagePath;

        _ref.refresh(isLoading.notifier).state = false;

      }catch(e){
        print(e.toString());
      }

    }


      onLanChange(var value) {

       _ref.refresh(selectedLan.notifier).state = value;

        return value;

      }
}
