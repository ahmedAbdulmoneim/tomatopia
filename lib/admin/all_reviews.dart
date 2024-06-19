import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_cubit.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_states.dart';
import 'package:tomatopia/custom_widget/extensions.dart';

import '../api_models/admin_models/review_model.dart';

class ShowAllReviews extends StatelessWidget {
  const ShowAllReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.reviews),
        centerTitle: true,
      ),
      body: BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {
          if (state is GetAllReviewsFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to load reviews')),
            );
          }
        },
        builder: (context, state) {
          var reviewCubit = BlocProvider.of<AdminCubit>(context);
          if (state is GetAllReviewsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Card(
                      margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: ListTile(
                        leading: const Icon(Icons.thumb_up,color: Colors.green,),
                        title: Text(truncatePercentage(reviewCubit.allReviews!.positive!)),
                        tileColor: Colors.green[50],
                        subtitle: const Text(
                          'Positive',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: ListTile(
                        leading: const Icon(Icons.thumb_down,color: Colors.red,),
                        title: Text(truncatePercentage(reviewCubit.allReviews!.negative!)),
                        tileColor: Colors.red[50],
                        subtitle: const Text(
                          'Negative',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: reviewCubit.allReviews!.reviews!.length,
                  itemBuilder: (context, index) {
                    final review = reviewCubit.allReviews;
                    return ReviewCard(
                      review: review!,
                      index: index,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String truncatePercentage(String percentage) {
    // Find the index of the decimal point
    int decimalIndex = percentage.indexOf('.');

    // Check if the decimal point is found and there are enough digits after it
    if (decimalIndex != -1 && percentage.length > decimalIndex + 4) {
      // Truncate the string after the fourth digit following the decimal point
      return percentage.substring(0, decimalIndex + 5) + '%';
    }

    // Return the original string if it does not need truncation
    return percentage;
  }
}

class ReviewCard extends StatelessWidget {
  final ReviewModel review;
  final int index;

  const ReviewCard({required this.review, required this.index});

  @override
  Widget build(BuildContext context) {
    bool isPositive = review.reviews![index].type == 'Positive';
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ListTile(
        leading: Icon(
          isPositive ? Icons.thumb_up : Icons.thumb_down,
          color: isPositive ? Colors.green : Colors.red,
        ),
        title: Text(review.reviews![index].reviews ?? ''),
        tileColor: isPositive ? Colors.green[50] : Colors.red[50],
        subtitle: Text(
          review.reviews![index].type ?? '',
          style: TextStyle(
            color: isPositive ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
