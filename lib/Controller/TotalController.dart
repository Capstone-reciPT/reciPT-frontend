import 'package:get/get.dart';
import 'package:recipt/Controller/PageController.dart';

class TotalController extends GetxController {

  final CookingMenuController cookingMenuController = Get.put(CookingMenuController());
  final TtsController ttsController = Get.put(TtsController());
  final Controller controller = Get.put(Controller());

}