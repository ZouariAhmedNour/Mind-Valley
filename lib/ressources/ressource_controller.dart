import 'package:get/get.dart';
import 'package:mind_valley/Models/ressource.dart';
import 'package:mind_valley/Services/resource_api.dart';


class ResourceController extends GetxController {
  final ResourceApi _api = ResourceApi();

  var resources = <Ressource>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchResources();
  }

  void fetchResources() async {
    try {
      isLoading(true);
      final fetchedResources = await _api.fetchResources();
      resources.assignAll(fetchedResources);
    } catch (e) {
      print('Error fetching resources: $e');
    } finally {
      isLoading(false);
    }
  }
}
