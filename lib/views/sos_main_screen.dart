import 'package:flutter/material.dart';


class SOSMainScreen extends StatelessWidget {
  const SOSMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the primary color from the theme, similar to "?attr/colorPrimary"
    final Color primaryColor = Theme.of(context).primaryColor;

    // Define text styles for easy reuse, similar to Android's textAppearance
    final TextStyle firstAidTitleStyle = Theme.of(
      context,
    ).textTheme.bodyMedium!.copyWith(color: Colors.black);
    final TextStyle firstAidSubtitleStyle = Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(color: Colors.black, fontWeight: FontWeight.bold);
    final TextStyle emergencyCallTitleStyle = Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(color: Colors.black, fontWeight: FontWeight.bold);

    // Placeholder for simulating the BottomNavigationBar menu items
    const int _selectedIndex = 0;

    // Helper function to create the clickable layout sections
    Widget _buildActionItem({
      required IconData icon,
      required Color iconColor,
      required String title,
      required String subtitle,
      required TextStyle titleStyle,
      TextStyle? subtitleStyle,
      bool isLargeTitle = false,
    }) {
      return Container(
        // Added a placeholder InkWell for click action, similar to a clickable layout
        child: InkWell(
          onTap: () {
            // Handle tap action
            print('$title tapped');
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(icon, size: 64.0, color: iconColor),
                const SizedBox(height: 8.0),
                // Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: isLargeTitle
                      ? titleStyle
                      : subtitleStyle, // Using subtitleStyle for the smaller text here
                ),
                // Subtitle/Large Text
                if (!isLargeTitle)
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style:
                        titleStyle, // Using titleStyle for the larger text here
                  ),
              ],
            ),
          ),
        ),
      );
    }

    // Main Scaffold
    return Scaffold(
      // Equivalent to MaterialToolbar at the top
      appBar: AppBar(
        title: const Text('SOS Main Activity'), // Placeholder title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Equivalent to @drawable/ic_back
          onPressed: () {
            // Handle back button press
            Navigator.pop(context);
          },
        ),
        // Ensures no shadow under the AppBar
        elevation: 0,
      ),

      // Equivalent to BottomNavigationView
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // Replace these with your actual menu items
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          // Handle item tap
        },
      ),

      // Using a Column to stack the main content vertically
      body: Container(
        // Set top margin similar to android:layout_marginTop="30dp" on the main ConstraintLayout
        // Although the AppBar handles some of this, we ensure the content starts after it.
        // The padding on the Scaffold's body itself isn't the best practice for this,
        // so we use a small SizedBox at the top or rely on the overall structure.
        // We'll skip the body margin for idiomatic Flutter, as AppBar usually suffices.
        // If needed, use a Padding widget: Padding(padding: const EdgeInsets.only(top: 30.0), child: Column(...)).
        child: Column(
          // mainAxisAlignment is set to spaceAround/spaceBetween implicitly by Expanded widgets
          children: <Widget>[
            // The two main sections are centered around the 50% guideline.
            // Using Expanded widgets with equal flex ensures they take up 50% of the available vertical space each.

            // First Aid Layout (Top Half)
            Expanded(
              flex: 1, // Takes up 50% of remaining space
              child: _buildActionItem(
                icon: Icons.chat, // Equivalent to @drawable/ic_chat
                iconColor: primaryColor,
                title:
                    'Start a conversation', // Equivalent to @string/start_a_conversation (Bold/Large text)
                subtitle:
                    'First Aid Assistant', // Equivalent to @string/first_aid_assistant (Normal/Body text)
                titleStyle: firstAidSubtitleStyle,
                subtitleStyle: firstAidTitleStyle,
                // The order in the XML is Title (BodyMedium), then Subtitle (TitleLarge/Bold).
              ),
            ),

            // This acts as the space for the Guideline and ensures a 50/50 split.
            // A simple Divider can visually represent the separation if needed.
            const Divider(height: 1, thickness: 1, color: Colors.grey),

            // Emergency Call Layout (Bottom Half)
            Expanded(
              flex: 1, // Takes up 50% of remaining space
              child: _buildActionItem(
                icon: Icons.call, // Equivalent to @drawable/ic_call
                iconColor: primaryColor,
                title:
                    'Call your local emergency number', // Equivalent to @string/call_your_local_emergency_number
                subtitle:
                    '', // This layout only has one main text field below the icon
                titleStyle: emergencyCallTitleStyle,
                isLargeTitle: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
