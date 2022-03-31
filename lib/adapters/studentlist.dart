import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

part 'studentlist.g.dart';

@HiveType(typeId: 0)
class Studentlist extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? phone;
  @HiveField(2)
  String? subject;
  @HiveField(3)
  String? address;
  @HiveField(4)
  String? image;
  Studentlist({this.name, this.phone, this.subject, this.address, this.image});
}

// flutter packages pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs
