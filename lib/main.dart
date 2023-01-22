import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satagro/features/sat_agro/presentation/bloc/sat_agro_bloc.dart';
import 'package:satagro/features/sat_agro/presentation/pages/home_page.dart';
import 'package:satagro/injection_container.dart';

import 'features/sat_agro/bloc_observer.dart';
import 'package:satagro/injection_container.dart' as ic;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ic.init();

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SatAgroBloc>(),
      child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: HomePage()),
    );
  }
}
