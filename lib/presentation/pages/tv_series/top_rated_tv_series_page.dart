import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/top_rated_tv_series_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_event.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_state.dart';
import 'package:my_movie/presentation/widgets/tv_series/tv_series_card_list.dart';
import 'package:flutter/material.dart';

class TopRatedTVSeriesPage extends StatefulWidget {
  static const routeName = '/top-rated-tv-series-page';

  const TopRatedTVSeriesPage({super.key});

  @override
  State<TopRatedTVSeriesPage> createState() => _TopRatedTVSeriesPageState();
}

class _TopRatedTVSeriesPageState extends State<TopRatedTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TopRatedTVSeriesBloc>().add(OnTVSeriesChanged());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TopRatedTVSeriesBloc, TVSeriesState>(
          builder: (context, state) {
            if (state is TVSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TVSeriesHasData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = result[index];
                  return TVSeriesCard(tvSeries);
                },
                itemCount: result.length,
              );
            } else if (state is TVSeriesError) {
              return Text(state.message);
            } else if (state is TVSeriesEmpty) {
              return const Text('Top Rated TV Series Not Found');
            } else {
              return const Text('Failed');
            }
          },
        ),
      ),
    );
  }
}
