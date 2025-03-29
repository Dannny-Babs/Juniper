// Profile Header Widget
import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/features/profile/presentation/widgets/metrics_card.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark : AppColors.surfaceLight,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: isDark ? AppColors.surfaceDark100 : AppColors.borderLight,
          ),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Profile',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.neutral800,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                        color: isDark
                            ? AppColors.neutral800
                            : AppColors.neutral200,
                        width: 1),
                  ),
                  minimumSize: Size.zero,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {},
                child: SvgPicture.asset(
                  'assets/icons/Menu Dots.svg',
                  colorFilter: ColorFilter.mode(
                    isDark ? AppColors.neutral300 : AppColors.neutral500,
                    BlendMode.srcIn,
                  ),
                  height: 22.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.neutral200,
                    child: Image.asset(
                      'assets/images/profile pic.png',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kadin Workman',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: isDark
                                ? AppColors.neutral100
                                : AppColors.neutral800,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'kadinworkman@gmail.com',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontFamily: GoogleFonts.interTight().fontFamily,
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.neutral600,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.1,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary500,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Investor',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.neutral100,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          PropertyMetricsCard(),
        ],
      ),
    );
  }
}
