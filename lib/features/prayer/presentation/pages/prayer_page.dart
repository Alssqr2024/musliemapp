import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/utils/constants/file_json.dart';
import 'package:musliemapp/utils/widgets/card_home.dart';
import 'package:musliemapp/features/prayer/presentation/pages/prayer_items_page.dart';

class PrayerPage extends StatelessWidget {
  const PrayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('أدعية')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildItem(context, 'أدعية الرزق والبركة', prayerRizq),
          _buildItem(context, 'أدعية المتوفى', prayerMotawafa),
          _buildItem(context, 'أدعية المغفرة والتوبة', prayerMaghfira),
          _buildItem(context, 'أدعية ختم القرآن', prayerKhatm),
          _buildItem(context, 'أدعية ذهاب الهم', prayerHam),
          _buildItem(context, 'أدعية طلب العلم', prayerIlm),
          _buildItem(context, 'أدعية قرآنية', prayerQuran),
          _buildItem(context, 'أدعية نبوية', prayerNabawiya),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'مسائل الدعاء',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          _buildItem(context, 'آداب وشروط الدعاء', prayerEtiquette),
          _buildItem(context, 'أوقات استجابة الدعاء', prayerResponseTimes),
          _buildItem(context, 'الدعاء المستجاب', answeredPrayer),
          _buildItem(context, 'الدعاء المنهى عنه', forbiddenPrayer),
          _buildItem(context, 'فضل الدعاء', virtueOfPrayer),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String title, String jsonFile) {
    return CardHome(
      icon: Icons.volunteer_activism_rounded,
      title: title,
      onClick: () {
        Get.to(
          () => PrayerItemsPage(title: title, jsonFile: jsonFile),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500),
        );
      },
    );
  }
}
