import 'package:duaa/core/local_service/database/azkar/azkar_sala.dart';
import 'package:duaa/presentation/components/reusable_components/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AzkarSalaScreen extends StatelessWidget {
  const AzkarSalaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, text: "الأذكار بعد كل صلاة"),
      body: Padding(
        padding: EdgeInsets.all(8.r),
        child: ListView.separated(
            itemBuilder: (context, index) => Text(
                  ". ${AzkarSala.azkar[index].text}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
            separatorBuilder: (context, index) => SizedBox(
                  height: 8.h,
                ),
            itemCount: AzkarSala.azkar.length),
      ),
    );
  }
}
