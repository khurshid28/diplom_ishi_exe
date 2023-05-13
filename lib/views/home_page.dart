import 'package:diagramma/bloc/dataBloc.dart';
import 'package:diagramma/provider/dataProvider.dart';
import 'package:diagramma/views/diagramma_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Таблица данных",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(fixedSize: Size(150, 40)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiagrammaPage(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text('Диаграмма',
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
              BlocBuilder<DataCubit, List<List<int>>>(
                  builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    horizontalMargin: 0,
                    columnSpacing: 5,
                    dividerThickness: 0,
                    columns: [
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            color: Colors.grey.shade400,
                            child: Text(
                              "Заголовок",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            color: Colors.grey.shade400,
                            child: Text(
                              "Optimal L.",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            color: Colors.grey.shade400,
                            child: Text(
                              "1-loyiha",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            color: Colors.grey.shade400,
                            child: Text(
                              "2-loyiha",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            color: Colors.grey.shade400,
                            child: Text(
                              "3-loyiha",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            color: Colors.grey.shade400,
                            child: Text(
                              "4-loyiha",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: List.generate(
                      14,
                      (index) => schedeluDataRow(
                          [
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
                          ][index],
                          state[index],index,state),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  DataRow schedeluDataRow(
      String name, List<int> data, int j, List<List<int>> state) {
    return DataRow(
      cells: [
        DataCell(
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 50,
              color: Colors.grey.shade400,
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        DataCell(
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 50,
              color: Colors.grey.shade200,
              child: Text(
                "10",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
        ...List.generate(
          data.length,
          (i) => DataCell(
            GestureDetector(
              onTap: () async {
                textEditingController.text = data[i].toString();
                final textData = await showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      content: Material(
                        child: Form(
                          key: _key,
                          child: TextFormField(
                            
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Bo'sh qoldirmang";
                              }
                              if (int.parse(value) > 10) {
                                return "10 dan kichik qiymat kiriting";
                              }
                            },
                            // initialValue: '${data[i]}',
                            controller: textEditingController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12)
                              // fillColor: Colors.grey.shade300,
                              // filled: true,
                              // errorStyle: TextStyle(height: 0,)
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        CupertinoButton(
                          child: Text('Orqaga'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoButton(
                          child: Text("O'zgartirish"),
                          onPressed: () async {
                            if (await _key.currentState!.validate()) {
                              Navigator.pop(
                                  context, textEditingController.text);
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
                if (textData != null) {
                  data[i] = int.parse(textData);
                  state[j] = data;
                  setState(() {
                    
                  });
                  DataProvider().changeValue(state, context);
                }
              },
              child: Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  color: Colors.grey.shade200,
                  child: Text(
                    data[i].toString(),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
