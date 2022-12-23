import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/ui/sizes.dart';
import '../../constants/ui/text_style.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../gen/assets.gen.dart';
import '../../utils/ui/scaffold.dart';
import '../../widgets/food_list_view.dart';
import '../home/widgets/home_app_bar.dart';
import 'cubit/search_cubit.dart';
import 'widgets/selected_filter_chip_section.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final _searchTextController = TextEditingController();
  late final _searchScrollController = ScrollController();
  String oldQuery = '';

  String get newQuery => _searchTextController.text.trim();

  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(_onSearchChanged);
    _searchScrollController.addListener(_onScrollChanged);
  }

  void _onSearchChanged() {
    if (oldQuery == newQuery || newQuery.isEmpty) return;
    oldQuery = newQuery;
    context.read<SearchCubit>().search(newQuery);
  }

  void _onScrollChanged() async {
    if (context.read<SearchCubit>().state.status.isLoading ||
        context.read<SearchCubit>().state.isLastPage) {
      return;
    }
    double currentScroll = _searchScrollController.position.pixels;
    double maxScroll = _searchScrollController.position.maxScrollExtent;
    const fetchOffset = 500.0;
    if (currentScroll > maxScroll - fetchOffset) {
      context.read<SearchCubit>().fetchMoreResult();
    }
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: Ui.screenPadding,
            child: HomeAppBar(
              searchController: _searchTextController,
            ),
          ),
          gapH8,
          BlocSelector<SearchCubit, SearchState, List<SelectableItem>>(
            selector: (state) {
              return state.filters;
            },
            builder: (context, state) {
              return SelectedFilterChipSection(
                filter: state,
                onDeleteChip: context.read<SearchCubit>().onFilterToggled,
                onDeleteAllChip: (_) =>
                    context.read<SearchCubit>().clearFilters(),
              );
            },
          ),
          BlocBuilder<SearchCubit, SearchState>(
            buildWhen: (previous, current) =>
                previous.status != current.status ||
                previous.foods != current.foods,
            builder: (context, state) {
              return Expanded(
                child: state.foods.isEmpty
                    ? SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox.square(
                                dimension: 250.0,
                                child: SvgPicture.asset(
                                    Assets.images.illustrations.sad),
                              ),
                              Text(
                                'Food not found',
                                style: FTextStyles.heading5.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : FoodListView(
                        controller: _searchScrollController,
                        foods: state.foods,
                        isLoading: state.status.isLoading,
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
