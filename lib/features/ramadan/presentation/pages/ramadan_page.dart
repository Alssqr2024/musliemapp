import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/utils/constants/file_json.dart';
import 'package:musliemapp/utils/widgets/card_home.dart';
import 'package:musliemapp/features/ramadan/presentation/pages/ramadan_items_page.dart';

class RamadanPage extends StatelessWidget {
  const RamadanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('رمضان المبارك')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildItem(context, 'أحكام وفتاوى', ramadanAhkam),
          _buildItem(context, 'أدعية رمضان', ramadanAd3ya),
          _buildItem(context, 'صحتك في رمضان', ramadanHealth),
          _buildItem(context, 'ختم القرآن', ramadanQuran),
          _buildItem(context, 'نصائح رمضانية', ramadanTips),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String title, String jsonFile) {
    return CardHome(
      icon: Icons.calendar_month_rounded,
      title: title,
      onClick: () {
        Get.to(
          () => RamadanItemsPage(title: title, jsonFile: jsonFile),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500),
        );
      },
    );
  }
}
