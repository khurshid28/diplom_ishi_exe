import 'package:diagramma/bloc/dataBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataProvider {
  Future changeValue(List<List<int>> data,BuildContext context) async {
    await BlocProvider.of<DataCubit>(context).changeDiagramma(data);
  }
}
