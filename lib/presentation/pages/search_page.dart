import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_movie/common/constants.dart';
import 'package:my_movie/presentation/bloc/search_event.dart';

import 'package:my_movie/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:my_movie/presentation/bloc/movie/movie_state.dart';
import 'package:my_movie/presentation/widgets/movie/movie_card_list.dart';

import 'package:my_movie/presentation/bloc/tv_series/tv_series_search_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_state.dart';
import 'package:my_movie/presentation/widgets/tv_series/tv_series_card_list.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search';

  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: "Movie"),
                Tab(text: "TV Series"),
              ],
              unselectedLabelColor: Colors.white,
              labelColor: Colors.white,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          onChanged: (query) {
                            context
                                .read<MovieSearchBloc>()
                                .add(OnQueryChanged(query));
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search title',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.search,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Search Result',
                          style: kHeading6,
                        ),
                        BlocBuilder<MovieSearchBloc, MovieState>(
                          builder: (context, state) {
                            if (state is MovieLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is MovieHasData) {
                              final result = state.result;
                              return Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemBuilder: (context, index) {
                                    final movie = result[index];
                                    return MovieCard(movie);
                                  },
                                  itemCount: result.length,
                                ),
                              );
                            } else if (state is MovieError) {
                              return Expanded(
                                child: Center(
                                  child: Text(state.message),
                                ),
                              );
                            } else {
                              return Expanded(
                                child: Container(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          onChanged: (query) {
                            context
                                .read<TVSeriesSearchBloc>()
                                .add(OnQueryChanged(query));
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search title',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.search,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Search Result',
                          style: kHeading6,
                        ),
                        BlocBuilder<TVSeriesSearchBloc, TVSeriesState>(
                          builder: (context, state) {
                            if (state is TVSeriesLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is TVSeriesHasData) {
                              final result = state.result;
                              return Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: result.length,
                                  itemBuilder: (context, index) {
                                    final tvSeries = result[index];
                                    return TVSeriesCard(tvSeries);
                                  },
                                ),
                              );
                            } else if (state is TVSeriesError) {
                              return Expanded(
                                child: Center(
                                  child: Text(state.message),
                                ),
                              );
                            } else {
                              return Expanded(
                                child: Container(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
