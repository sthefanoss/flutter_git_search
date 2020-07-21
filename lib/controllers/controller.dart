import 'package:get/get.dart';

enum ControllerStatus { ok, awaiting, withError }

extension ControllerStatusExtension on ControllerStatus {
  bool get isOk => this == ControllerStatus.ok;
  bool get isAwaiting => this == ControllerStatus.awaiting;
  bool get hasError => this == ControllerStatus.withError;
}

class Controller extends GetxController {
  final status = Rx<ControllerStatus>(ControllerStatus.awaiting);

  @override
  void onInit() => super.onInit();

  @override
  void onStart() => super.onStart();

  @override
  void onReady() => super.onReady();

  @override
  void onClose() => super.onClose();
}
