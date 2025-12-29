import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/utils/constants/file_json.dart';
import 'package:musliemapp/utils/widgets/card_home.dart';
import 'package:musliemapp/features/another/presentation/pages/another_items_page.dart';

class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('منوعات إسلامية')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildItem(context, '55 وصية من النبي', another55Wasiya),
          _buildItem(context, 'الإيمان بالله', anotherIman),
          _buildItem(context, 'الجنة ونعيمها', anotherJannah),
          _buildItem(context, 'الرقية الشرعية', anotherRuqyah),
          _buildItem(context, 'رياض الصالحين', anotherRiyad),
          _buildItem(context, 'سنن مؤكدة', anotherSunan),
          _buildItem(context, 'علمني الإسلام', anotherTeachMe),
          _buildItem(context, 'فرص ذهبية', anotherGold),
          _buildItem(context, 'فضائل الأعمال', anotherFadail),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String title, String jsonFile) {
    return CardHome(
      icon: Icons.library_books_rounded,
      title: title,
      onClick: () {
        Get.to(
          () => AnotherItemsPage(title: title, jsonFile: jsonFile),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500),
        );
      },
    );
  }
}
