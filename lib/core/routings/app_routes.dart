import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gonime_ca_bloc_tdd/core/injection/injection.dart';
import 'package:gonime_ca_bloc_tdd/src/home/presentation/bloc/home_bloc.dart';
import 'package:gonime_ca_bloc_tdd/src/home/presentation/views/home_screen.dart';

final appRoutes = {
  '/': (context) => BlocProvider(
        create: (context) => sl<HomeBloc>()
          ..add(
            FetchMangaEvent(),
          ),
        child: const HomeScreen(),
      ),
};
