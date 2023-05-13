import 'package:diagramma/bloc/dataBloc.dart';
import 'package:diagramma/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  //  
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(1200, 800),
    maximumSize: Size(1400, 800),
    // maximumSize: Size.infinite,
    minimumSize: Size(1200, 800),
    center: true,
    // fullScreen: true,
    backgroundColor: Colors.transparent,
    // skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<DataCubit>(create: (context) => DataCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const HomePage(),
      ),
    );
  }
}
