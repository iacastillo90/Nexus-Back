import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../providers/search_providers.dart';
import '../widgets/search_result_card.dart';
import '../../domain/entities/search_result_entity.dart';

/// Search screen with users, posts, and tags
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(searchQueryProvider.notifier).setQuery(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final filter = ref.watch(searchFilterProvider);
    final resultsState = ref.watch(searchResultsProvider);
    final recentSearchesState = ref.watch(recentSearchesProvider);
    final trendingTagsState = ref.watch(trendingTagsProvider);

    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: AppColors.glassLight,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            border: Border.all(
              color: AppColors.nexusBlue.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'Search users, posts, tags...',
              hintStyle: AppTypography.bodyMedium.copyWith(
                color: AppColors.textTertiary,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.nexusBlue,
              ),
              suffixIcon: query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: AppColors.textTertiary,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        ref.read(searchQueryProvider.notifier).clear();
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter chips
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.space16,
              vertical: AppDimensions.space8,
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('All', null, filter),
                const SizedBox(width: 8),
                _buildFilterChip('Users', SearchResultType.user, filter),
                const SizedBox(width: 8),
                _buildFilterChip('Posts', SearchResultType.post, filter),
                const SizedBox(width: 8),
                _buildFilterChip('Tags', SearchResultType.tag, filter),
              ],
            ),
          ),

          // Results or empty state
          Expanded(
            child: query.isEmpty
                ? _buildEmptyState(recentSearchesState, trendingTagsState)
                : resultsState.when(
                    data: (results) {
                      if (results.isEmpty) {
                        return _buildNoResults();
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.all(AppDimensions.space16),
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final result = results[index];

                          return SearchResultCard(
                            result: result,
                            onTap: () {
                              // Save search
                              ref
                                  .read(searchResultsProvider.notifier)
                                  .saveSearch(query);

                              // Navigate to result
                              _handleResultTap(result);
                            },
                          );
                        },
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.nexusBlue,
                        ),
                      ),
                    ),
                    error: (error, _) => Center(
                      child: Text(
                        'Error: $error',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.errorFlare,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    SearchResultType? type,
    SearchResultType? currentFilter,
  ) {
    final isSelected = type == currentFilter;

    return GestureDetector(
      onTap: () {
        ref.read(searchFilterProvider.notifier).setFilter(type);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [
                    AppColors.nexusBlue,
                    Color(0xFF0099CC),
                  ],
                )
              : null,
          color: isSelected ? null : AppColors.glassLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.nexusBlue
                : AppColors.carbonFiber,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.nexusBlue.withValues(alpha: 0.3),
                    blurRadius: 8,
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: isSelected
                ? AppColors.textPrimary
                : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    AsyncValue<List<String>> recentSearches,
    AsyncValue<List<SearchResultEntity>> trendingTags,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent searches
          recentSearches.when(
            data: (searches) {
              if (searches.isEmpty) return const SizedBox.shrink();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Searches',
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(recentSearchesProvider.notifier).clear();
                        },
                        child: Text(
                          'Clear',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.nexusBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.space8),
                  ...searches.map((search) => ListTile(
                        leading: const Icon(
                          Icons.history,
                          color: AppColors.textTertiary,
                        ),
                        title: Text(
                          search,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.north_west,
                          color: AppColors.textTertiary,
                          size: 16,
                        ),
                        onTap: () {
                          _searchController.text = search;
                          ref.read(searchQueryProvider.notifier).setQuery(search);
                        },
                      )),
                  const SizedBox(height: AppDimensions.space24),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // Trending tags
          trendingTags.when(
            data: (tags) {
              if (tags.isEmpty) return const SizedBox.shrink();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trending Tags',
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.space12),
                  ...tags.map((tag) => SearchResultCard(
                        result: tag,
                        onTap: () {
                          _searchController.text = tag.title;
                          ref.read(searchQueryProvider.notifier).setQuery(tag.title);
                        },
                      )),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppDimensions.space16),
          Text(
            'No results found',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimensions.space8),
          Text(
            'Try different keywords',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  void _handleResultTap(SearchResultEntity result) {
    switch (result.type) {
      case SearchResultType.user:
        // Navigate to user profile
        // context.push('/profile/${result.id}');
        break;
      case SearchResultType.post:
        // Navigate to post detail
        // context.push('/post/${result.id}');
        break;
      case SearchResultType.tag:
        // Search for tag
        _searchController.text = result.title;
        ref.read(searchQueryProvider.notifier).setQuery(result.title);
        break;
    }
  }
}
