import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_macha/Models/Result.dart';

class ResultButtonsBloc extends Cubit<Result>{
  ResultButtonsBloc():super(Result.none);
  void radioClicked(Result res) => emit(res);
}