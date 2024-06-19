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
        title:  Text(
          context.reviews
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {
          if (state is GetAllReviewsFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to load reviews')),
            );
          }
        },
        builder: (context, state) {
          var reviewCubit = BlocProvider.of<AdminCubit>(context);
          if (state is GetAllReviewsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: reviewCubit.allReviews.length,
            itemBuilder: (context, index) {
              final review = reviewCubit.allReviews[index];
              return ReviewCard(review: review);
            },
          );
        },
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    bool isPositive = review.type == 'Positive';
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ListTile(
        leading: Icon(
          isPositive ? Icons.thumb_up : Icons.thumb_down,
          color: isPositive ? Colors.green : Colors.red,
        ),
        title: Text(review.reviews ?? ''),
        tileColor: isPositive ? Colors.green[50] : Colors.red[50],
        subtitle: Text(
          review.type ?? '',
          style: TextStyle(
            color: isPositive ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
