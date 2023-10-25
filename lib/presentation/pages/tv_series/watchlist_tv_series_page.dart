import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/common/utils.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_event.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_state.dart';
import 'package:my_movie/presentation/bloc/tv_series/watchlist_tv_series_bloc.dart';
import 'package:my_movie/presentation/widgets/tv_series/tv_series_card_list.dart';
import 'package:flutter/material.dart';

class WatchlistTVSeriesPage extends StatefulWidget {
  static const routeName = '/watchlist-tv-series-page';

  const WatchlistTVSeriesPage({super.key});

  @override
  State<WatchlistTVSeriesPage> createState() => _WatchlistTVSeriesPageState();
}

class _WatchlistTVSeriesPageState extends State<WatchlistTVSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistTVSeriesBloc>().add(OnTVSeriesChanged());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTVSeriesBloc>().add(OnTVSeriesChanged());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTVSeriesBloc, TVSeriesState>(
          builder: (context, state) {
            if (state is TVSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TVSeriesHasData) {
              final result = state.result;
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<WatchlistTVSeriesBloc>()
                      .add(OnTVSeriesChanged());
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final tvSeries = result[index];
                    return TVSeriesCard(tvSeries);
                  },
                  itemCount: result.length,
                ),
              );
            } else if (state is TVSeriesError) {
              return Text(state.message);
            } else if (state is TVSeriesEmpty) {
              return const Text('Watchlist Not Found');
            } else {
              return const Text('Failed');
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
