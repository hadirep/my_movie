import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/common/constants.dart';
import 'package:my_movie/domain/entities/tv_series/tv_series.dart';
import 'package:my_movie/presentation/bloc/tv_series/popular_tv_series_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/top_rated_tv_series_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_event.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_state.dart';
import 'package:my_movie/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:my_movie/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:my_movie/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_list_bloc.dart';
import 'package:flutter/material.dart';

class HomeTVSeriesPage extends StatefulWidget {
  static const routeName = '/home-tv-series-page';

  const HomeTVSeriesPage({super.key});

  @override
  State<HomeTVSeriesPage> createState() => _HomeTVSeriesPageState();
}

class _HomeTVSeriesPageState extends State<HomeTVSeriesPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<PopularTVSeriesBloc>().add(OnTVSeriesChanged());
    context.read<TopRatedTVSeriesBloc>().add(OnTVSeriesChanged());
    context.read<TVSeriesListBloc>().add(OnTVSeriesChanged());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing TV Series',
                style: kHeading6,
              ),
              BlocBuilder<TVSeriesListBloc, TVSeriesState>(
                builder: (context, state) {
                  if (state is TVSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TVSeriesHasData) {
                    final result = state.result;
                    return TVSeriesList(result);
                  } else if (state is TVSeriesError) {
                    final result = state.message;
                    return Text(result);
                  } else if (state is TVSeriesEmpty) {
                    return const Text('Now Playing TV Series Not Found');
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular TV Series',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTVSeriesPage.routeName),
              ),
              BlocBuilder<PopularTVSeriesBloc, TVSeriesState>(
                builder: (context, state) {
                  if (state is TVSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TVSeriesHasData) {
                    final result = state.result;
                    return TVSeriesList(result);
                  } else if (state is TVSeriesError) {
                    final result = state.message;
                    return Text(result);
                  } else if (state is TVSeriesEmpty) {
                    return const Text('Popular TV Series Not Found');
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated TV Series',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTVSeriesPage.routeName),
              ),
              BlocBuilder<TopRatedTVSeriesBloc, TVSeriesState>(
                builder: (context, state) {
                  if (state is TVSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TVSeriesHasData) {
                    final result = state.result;
                    return TVSeriesList(result);
                  } else if (state is TVSeriesError) {
                    final result = state.message;
                    return Text(result);
                  } else if (state is TVSeriesEmpty) {
                    return const Text('Top Rated TV Series Not Found');
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVSeriesList extends StatelessWidget {
  final List<TVSeries> tvSeries;

  const TVSeriesList(this.tvSeries, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvseries = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVSeriesDetailPage.routeName,
                  arguments: tvseries.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tvseries.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
