import 'package:flutter/material.dart';
import 'm.screen/login.dart';
import 'm.screen/forgetpass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgetpass': (context) => const ForgetPasswordScreen(),
      },
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<_OnboardingPageData> _pages = [
    _OnboardingPageData(
      image: 'assets/images/Draw.png',
      
      title: 'Empowerment',
      description: 'Discover new opportunities and take control of your freelance journey with our powerful search and match capabilities.',
      buttonText: 'Next',
    ),
    _OnboardingPageData(
      image: 'assets/images/imageboarding2.png',
      title: 'Connectivity',
      description: 'Easily find and communicate with clients, manage projects, and build lasting professional relationships.',
      buttonText: 'Next',
    ),
    _OnboardingPageData(
      image: 'assets/images/imageboarding3.png',
      title: 'Security',
      description: 'Experience seamless transactions with our secure payment system, ensuring you get paid on time, every time.',
      buttonText: 'Next',
    ),
    _OnboardingPageData(
      image: 'assets/images/imageboarding4.png',
      title: 'Start your Career with us',
      description: 'Start your career with us today. Connect with opportunities and success awaits. Let\'s begin now!',
      buttonText: 'Finish',
    ),
    _OnboardingPageData(
      image: 'assets/images/imageboarding5.png',
      title: '',
      description: 'We provide you with the fastest, most secure, and highest quality services possible. Your satisfaction is our priority.',
      buttonText: 'Start',
    ),
  ];

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F1FA),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return _OnboardingPage(
                    data: page,
                    isLast: index == _pages.length - 1,
                    onNext: _onNext,
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 12),
                  width: 16,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? const Color.fromARGB(255, 52, 9, 170) : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPageData {
  final String image;
  final String title;
  final String description;
  final String buttonText;

  const _OnboardingPageData({
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
  });
}

class _OnboardingPage extends StatelessWidget {
  final _OnboardingPageData data;
  final bool isLast;
  final VoidCallback onNext;

  const _OnboardingPage({
    Key? key,
    required this.data,
    required this.isLast,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF8EC6E6).withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          child: Image.asset(
                            data.image,
                            width: 200,
                            height: 200,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: const Color(0xFF8EC6E6).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.image, 
                                size: 60, 
                                color: Color(0xFF8EC6E6),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (data.title.isNotEmpty)
                        Text(
                          data.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A2953),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      const SizedBox(height: 16),
                      Text(
                        data.description,
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      if (data.buttonText.isNotEmpty)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8EC6E6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: onNext,
                            child: Text(
                              data.buttonText,
                              style: const TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
