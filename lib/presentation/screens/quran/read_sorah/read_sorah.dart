import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart' as quran;

class ReadSorah extends StatelessWidget {
  final String text;
  final int verseNumber;
  final int numberOfSorah;
  const ReadSorah(
      {super.key,
      required this.text,
      required this.verseNumber,
      required this.numberOfSorah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).primaryColor,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (ctx, index) => numberOfSorah != 1
                      ? index + 1 == 1
                          ? Text(
                              "بسم الله الرحمن الرحيم\n${quran.getVerse(numberOfSorah, index + 1, verseEndSymbol: true)}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          : Text(
                              quran.getVerse(numberOfSorah, index + 1,
                                  verseEndSymbol: true),
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                      : Text(
                          quran.getVerse(numberOfSorah, index + 1,
                              verseEndSymbol: true),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                  separatorBuilder: (ctx, i) => Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Divider(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                  itemCount: verseNumber),
            ),
          ],
        ),
      ),
    );
  }
}
