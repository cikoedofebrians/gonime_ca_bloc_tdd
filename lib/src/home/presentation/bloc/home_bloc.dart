import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gonime_ca_bloc_tdd/src/home/domain/entities/manga.dart';
import 'package:gonime_ca_bloc_tdd/src/home/domain/usecases/get_manga_list_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMangaListUsecase getMangaListUsecase;
  HomeBloc({
    required this.getMangaListUsecase,
  }) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) => emit(HomeLoading()));
    on<FetchMangaEvent>(_getMangaList);
  }

  _getMangaList(FetchMangaEvent event, Emitter<HomeState> emit) async {
    final result = await getMangaListUsecase();

    result.fold(
      (failure) => emit(
        HomeError(errorMessage: failure.message),
      ),
      (mangas) => emit(
        HomeSuccess(mangaList: mangas),
      ),
    );
  }
}
