
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_macha/repositories/user/user_repository.dart';

class ChangeNameBloc extends Cubit<String>{
  ChangeNameBloc(super.initialState);
  void changeName(String newName,String old) async{
    bool nameChanged = await UserRepository().changeName(newName);
    if(nameChanged){
      emit(newName);
      return;
    }
    emit(old);
  }
}