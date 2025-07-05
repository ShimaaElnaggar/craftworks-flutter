import 'package:craftworks/core/constants/colors_constants.dart';
import 'package:craftworks/core/constants/images_constants.dart';
import 'package:craftworks/widgets/custom_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  bool isSeen = false;
  bool agreeToTerms = false;

  void submitForm() {
    if (!agreeToTerms) {
      showTermsDialog();
      return;
    }

    if (_formKey.currentState!.validate()) {
      print("Form valid - proceed");
    }
  }

  void showTermsDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.blue.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 40),
            const SizedBox(height: 16),
            Center(
              child: const Text(
                "You must agree to \n our terms and \n conditions.",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsConstants.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 160,
              backgroundColor: Colors.white,
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Image.asset(ImagesConstants.logo, height: 100),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 8)),
            SliverToBoxAdapter(
              child: Text(
                'Create your account',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                'Pleasure to meet you !',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 32)),
            SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      label: 'Name',
                      hint: 'Shimaa',
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.trim().length < 6) {
                          return 'Name Field is Required at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Phone',
                      hint: "01237869734",
                      controller: phoneController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Phone Field is Required';
                        }
                        final phoneRegExp = RegExp(r'^01[0-2,5]{1}[0-9]{8}$');
                        if (!phoneRegExp.hasMatch(value.trim())) {
                          return 'Enter a valid phone number';
                        }

                        return null;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Email',
                      hint: 'shimaa@gmail.com',
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email Field is Required';
                        }
                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!emailRegex.hasMatch(value.trim())) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Password',
                      hint: '12qw!Q',
                      controller: passwordController,
                      obscureText: !isSeen,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: isSeen
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  isSeen = !isSeen;
                                });
                              },
                              icon: Icon(Icons.remove_red_eye),
                            )
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  isSeen = !isSeen;
                                });
                              },
                              icon: Icon(Icons.visibility_off),
                            ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.contains(
                              RegExp(
                                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#$@!%*?&])[A-Za-z\d#$@!%*?&]{6,}$',
                              ),
                            )) {
                          return '''Password Field is Required at least 6 characters, should contain Capital Letters, Small Letters, Number and
                                     symbols like #%''';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Confirm Password',
                      hint: "******",
                      controller: confirmPasswordController,
                      textInputAction: TextInputAction.next,
                      obscureText: !isSeen,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: isSeen
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  isSeen = !isSeen;
                                });
                              },
                              icon: Icon(Icons.remove_red_eye),
                            )
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  isSeen = !isSeen;
                                });
                              },
                              icon: Icon(Icons.visibility_off),
                            ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Confirm Password is required";
                        }
                        if (value != passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: ColorsConstants.primaryColor,
                          value: agreeToTerms,
                          onChanged: (val) =>
                              setState(() => agreeToTerms = val!),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: 'I agree to the ',
                              style: TextStyle(
                                color: agreeToTerms ? Colors.green : Colors.red,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Terms & Conditions',
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text(
                                            "Terms & Conditions",
                                          ),
                                          content: const Text("............."),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("Close"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                ),
                                const TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsConstants.primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: submitForm,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 16),
                    Row(
                      children: const [
                        Expanded(child: Divider(thickness: 1)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Continue with",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(child: Divider(thickness: 1)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.g_mobiledata, size: 40),
                        SizedBox(width: 16),
                        Icon(Icons.facebook, size: 30),
                        SizedBox(width: 16),
                        Icon(Icons.apple, size: 30),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: ColorsConstants.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
