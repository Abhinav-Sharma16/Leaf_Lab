import 'package:get/get.dart';
import 'package:leaf_lab/utils/helpers/network_manager.dart';

class generalBindings extends Bindings{
  @override
  void dependencies(){
    Get.put(NetworkManager());
  }
}