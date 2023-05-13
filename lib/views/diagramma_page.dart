import 'package:diagramma/bloc/dataBloc.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiagrammaPage extends StatefulWidget {
  const DiagrammaPage({super.key});

  @override
  State<DiagrammaPage> createState() => _DiagrammaPageState();
}

class _DiagrammaPageState extends State<DiagrammaPage> {
  @override
  Widget build(BuildContext context) {
    List<String> typeNames = [
      "Loyiha narxi",
      "Mustahkamligi",
      "X qilish muddati",
      "Qurilish materiallari",
      "Ta'mirlash muammo",
      "Xavfsizligi",
      "Qurilish muddati",
      "Kompleks foydasi",
      "Sanitariyaga mosligi",
      "Ekspluatatsiyaga qul",
      "Tashqi ta'sirlarga ch",
      "Yillik energiya hajmi",
      "Yillik iznos",
      "Qurilish normalari",
    ];
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Диаграмма",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade400,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(fixedSize: Size(150, 40)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Text('Таблица',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              thickness: 1,
              color: Colors.grey.shade400,
            ),
            Image.asset(
              "assets/rasm2.png",
              color: Colors.black,
              height: 160,
            ),
            BlocBuilder<DataCubit, List<List<int>>>(builder: (context, state) {
              List<List<int>> result =
                  List.generate(4, (index) => List.generate(14, (j) => 0));
              for (var i = 0; i < 4; i++) {
                for (var j = 0; j < 14; j++) {
                  result[i][j] = state[j][i];
                }
              }
              List<List<SalesData>> dataSources = [];
              result.forEach((re) {
                List<SalesData> extraVal = [];
                for (var i = 0; i < 14; i++) {
                  extraVal.add(SalesData(i, re[i]));
                }
                dataSources.add(extraVal);
              });
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Container(
                    child: SfCartesianChart(
                      borderWidth: 4,
                      plotAreaBorderWidth: 4,
                      // primaryXAxis: DateTimeAxis(),
                      series: <ChartSeries>[
                        LineSeries<SalesData, int>(
                          dataSource: List.generate(
                              14, (index) => SalesData(index, 10)),
                          color: Colors.black,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                        ),
                        // Renders line chart
                        ...List.generate(
                          result.length,
                          (index) => LineSeries<SalesData, int>(
                            dataSource: dataSources[index],
                            color: [
                              Colors.green,
                              Colors.purple,
                              Colors.cyan,
                              Colors.redAccent
                            ][index],
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sales,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                   ...List.generate(typeNames.length, (index) => Transform.rotate(
                    angle: -  pi/4,
                    child: Text(typeNames[index],style: TextStyle(fontSize: 10,),)))
                ],
              ),
            ),
SizedBox(height: 70,),
            types(
              [
                'Optimal l',
                '1-loyiha',
                '2-loyiha',
                '3-loyiha',
                '4-loyiha',
              ],
              [
                Colors.black,
                Colors.green,
                Colors.purple,
                Colors.cyan,
                Colors.redAccent
              ],
            )
          ],
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }

  types(List<String> names, List<Color> colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...List.generate(
            names.length,
            (index) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: colors[index],
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      names[index],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ))
      ],
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final int year;
  final int sales;
}
