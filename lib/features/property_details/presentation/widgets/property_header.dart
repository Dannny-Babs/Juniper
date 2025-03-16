import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/features/property_details/data/models/property_details.dart';
import 'package:juniper/features/favorites/presentation/favorites_bloc.dart';
import 'package:juniper/features/property_details/presentation/widgets/property_icon.dart';

class PropertyHeader extends StatelessWidget {
  final PropertyDetails property;
  final String propertyId;

  const PropertyHeader({
    Key? key,
    required this.property,
    required this.propertyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          property.title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w500),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  EneftyIcons.location_outline,
                  size: 16.sp,
                  color: AppColors.neutral500,
                ),
                SizedBox(width: 4.w),
                Text(
                  property.location,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.neutral500,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Icon(
                  EneftyIcons.buildings_2_outline,
                  size: 16.sp,
                  color: AppColors.neutral500,
                ),
                SizedBox(width: 4.w),
                Text(
                  property.type,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.neutral500,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                final isDark = theme.brightness == Brightness.dark;
                final isFavorite = state is FavoritesLoaded &&
                    state.favoriteIds.contains(propertyId);
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<FavoritesBloc>(context).add(
                      ToggleFavorite(propertyId),
                    );
                  },
                  child: PropertyIcon(
                    iconPath: isFavorite
                        ? 'bold/bookmark.svg'
                        : 'linear/bookmark.svg',
                    size: 20.sp,
                    color: isFavorite
                        ? AppColors.primary600
                        : isDark
                            ? AppColors.neutral100
                            : AppColors.neutral500,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
