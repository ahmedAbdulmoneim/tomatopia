import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class FiledMonitoring extends StatelessWidget {
  FiledMonitoring({
    super.key,
  });

  final TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    expandedHeight: 350,
                    pinned: true,
                    title: SliverAppBarTitle(
                      child: Text(
                        'field_monitoring'.tr(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset(
                        'assets/monitoring.png',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: 200.0,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'field_monitoring'.tr(),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'field_monitoring_description'.tr(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          color: Colors.blue.withOpacity(.1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'why_monitoring_important'.tr(),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'monitoring_helps'.tr(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'save_money'.tr(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'minimize_yield_loss'.tr(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.info_outline),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        'higher_yields'.tr(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'how_to_monitor'.tr(),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              StepWidget(
                                stepNumber: 1,
                                title: 'visit_field'.tr(),
                                description: 'visit_recommendation'.tr(),
                              ),
                              StepWidget(
                                stepNumber: 2,
                                title: 'check_several_spots'.tr(),
                                description: 'check_spots_description'.tr(),
                                illustration: Image.asset(
                                  'assets/img.png',
                                  width: double.infinity,
                                ),
                              ),
                              StepWidget(
                                stepNumber: 3,
                                title: 'unusual_patterns'.tr(),
                                description: 'patterns_description'.tr(),
                              ),
                              StepWidget(
                                stepNumber: 4,
                                title: 'examine_crop'.tr(),
                                description: 'examine_description'.tr(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          color: Colors.blue.withOpacity(.1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'take_action'.tr(),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'action_description'.tr(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'support'.tr(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliverAppBarTitle extends StatelessWidget {
  final Widget child;

  const SliverAppBarTitle({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final settings = context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    final deltaExtent = settings!.maxExtent - settings.currentExtent;

    return Opacity(
      opacity: (deltaExtent / settings.maxExtent),
      child: child,
    );
  }
}

class StepWidget extends StatelessWidget {
  final int stepNumber;
  final String title;
  final String description;
  final Widget? illustration;

  const StepWidget({
    Key? key,
    required this.stepNumber,
    required this.title,
    required this.description,
    this.illustration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.greenAccent,
            child: Text(
              stepNumber.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16),
                ),
                if (illustration != null) ...[
                  const SizedBox(height: 8),
                  illustration!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
