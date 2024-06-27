import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gonime_ca_bloc_tdd/src/home/presentation/bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (state is HomeSuccess) {
              return ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: state.mangaList.length,
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.mangaList[index].title ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Row(children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    color: Colors.green,
                                    size: 32,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    state.mangaList[index].score
                                            ?.toDouble()
                                            .toStringAsFixed(1) ??
                                        "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  )
                                ]),
                              ],
                            ),
                          ),
                        ),
                        Image.network(
                          state.mangaList[index].imageUrl ?? "",
                          width: MediaQuery.sizeOf(context).width * 0.4,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
          listener: (context, state) {
            if (state is HomeError) {
              showModalBottomSheet(
                context: context,
                builder: (ctx) => SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 12),
                      const Icon(
                        Icons.error_rounded,
                        size: 160,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        state.errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.green),
                          ),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            context.read<HomeBloc>().add(FetchMangaEvent());
                          },
                          child: const Text(
                            "Refresh",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
