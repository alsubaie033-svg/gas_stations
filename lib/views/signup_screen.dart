import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../controllers/auth_controller.dart';

class SignupScreen extends GetView<AuthController> {
  SignupScreen({super.key}){
    // Ensure the controller is available (it should ideally be bound in GetMaterialApp)
    if (!Get.isRegistered<AuthController>()) {
      Get.put(AuthController());
    }
  }


  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Back Button and Title
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Get.back(),
                    splashRadius: 20,
                  ),
                  const SizedBox(width: 8.0),
                  const Expanded(
                    child: Text(
                      'Create account',
                      style: TextStyle(
                        color: Color(0xFF4CAF50),
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),

              // Logo Placeholder
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.local_gas_station,
                  size: 80,
                  color: Color(0xFFFF9800),
                ),
              ),
              const SizedBox(height: 20.0),

              FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: <Widget>[
                    // Username Field
                    FormBuilderTextField(
                      name: 'username',
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.required(),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 12.0),

                    // Email Field
                    FormBuilderTextField(
                      name: 'email',
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12.0),

                    // Password Field
                    FormBuilderTextField(
                      name: 'password',
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(6),
                      ]),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 12.0),

                    // Confirm Password Field
                    FormBuilderTextField(
                      name: 'confirm_password',
                      decoration: const InputDecoration(
                        labelText: 'Confirm password',
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        (val) {
                          if (val !=
                              _formKey
                                  .currentState
                                  ?.fields['password']
                                  ?.value) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ]),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 10.0),

                    // Terms Checkbox
                    Obx(
                      () => CheckboxListTile(
                        value: controller.areTermsAccepted.value,
                        onChanged: controller.toggleTerms,
                        title: const Text(
                          'I accept the terms and privacy policy',
                          style: TextStyle(color: Colors.black),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // Sign Up Button
                    Obx(
                      () => SizedBox(
                        height: 55.0,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  if (_formKey.currentState
                                          ?.saveAndValidate() ==
                                      true) {
                                    controller.signUp(
                                      _formKey.currentState!.value,
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8BC34A),
                            textStyle: const TextStyle(fontSize: 18),
                            foregroundColor: Colors.white,
                          ),
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text('Sign up'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),

              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(width: 4.0),
                  GestureDetector(
                    onTap: controller.goToLogin,
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        color: Color(0xFFFF9800),
                        fontWeight: FontWeight.bold,
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


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// // Assuming your controller file is in the same directory or adjust the import path
// import 'auth_controller.dart';

// class SignupScreen extends GetView<AuthController> {
//   SignupScreen({super.key}) {
//     // Inject the controller if it hasn't been done elsewhere (e.g., GetMaterialApp)
//     if (!Get.isRegistered<AuthController>()) {
//       Get.put(AuthController());
//     }
//   }

//   // Key for the form
//   final _formKey = GlobalKey<FormBuilderState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // Wrap content in SingleChildScrollView like the XML's ScrollView
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(10.0),
//         child: Padding(
//           padding: const EdgeInsets.only(top: 30.0),
//           child: Column(
//             // gravity="center_horizontal"
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               // Back Button and Title (Equivalent to ConstraintLayout)
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back),
//                     // src="@drawable/ic_back" - use a standard icon
//                     onPressed: () => Get.back(),
//                     splashRadius: 20,
//                   ),
//                   const SizedBox(width: 8.0),
//                   const Expanded(
//                     child: Text(
//                       'Create account',
//                       style: TextStyle(
//                         color: Color(0xFF4CAF50), // #4CAF50
//                         fontSize: 22.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20.0),

//               // Logo (ImageView)
//               // This image placeholder assumes you have an asset named 'gas_station_logo.png'
//               const Image(
//                 // Replace with actual asset path if you have one
//                 image: AssetImage('assets/images/gas_station_logo.png'),
//                 width: 150,
//                 height: 150,
//               ),
//               const SizedBox(height: 20.0),

//               // FormBuilder to manage all text fields
//               FormBuilder(
//                 key: _formKey,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 child: Column(
//                   children: <Widget>[
//                     // Username Field
//                     FormBuilderTextField(
//                       name: 'username',
//                       decoration: const InputDecoration(
//                         labelText: 'Username',
//                         border: OutlineInputBorder(), // OutlinedBox style
//                         contentPadding: EdgeInsets.symmetric(
//                           vertical: 16,
//                           horizontal: 12,
//                         ),
//                       ),
//                       validator: FormBuilderValidators.compose([
//                         FormBuilderValidators.required(),
//                         FormBuilderValidators.minLength(3),
//                       ]),
//                       keyboardType: TextInputType.text,
//                     ),
//                     const SizedBox(height: 12.0),

//                     // Email Field
//                     FormBuilderTextField(
//                       name: 'email',
//                       decoration: const InputDecoration(
//                         labelText: 'Email',
//                         border: OutlineInputBorder(),
//                         contentPadding: EdgeInsets.symmetric(
//                           vertical: 16,
//                           horizontal: 12,
//                         ),
//                       ),
//                       validator: FormBuilderValidators.compose([
//                         FormBuilderValidators.required(),
//                         FormBuilderValidators.email(),
//                       ]),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     const SizedBox(height: 12.0),

//                     // Password Field
//                     FormBuilderTextField(
//                       name: 'password',
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         border: const OutlineInputBorder(),
//                         // app:passwordToggleEnabled="true"
//                         suffixIcon: IconButton(
//                           icon: const Icon(Icons.remove_red_eye),
//                           onPressed: () {}, // Implement actual toggle if needed
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                           vertical: 16,
//                           horizontal: 12,
//                         ),
//                       ),
//                       validator: FormBuilderValidators.compose([
//                         FormBuilderValidators.required(),
//                         FormBuilderValidators.minLength(6),
//                       ]),
//                       obscureText:
//                           true, // Equivalent to inputType="textPassword"
//                       keyboardType: TextInputType.text,
//                     ),
//                     const SizedBox(height: 12.0),

//                     // Confirm Password Field
//                     FormBuilderTextField(
//                       name: 'confirm_password',
//                       decoration: InputDecoration(
//                         labelText: 'Confirm password',
//                         border: const OutlineInputBorder(),
//                         suffixIcon: IconButton(
//                           icon: const Icon(Icons.remove_red_eye),
//                           onPressed: () {}, // Implement actual toggle if needed
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                           vertical: 16,
//                           horizontal: 12,
//                         ),
//                       ),
//                       validator: FormBuilderValidators.compose([
//                         FormBuilderValidators.required(),
//                         (val) {
//                           // Custom validation to match the password field
//                           if (val !=
//                               _formKey
//                                   .currentState
//                                   ?.fields['password']
//                                   ?.value) {
//                             return 'Passwords do not match';
//                           }
//                           return null;
//                         },
//                       ]),
//                       obscureText: true,
//                       keyboardType: TextInputType.text,
//                     ),
//                     const SizedBox(height: 10.0),

//                     // Terms Checkbox
//                     Obx(
//                       () => CheckboxListTile(
//                         value: controller.areTermsAccepted.value,
//                         onChanged: controller.toggleTerms,
//                         title: const Text(
//                           'I accept the terms and privacy policy',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                         controlAffinity: ListTileControlAffinity.leading,
//                         contentPadding: EdgeInsets.zero,
//                       ),
//                     ),
//                     const SizedBox(height: 20.0),

//                     // Sign Up Button
//                     Obx(
//                       () => SizedBox(
//                         height: 55.0,
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: controller.isLoading.value
//                               ? null
//                               : () {
//                                   // Validate the form
//                                   if (_formKey.currentState
//                                           ?.saveAndValidate() ==
//                                       true) {
//                                     // Pass form data to the controller
//                                     controller.signUp(
//                                       _formKey.currentState!.value,
//                                     );
//                                   }
//                                 },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF8BC34A), // #8BC34A
//                             textStyle: const TextStyle(fontSize: 18),
//                             foregroundColor: Colors.white,
//                           ),
//                           child: controller.isLoading.value
//                               ? const CircularProgressIndicator(
//                                   color: Colors.white,
//                                 )
//                               : const Text('Sign up'),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 15.0),

//               // Already have an account? Log in (LinearLayout horizontal)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Already have an account?',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   const SizedBox(width: 4.0),
//                   GestureDetector(
//                     onTap: controller.goToLogin, // Call GetX controller method
//                     child: const Text(
//                       'Log in',
//                       style: TextStyle(
//                         color: Color(0xFFFF9800), // #FF9800
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
