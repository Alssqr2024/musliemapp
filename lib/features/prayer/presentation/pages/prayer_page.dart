import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/utils/constants/file_json.dart';
import 'package:musliemapp/utils/widgets/card_home.dart';
import 'package:musliemapp/utils/widgets/main_scaffold.dart';
import 'package:musliemapp/utils/widgets/premium_sliver_app_bar.dart';
import 'package:musliemapp/features/prayer/presentation/pages/prayer_items_page.dart';

class PrayerPage extends StatelessWidget {
  const PrayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      slivers: [
        const PremiumSliverAppBar(
          title: 'أدعية وأذكار',
          icon: Icons.volunteer_activism_rounded,
          subtitle: "وَقَالَ رَبُّكُمُ ادْعُونِي أَسْتَجِبْ لَكُمْ",
        ),

        SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildListDelegate([
                    _buildItem(context, 'أدعية الرزق والبركة', prayerRizq),
                    _buildItem(context, 'أدعية المتوفى', prayerMotawafa),
                    _buildItem(
                      context,
                      'أدعية المغفرة والتوبة',
                      prayerMaghfira,
                    ),
                    _buildItem(context, 'أدعية ختم القرآن', prayerKhatm),
                    _buildItem(context, 'أدعية ذهاب الهم', prayerHam),
                    _buildItem(context, 'أدعية طلب العلم', prayerIlm),
                    _buildItem(context, 'أدعية قرآنية', prayerQuran),
                    _buildItem(context, 'أدعية نبوية', prayerNabawiya),
                  ]),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(
                    'مسائل الدعاء',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildListDelegate([
                    _buildItem(context, 'آداب وشروط الدعاء', prayerEtiquette),
                    _buildItem(
                      context,
                      'أوقات استجابة الدعاء',
                      prayerResponseTimes,
                    ),
                    _buildItem(context, 'الدعاء المستجاب', answeredPrayer),
                    _buildItem(context, 'الدعاء المنهى عنه', forbiddenPrayer),
                    _buildItem(context, 'فضل الدعاء', virtueOfPrayer),
                  ]),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
    );
  }

  Widget _buildItem(BuildContext context, String title, String jsonFile) {
    return CardHome(
      icon: Icons.volunteer_activism_rounded,
      title: title,
      onClick: () {
        Get.to(
          () => PrayerItemsPage(title: title, jsonFile: jsonFile),
          transition: Transition.cupertino,
          duration: const Duration(milliseconds: 500),
        );
      },
    );
  }
}
