import 'package:duaa/core/local_service/database/ahadith/hadith_database/hadith_database.dart';
import 'package:duaa/core/local_service/database/ahadith/hadith_ghadab_database/hadith_ghadab_database.dart';
import 'package:duaa/core/local_service/database/ahadith/hadith_katel_database/hadith_katel_database.dart';
import 'package:duaa/core/local_service/database/ahadith/hadith_la_ys7/hadith_la_ys7.dart';
import 'package:duaa/core/local_service/database/ahadith/hadith_tabasom_database/hadith_tabasom_database.dart';
import 'package:duaa/core/local_service/database/azkar/azkar.dart';
import 'package:duaa/core/local_service/database/azkar/azkar_sala.dart';
import 'package:duaa/core/local_service/database/azkar/hesn_elwaky.dart';
import 'package:duaa/core/local_service/database/azkar/lists_of_duaa.dart';
import 'package:duaa/core/local_service/database/sonan_mahgora_database/sonan_mahgora_database.dart';
import 'package:duaa/core/local_service/database/madih_naby/madih_naby.dart';

class InitDataBase {
  static void init() {
    //احاديث
    HadithsDataBase.add();
    HadithsGhadab.add();
    HadithsTabasomDataBase.add();
    HadithsKatel.add();
    HadithsInCorrect.add();
    //سنن مهجورة
    HadithsMahgoraDataBase.add();
    //اشعار
    MadihNaby.add();
    //اذكار
    AzkarDataBase.add();
    HesnElWakyDataBase.init();
    ListsOfDuaaDataBase.add();
    AzkarSala.add();
  }
}
