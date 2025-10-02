import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var query = ''.obs;

  // Sample Data
  var gasStations = <Map<String, dynamic>>[
    {
      "station": "Station A",
      "fuels": ["Diesel", "Petrol 92", "Petrol 95"],
    },
    {
      "station": "Station B",
      "fuels": ["Diesel", "Gasoline", "Premium"],
    },
    {
      "station": "Station C",
      "fuels": ["LPG", "CNG"],
    },
  ].obs;

  void search(String value) {
    query.value = value;
    // TODO: Add filtering logic if needed
  }

  void onMenuTap() {
    Get.snackbar("Menu", "Menu button tapped");
  }

  void onSosTap() {
    Get.snackbar("SOS", "SOS button tapped");
  }

  void onFilterTap() {
    Get.snackbar("Filter", "Filter button tapped");
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              /// --- Top Row: Menu + SOS ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: controller.onMenuTap,
                    child: const Icon(
                      Icons.menu,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.onSosTap,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "SOS",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// --- Search Bar + Filter ---
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              onChanged: controller.search,
                              decoration: const InputDecoration(
                                hintText: "Search here...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: controller.onFilterTap,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Icon(Icons.filter_alt, color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// --- Gas Stations with expandable fuel list ---
              Expanded(
                child: Obx(() {
                  if (controller.gasStations.isEmpty) {
                    return const Center(child: Text("No gas stations found"));
                  }
                  return ListView.builder(
                    itemCount: controller.gasStations.length,
                    itemBuilder: (context, index) {
                      final station = controller.gasStations[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ExpansionTile(
                          title: Text(
                            station["station"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          leading: const Icon(
                            Icons.local_gas_station,
                            color: Colors.green,
                          ),
                          children: (station["fuels"] as List<String>)
                              .map(
                                (fuel) => ListTile(
                                  leading: const Icon(
                                    Icons.local_fire_department,
                                    color: Colors.orange,
                                  ),
                                  title: Text(fuel),
                                  onTap: () {
                                    Get.snackbar(
                                      "Fuel Selected",
                                      "${station["station"]} - $fuel",
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
