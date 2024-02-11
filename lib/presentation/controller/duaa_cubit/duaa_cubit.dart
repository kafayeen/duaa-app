import 'dart:developer';
import 'dart:io';
import 'package:duaa/core/flutter_local_notification/flutter_local_notification.dart';
import 'package:duaa/core/local_service/shared_pref_service/shared_pref_service.dart';
import 'package:duaa/core/location_permission_service/location_permission_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duaa/presentation/controller/duaa_states/duaa_states.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:sqflite/sqflite.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class DuaaCubit extends Cubit<DuaaStates> {
  DuaaCubit() : super(DuaaInitialState());
  static DuaaCubit get(context) => BlocProvider.of(context);
  bool mode = false;
  void toogleMode({bool? change}) {
    if (change != null) {
      mode = change;
      emit(ToogleModeState());
    } else {
      mode = !mode;
      CacheHelper.putData("mode", mode);
      emit(ToogleModeState());
    }
  }

  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? image;
  bool popScope = false;

  screenShot({required BuildContext context}) {
    image = null;
    Permission permission = Permission.storage;
    permission.request().isGranted.then((value) {
      if (value) {
        permission.request().then((value) {
          screenshotController.capture().then((value) {
            if (value != null) {
              getApplicationDocumentsDirectory().then((v) {
                final imagePath = "${v.path}/screenshot.png";
                File file = File(imagePath);
                file.writeAsBytes(value).then((value) {
                  ImageGallerySaver.saveFile(value.path).then((value) {
                    popScope = false;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        content: Text(
                          "تم الألتقاط",
                          style: Theme.of(context).textTheme.bodySmall,
                        )));
                    emit(DuaaScreenShotSuccessState());
                  }).catchError((e) {
                    log(e.toString());
                  });
                }).catchError((e) {
                  log(e.toString());
                });
              });
            }
            //E/gralloc4(14234): Empty SMPTE 2094-40 data
            //file = File(imagePath).writeAsBytes(bytes) لو ايماج باس فيها صورة وعملت رايت و فيها صورة تانى كدا فايل هيشيل صورة تانية ولا لا
          }).catchError((e) {
            log(e.toString());
            emit(DuaaScreenShotErrorState());
          });
          // } else {
          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          //       content: Text(
          //         "فشل طلب التخزين",
          //         style: Theme.of(context).textTheme.bodySmall,
          //       )));
          //   emit(DuaaScreenShotSuccessState());
          // }
        }).catchError((e) {
          log(e.toString());
        });
      } else {
        screenshotController.capture().then((value) {
          if (value != null) {
            getApplicationDocumentsDirectory().then((v) {
              final imagePath = "${v.path}/screenshot.png";
              File file = File(imagePath);
              file.writeAsBytes(value).then((value) {
                ImageGallerySaver.saveFile(value.path).then((value) {
                  popScope = false;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      content: Text(
                        "تم الألتقاط",
                        style: Theme.of(context).textTheme.bodySmall,
                      )));
                  emit(DuaaScreenShotSuccessState());
                }).catchError((e) {
                  log(e.toString());
                });
              }).catchError((e) {
                log(e.toString());
              });
            });
          }
          //E/gralloc4(14234): Empty SMPTE 2094-40 data
          //file = File(imagePath).writeAsBytes(bytes) لو ايماج باس فيها صورة وعملت رايت و فيها صورة تانى كدا فايل هيشيل صورة تانية ولا لا
        }).catchError((e) {
          log(e.toString());
          emit(DuaaScreenShotErrorState());
        });
      }
    }).catchError((e) {});
  }

  int count = 0;
  int dawraOfSebha = 0;
  void sebhaCount() {
    // emit(InitialDuaaQeblaState());
    if (count == 100) {
      count = 0;
      dawraOfSebha = dawraOfSebha + 1;
      emit(DuaaSebhaState());
    } else {
      count = count + 1;
      if (!mute) {
        Vibration.hasVibrator().then((value) {
          if (value == true) {
            Vibration.vibrate(duration: 150, amplitude: 50).then((value) {});
          }
        });
      }
      emit(DuaaSebhaState());
    }
  }

  bool mute = false;
  void disposeVibrate() {
    mute = !mute;
    if (mute) {
      Vibration.cancel();
      emit(DuaaMuteVibrate());
    } else if (!mute) {
      Vibration.hasVibrator().then((value) {
        if (value == true) {
          Vibration.vibrate(duration: 150, amplitude: 50).then((value) {});
        }
      });
      emit(DuaaMuteVibrate());
    }
  }

  void reset() {
    count = 0;
    dawraOfSebha = 0;
    emit(DuaaResetSebhaState());
  }

  ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  void toggle() {
    zoomDrawerController.toggle?.call();

    emit(DuaaDrawerToggleState());
  }

  Position? position;
  String? country;
  void getCountry() {
    if (CacheHelper.getData("country") != null) {
      country = CacheHelper.getData("country");
      emit(DuaaGetCountryState());
    }
  }

  void locateUser({required BuildContext context}) {
    emit(DuaaInitialPrayerStateState());
    LocationService.handleLocationPermission(context).then((value) {
      if (value == true) {
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
            .then((value) {
          position = value;
          placemarkFromCoordinates(position!.latitude, position!.longitude,
                  localeIdentifier: 'en_US')
              .then((v) {
            country = v[0].country!.toLowerCase();
            CacheHelper.putData("country", v[0].country!.toLowerCase());
            emit(DuaaPrayerStateState());
          });
        }).catchError((e) {
          log(e.toString());
        });
      }
    }).catchError((e) {
      log(e.toString());
    });
  }

  bool check = false;
  void qibla({
    required BuildContext context,
  }) {
    LocationService.handleLocationPermission(context).then((value) {
      FlutterQiblah.androidDeviceSensorSupport().then((value) {
        log("$value ===");
        if (value == true) {
          FlutterQiblah.checkLocationStatus().then((value) {
            // if (value.enabled && value.status == LocationPermission.denied) {
            FlutterQiblah.requestPermissions().then((value) {
              Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high)
                  .then((value) {
                FlutterQiblah.checkLocationStatus().then((value) {
                  check = true;

                  emit(DuaaQeblaState());
                });
              });
            });
            // }
          });
        }
      }).catchError((e) {
        check = false;
        emit(DuaaQeblaErrorState());
      });
    });
  }

  bool delete = false;
  void deleteCountry() {
    country = null;
    delete = false;
    emit(DuaaDeleteCountryState());
  }

  void disposeQibla() {
    FlutterQiblah().dispose();
    emit(DisposeQeblaState());
  }

  bool notification = true;
  void notifications() {
    if (notification) {
      FlutterLocalNotificationService.offNotifications();
      notification = false;
      emit(ChangeNotificationsState());
    } else {
      FlutterLocalNotificationService.onNotifications();
      notification = true;
      emit(ChangeNotificationsState());
    }
  }

  //////////////////////////////////////////////////////////////////////////////
  ///////database
  Database? db;
  void create() {
    openDatabase("duaa.db", version: 1, onCreate: (database, version) {
      database
          .execute(
              "CREATE TABLE tasks (id INTEGER PRIMARY KEY , hadith TEXT , sona TEXT , name TEXT,type TEXT)")
          .then((value) {})
          .catchError((onError) {
        log(onError.toString());
      });
    }, onOpen: (database) {
      getData(database);
    }).then((value) {
      db = value;
      emit(DuaaCreate());
    }).catchError((e) {
      log(e.toString());
    });
  }

  void insert({
    required String hadith,
    required String sona,
    required String name,
    required String type,
  }) {
    db?.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks (hadith,sona,name,type)VALUES("$hadith","$sona","$name","$type")')
          .then((value) {})
          .catchError((error) {
        log(error.toString());
      });
    }).then((value) {
      emit(DuaaInsert());
      getData(db);
    });
  }

  List<Map> favorites = [];

  void getData(database) {
    favorites = [];
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        favorites.add(element);
      });
      emit(DuaaGet());
    });
  }

  void updateData({
    required String type,
    required int id,
  }) {
    db!.rawUpdate('UPDATE tasks SET type = ? WHERE id = ?', [type, id]).then(
        (value) {
      emit(DuaaUpdate());
      getData(db);
    });
  }

  void deleteDataId({required int id}) {
    db!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      emit(DuaaDeleteId());
      getData(db);
    });
  }

  void deleteDataHadith({required String hadith}) {
    db!.rawDelete('DELETE FROM tasks WHERE hadith = ?', [hadith]).then((value) {
      emit(DuaaDeleteHadith());
      getData(db);
    });
  }
}
