import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../../config/constants/hive_table_constant.dart';

final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
  }

  Future<void> setData({required Map<String, dynamic> userData}) async {
    final box = await Hive.openBox(HiveTableConstant.userBox);
    await box.put('data', userData);
    await box.close();
  }

  Future<void> removeData() async {
    final box = await Hive.openBox(HiveTableConstant.userBox);
    await box.delete('data');
    await box.close();
  }

  Future<Map<String, dynamic>?> getData() async {
    try {
      final box = await Hive.openBox(HiveTableConstant.userBox);
      final data = await box.get('data');
      if (data == null) {
        return null;
      }

      // Cast the data to Map<dynamic, dynamic>
      final Map<dynamic, dynamic> dynamicMap = data as Map<dynamic, dynamic>;

      // Transform to Map<String, dynamic>
      final stringMap = dynamicMap.map((key, value) {
        return MapEntry(key.toString(), value);
      });

      return stringMap;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // ============================= Close Hive ===========================
  Future<void> closeHive() async {
    await Hive.close();
  }

  // ============================= Delete Hive ===========================
  Future<void> deleteHive() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
    await Hive.deleteFromDisk();
  }
}
