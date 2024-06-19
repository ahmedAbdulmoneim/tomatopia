import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TomatoAgriculturePlanScreen extends StatefulWidget {
  @override
  _TomatoAgriculturePlanScreenState createState() =>
      _TomatoAgriculturePlanScreenState();
}

class _TomatoAgriculturePlanScreenState
    extends State<TomatoAgriculturePlanScreen> {
  final TextEditingController _unitsController = TextEditingController();
  double? _units;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('tomato_plane'.tr()),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            controller: _unitsController,
            decoration:  InputDecoration(
              labelText: 'enter_n_of_units'.tr(),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _units = double.tryParse(value);
              });
            },
          ),
          const SizedBox(height: 20),
          AgriculturePlanSection(
            title: 'التجهيز الأولي للتربة',
            details: [
              'قبل الزراعة:',
              '- إضافة ${calculateFertilizer(20, 30)} طن/فدان من السماد العضوي المتحلل جيدًا.',
              '- إضافة ${calculateFertilizer(200, _units)} كجم/فدان من سماد السوبر فوسفات الثلاثي (TSP).',
              '- إضافة ${calculateFertilizer(50, _units)} كجم/فدان من كبريتات البوتاسيوم.',
            ],
          ),
          AgriculturePlanSection(
            title: 'المرحلة الأولى: النمو الخضري',
            details: [
              'الأسبوع الأول إلى الثالث:',
              '- استخدام سماد نيتروجيني (يوريا 46% N) بمعدل ${calculateFertilizer(40, _units)} كجم/فدان مقسمة على دفعتين.',
            ],
          ),
          AgriculturePlanSection(
            title: 'المرحلة الثانية: الإزهار وعقد الثمار',
            details: [
              'الأسبوع السابع إلى العاشر:',
              '- استخدام سماد نيتروجيني (نترات الأمونيوم) بمعدل ${calculateFertilizer(30, _units)} كجم/فدان.',
              '- إضافة ${calculateFertilizer(30, _units)} كجم/فدان من سلفات البوتاسيوم.',
              '- إضافة ${calculateFertilizer(20, _units)} كجم/فدان من سماد السوبر فوسفات الثلاثي.',
              '- إضافة ${calculateFertilizer(2, _units)} كجم/فدان من سماد الحديد والزنك (خلطات ميكرو).',
            ],
          ),
          AgriculturePlanSection(
            title: 'المرحلة الثالثة: نمو الثمار وتعبئتها',
            details: [
              'الأسبوع الحادي عشر حتى الحصاد:',
              '- استخدام سماد نيتروجيني (نترات الأمونيوم) بمعدل ${calculateFertilizer(30, _units)} كجم/فدان كل أسبوعين.',
              '- إضافة ${calculateFertilizer(50, _units)} كجم/فدان من سلفات البوتاسيوم كل أسبوعين.',
              '- إضافة ${calculateFertilizer(20, _units)} كجم/فدان من سماد السوبر فوسفات الثلاثي كل شهر.',
              '- استخدام ${calculateFertilizer(2, _units)} كجم/فدان من سماد الحديد والزنك (خلطات ميكرو) مرة كل شهر.',
            ],
          ),
        ],
      ),
    );
  }

  String calculateFertilizer(double baseAmount, double? units) {
    if (units == null || units == 0) {
      return baseAmount.toString();
    }
    return (baseAmount * units).toStringAsFixed(2);
  }
}

class AgriculturePlanSection extends StatelessWidget {
  final String title;
  final List<String> details;

  const AgriculturePlanSection({required this.title, required this.details});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...details.map((detail) => Text(
              detail,
              style: const TextStyle(fontSize: 16, height: 1.4),
            )),
          ],
        ),
      ),
    );
  }
}
