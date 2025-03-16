import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/core/widgets/button.dart';
import 'package:juniper/core/widgets/investment_modal.dart';
import '../../../../core/widgets/property_info_card.dart';

import '../widgets/property_widgets.dart';
import '../../data/repositories/property_repository_impl.dart';
import '../../domain/repositories/property_repository.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final String propertyId;

  const PropertyDetailsScreen({
    super.key,
    required this.propertyId,
  });

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  void _showSnackBar(String message, bool isSuccess) {
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: isSuccess ? AppColors.success500 : AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PropertyRepository>(
          create: (context) => PropertyRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PropertyDetailsBloc(
              propertyRepository: context.read<PropertyRepository>(),
            )..add(LoadPropertyDetails(widget.propertyId)),
          ),
          BlocProvider(
            create: (context) => FavoritesBloc(),
          ),
        ],
        child: BlocListener<FavoritesBloc, FavoritesState>(
          listener: (context, state) {
            if (state is FavoritesLoaded) {
              final isFavorite = state.favoriteIds.contains(widget.propertyId);
              _showSnackBar(
                isFavorite ? 'Added to favorites' : 'Removed from favorites',
                true,
              );
            } else if (state is FavoritesError) {
              _showSnackBar(state.message, false);
            }
          },
          child: Scaffold(
            backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              centerTitle: true,
              title: BlocBuilder<PropertyDetailsBloc, PropertyDetailsState>(
                builder: (context, state) {
                  if (state is PropertyDetailsLoaded) {
                    return Text(
                      state.propertyDetails.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              leading: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: PlatformBackButton(
                  onPressed: () => Navigator.of(context).pop(),
                  color: isDark ? Colors.white : AppColors.neutral900,
                ),
              ),
              actions: [
                BlocBuilder<FavoritesBloc, FavoritesState>(
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: IconButton(
                        icon: Icon(
                          EneftyIcons.more_circle_outline,
                          color: isDark ? Colors.white : AppColors.neutral900,
                          size: 24.sp,
                        ),
                        onPressed: () {
                          // TODO: Show more options
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            extendBodyBehindAppBar: false,
            body: BlocBuilder<PropertyDetailsBloc, PropertyDetailsState>(
              builder: (context, state) {
                if (state is PropertyDetailsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is PropertyDetailsError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error loading property details',
                          style: theme.textTheme.bodyLarge,
                        ),
                        SizedBox(height: 8.h),
                        CustomButton(
                          text: 'Retry',
                          onPressed: () {
                            context.read<PropertyDetailsBloc>().add(
                                  LoadPropertyDetails(widget.propertyId),
                                );
                          },
                        ),
                      ],
                    ),
                  );
                }

                if (state is PropertyDetailsLoaded) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: Colors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: PropertyImageCarousel(
                                  images: state.propertyDetails.images),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.surfaceDark100
                                      : Colors.white,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 24.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PropertyHeader(
                                      property: state.propertyDetails,
                                      propertyId: widget.propertyId,
                                    ),
                                    SizedBox(height: 16.h),
                                    PropertyDescription(
                                      description: state.propertyDetails.description ??
                                          "This is a beautiful property located in a prime location. "
                                              "It features modern amenities and is perfect for both living and investment purposes.",
                                    ),
                                    SizedBox(height: 16.h),
                                    PropertyFeatures(property: state.propertyDetails),
                                    SizedBox(height: 24.h),
                                    // New sections
                                    PricePaymentSection(
                                      property: state.propertyDetails,
                                      isDark: isDark,
                                    ),
                                    SizedBox(height: 16.h),
                                    InvestmentMetrics(
                                      property: state.propertyDetails,
                                      isDark: isDark,
                                    ),
                                    SizedBox(height: 16.h),
                                    NearbyLandmarksSection(
                                      isDark: isDark,
                                      landmarks: [
                                        NearbyLandmark(
                                          name: 'Central Station',
                                          category: 'Transport',
                                          distance: 0.8,
                                        ),
                                        NearbyLandmark(
                                          name: 'Bus Stop 23',
                                          category: 'Transport',
                                          distance: 0.2,
                                        ),
                                        NearbyLandmark(
                                          name: 'City Elementary School',
                                          category: 'Education',
                                          distance: 1.2,
                                        ),
                                        NearbyLandmark(
                                          name: 'University of Technology',
                                          category: 'Education',
                                          distance: 2.5,
                                        ),
                                        NearbyLandmark(
                                          name: 'Westfield Mall',
                                          category: 'Shopping',
                                          distance: 1.5,
                                        ),
                                        NearbyLandmark(
                                          name: 'Fresh Market',
                                          category: 'Shopping',
                                          distance: 0.7,
                                        ),
                                        NearbyLandmark(
                                          name: 'Central Park',
                                          category: 'Recreation',
                                          distance: 0.5,
                                        ),
                                        NearbyLandmark(
                                          name: 'City Fitness Center',
                                          category: 'Recreation',
                                          distance: 1.8,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.h),
                                    RatingReviewCard(
                                      overallRating: 4.5,
                                      totalReviews: 28,
                                      subRatings: {
                                        'Comfortable': 4.2,
                                        'Cleanliness': 4.8,
                                        'Facilities': 4.3,
                                      },
                                    ),
                                    SizedBox(height: 16.h),

                                    // Agent details section
                                    AgentContactCard(
                                      name: 'Jane Smith',
                                      address:
                                          '123 Real Estate Agency, New York',
                                      imageUrl:
                                          'https://randomuser.me/api/portraits/women/44.jpg',
                                      onContactPressed: () {
                                        // Handle contact agent action
                                      },
                                    ),
                                    SizedBox(height: 16.h),

                                    // Inspection times section
                                    InspectionTimesCard(
                                      agentName: 'Jane Smith',
                                      agentImageUrl:
                                          'https://randomuser.me/api/portraits/women/44.jpg',
                                      inspectionTimes: [
                                        InspectionTime(
                                          date: DateTime.now()
                                              .add(Duration(days: 2)),
                                          timeSlot: '10:30 AM - 11:00 AM',
                                        ),
                                        InspectionTime(
                                          date: DateTime.now()
                                              .add(Duration(days: 3)),
                                          timeSlot: '2:00 PM - 2:30 PM',
                                        ),
                                      ],
                                      onRegisterPressed: () {
                                        // Handle registration for inspection
                                      },
                                    ),
                                    SizedBox(height: 100.h),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.surfaceDark100
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.surfaceDark.withAlpha(20),
                                blurRadius: 10,
                                offset: Offset(0, -5),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            bottom:
                                MediaQuery.of(context).padding.bottom + 16.h,
                            top: 16.h,
                          ),
                          child: PropertyActionButtons(
                            onInvestPressed: () {},
                            onContactPressed: () {
                              // Show investment modal when "Start Investing" is pressed
                              InvestmentModal.show(
                                context,
                                balance:
                                    5000.00, // You might want to get this from user data
                                propertyTitle: state.propertyDetails.title,
                                onInvest: (amount, method) {
                                  // Process the investment
                                  final methodName =
                                      method == PaymentMethod.wallet
                                          ? 'Wallet'
                                          : 'Credit Card';
                                  _showSnackBar(
                                    'Successfully invested \$$amount in ${state.propertyDetails.title} using $methodName',
                                    true,
                                  );

                                  // Here you would typically call an API to process the investment
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
