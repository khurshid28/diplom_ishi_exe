import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class DataCubit extends Cubit<List<List<int>>> {
  DataCubit() : super(List.generate(14, (index) => List.generate(4,(j)=>Random().nextInt(11))));

  changeDiagramma(List<List<int>> data) {
    emit(data);
  }
}
