import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  int _selectedMethod = 1; 
  bool _showOtpScreen = false;
  String _otp = '';
  int _timer = 60;

  void _goToOtpScreen() {
    setState(() {
      _showOtpScreen = true;
      _timer = 60;
      _otp = '';
    });
    _startTimer();
  }

  void _startTimer() {
    Future.doWhile(() async {
      if (_timer > 0 && _showOtpScreen) {
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          setState(() {
            _timer--;
          });
        }
        return true;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              centerTitle: true,
      title: 
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          "Herfa",
          style: TextStyle(
        color: Color(0xFF102C5B),
        fontWeight: FontWeight.w700,
        fontSize: 50,
        shadows: [
          Shadow(
            offset: Offset(3, 3),
            blurRadius: .8,
            color: const Color.fromARGB(255, 6, 51, 110),
          ),
        ],
          ),
        ),
      ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (_showOtpScreen) {
              setState(() {
                _showOtpScreen = false;
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body:
       _showOtpScreen ? _OtpScreen(
        email: 'khad****@gmail.com',
        timer: _timer,
        onResend: () {
          setState(() {
            _timer = 60;
          });
          _startTimer();
        },
        onOtpChanged: (value) {
          setState(() {
            _otp = value;
          });
        },
        onVerify: () {},
      ) : _ContactSelectionScreen(
        selectedMethod: _selectedMethod,
        onSelect: (method) {
          setState(() {
            _selectedMethod = method;
          });
        },
        onNext: _goToOtpScreen,
      ),
    );
  }
}

class _ContactSelectionScreen extends StatelessWidget {
  final int selectedMethod;
  final ValueChanged<int> onSelect;
  final VoidCallback onNext;

  const _ContactSelectionScreen({
    Key? key,
    required this.selectedMethod,
    required this.onSelect,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[ 
                 Positioned(
            top: -100,
          left: -100,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.withOpacity(.01),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(.3),
                  blurRadius: 100,
                  spreadRadius: 100,
                )
              ]
            ),
          ),),

        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Center(
              child: Image.asset(
                'assets/images/forget.png',
                height: 140,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.lock, size: 100, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Select which contact details should we use to reset your Password',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            _ContactOption(
              icon: Icons.sms,
              label: 'Via SMS',
              value: 1,
              selected: selectedMethod == 1,
              detail: '+21365*****52',
              onTap: () => onSelect(1),
            ),
            const SizedBox(height: 16),
            _ContactOption(
              icon: Icons.email,
              label: 'Via Email',
              value: 2,
              selected: selectedMethod == 2,
              detail: 'khad****@gmail.com',
              onTap: () => onSelect(2),
            ),
            SizedBox(height: 20,),
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
                child: const Text('Next', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
                      Positioned(
            bottom: -100,
            right: -100,
            child: Container(
            width: 200,
            height: 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.withOpacity(.01),
              boxShadow: [
                BoxShadow(color: Colors.blue.withOpacity(.6),
                blurRadius: 150,
                spreadRadius: 100,
                )

              ]
            ),

          )),

    ]);
  }
}

class _ContactOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String detail;
  final int value;
  final bool selected;
  final VoidCallback onTap;

  const _ContactOption({
    Key? key,
    required this.icon,
    required this.label,
    required this.detail,
    required this.value,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE3F1FA) : Colors.white,
          border: Border.all(
            color: selected ? const Color(0xFF8EC6E6) : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? const Color(0xFF8EC6E6) : Colors.grey),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(detail, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle, color: Color(0xFF8EC6E6))
            else
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class _OtpScreen extends StatelessWidget {
  final String email;
  final int timer;
  final VoidCallback onResend;
  final ValueChanged<String> onOtpChanged;
  final VoidCallback onVerify;

  const _OtpScreen({
    Key? key,
    required this.email,
    required this.timer,
    required this.onResend,
    required this.onOtpChanged,
    required this.onVerify,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          const Text(
            'OTP Code Verification',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            'code has been sent to $email',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _OtpInputField(
            length: 4,
            onChanged: onOtpChanged,
          ),
          const SizedBox(height: 16),
          timer > 0
              ? Text('Resend the code in $timer s', style: const TextStyle(color: Colors.grey))
              : TextButton(
                  onPressed: onResend,
                  child: const Text('Resend the code'),
                ),
          const SizedBox(height: 32),
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
              onPressed: onVerify,
              child: const Text('Verify', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpInputField extends StatefulWidget {
  final int length;
  final ValueChanged<String> onChanged;

  const _OtpInputField({Key? key, required this.length, required this.onChanged}) : super(key: key);

  @override
  State<_OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<_OtpInputField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged() {
    String code = _controllers.map((c) => c.text).join();
    widget.onChanged(code);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (i) {
        return Container(
          width: 48,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          child: TextField(
            controller: _controllers[i],
            focusNode: _focusNodes[i],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && i < widget.length - 1) {
                _focusNodes[i + 1].requestFocus();
              }
              if (value.isEmpty && i > 0) {
                _focusNodes[i - 1].requestFocus();
              }
              _onChanged();
            },
          ),
        );
      }),
    );
  }
}
