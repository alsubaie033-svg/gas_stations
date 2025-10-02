import 'package:flutter/material.dart';

// Changed from GetView<AuthController> to StatelessWidget for pure design
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Helper method to show a standard SnackBar since Get.snackbar is removed
  void _showSnackbar(
    BuildContext context,
    String message, {
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor ?? Colors.black,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // String resource simulation:
    const String searchHint = 'Search here';
    const String descriptionText =
        'You can see available near-by station and request available fuel';
    const Color primaryGreen = Color(
      0xFF388E3C,
    ); // Dark Green (used for welcome text and Buy Now button text)
    const Color lightGreen = Color(0xFF4CAF50); // Light Green
    const Color primaryOrange = Color(
      0xFFFF9800,
    ); // Orange (used for popular gas card background)
    const Color primaryBlue = Color(0xFF42A5F5); // Blue (used for 91/89 text)
    const Color lightBlueBackground = Color(
      0xFFE3F2FD,
    ); // Light Blue background for number cards

    // Placeholder for the Gas Pump Image (since assets aren't available)
    Widget gasPumpImage = Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(125),
      ),
      child: const Icon(
        Icons.local_gas_station,
        size: 150,
        color: primaryGreen,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Top Bar (Menu Icon and SOS Button)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Menu Icon
                    IconButton(
                      icon: const Icon(Icons.menu, size: 30),
                      onPressed: () {
                        // Dummy action using local SnackBar
                        _showSnackbar(context, 'Menu icon pressed');
                      },
                      splashRadius: 25,
                    ),

                    // SOS Button
                    InkWell(
                      onTap: () {
                        // Dummy action using local SnackBar
                        _showSnackbar(
                          context,
                          'SOS button pressed!',
                          backgroundColor: Colors.red,
                        );
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.red, // Mimicking sos_button_background
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          "SOS",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24.0),

              // Search Bar and Filter Button
              Row(
                children: [
                  // Search Bar Layout
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color:
                            Colors.grey[100], // Mimicking search_bar_background
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Color(0xFF999999),
                            size: 20,
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: searchHint,
                                hintStyle: TextStyle(
                                  color: Color(0xFF999999),
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 8.0),

                  // Filter Button
                  InkWell(
                    onTap: () {
                      // Dummy action using local SnackBar
                      _showSnackbar(context, 'Filter button pressed.');
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color:
                            lightGreen, // Mimicking filter_button_background style
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.filter_alt,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24.0),

              // Gas Pump Image
              Center(child: gasPumpImage),

              const SizedBox(height: 8.0),

              // Welcome Text
              const Center(
                child: Text(
                  "Welcome to Gas Station App",
                  style: TextStyle(
                    color: primaryGreen,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 4.0),

              // Description Text
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    descriptionText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF757575), fontSize: 14),
                  ),
                ),
              ),

              const SizedBox(height: 24.0),

              // Popular Gas Card (CardView equivalent)
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 4.0,
                child: Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: primaryOrange,
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    // src="@drawable/gas_card_background" is simulated by the background color
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Popular",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Gasoline",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          SizedBox(
                            height:
                                35, // Adjusted from 48dp to fit content nicely
                            child: ElevatedButton(
                              onPressed: () {
                                // Dummy action using local SnackBar
                                _showSnackbar(
                                  context,
                                  'Buy Now pressed for Gasoline.',
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: primaryGreen,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text("Buy Now"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16.0),

              // 91 and 89 Cards (Horizontal LinearLayout equivalent)
              Row(
                children: [
                  // Card 91
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.only(right: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 4.0,
                      color: lightBlueBackground,
                      child: const SizedBox(
                        height: 100,
                        child: Center(
                          child: Text(
                            "91",
                            style: TextStyle(
                              color: primaryBlue,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Card 89
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.only(left: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 4.0,
                      color: lightBlueBackground,
                      child: const SizedBox(
                        height: 100,
                        child: Center(
                          child: Text(
                            "89",
                            style: TextStyle(
                              color: primaryBlue,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
