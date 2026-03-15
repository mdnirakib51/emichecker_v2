import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/dashboard/dashboard_screen.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/global_progress_hub.dart';
import '../../../global/widget/global_text.dart';
import '../../../global/widget/global_textform_field.dart';
import '../controller/auth_controller.dart';
import '../controller/auth_service.dart';
import 'components/auth_background_com.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailCon = TextEditingController(text: "admin@gmail.com");
  TextEditingController passCon = TextEditingController(text: "12345");
  late bool _rememberMe;

  late AnimationController _entryController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _rememberMe = false;
    _loadSavedCredentials();

    _entryController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(parent: _entryController, curve: Curves.easeOutCubic),
        );

    _entryController.forward();
  }

  @override
  void dispose() {
    _entryController.dispose();
    emailCon.dispose();
    passCon.dispose();
    super.dispose();
  }

  void _saveCredentials() {
    AuthService.saveCredentials(
      email: emailCon.text,
      password: passCon.text,
      rememberMe: _rememberMe,
    );
  }

  void _loadSavedCredentials() {
    final credentials = AuthService.loadSavedCredentials();
    setState(() {
      emailCon.text = credentials['email'] ?? "";
      passCon.text = credentials['password'] ?? "";
      _rememberMe = credentials['remember_me'] ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ProgressHUD(
          inAsyncCall: authController.isLoading,
          child: Form(
            key: formKey,
            child: AuthBackGroundCom(
              children: [
                // ── Header area (top curved zone)
                SizedBox(
                  height: h * 0.26,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Brand row
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.35),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.electric_bolt_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 10),
                            GlobalText(
                              str: 'EMI Store',
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),

                        const Spacer(),

                        GlobalText(
                          str: "Welcome Back!",
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                        const SizedBox(height: 4),
                        GlobalText(
                          str: "Sign in to continue",
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),

                // ── Form card (middle white area)
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Form card
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorRes.appColor
                                        .withValues(alpha: 0.1),
                                    blurRadius: 24,
                                    spreadRadius: 0,
                                    offset: const Offset(0, 6),
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                border: Border.all(
                                  color: ColorRes.appColor
                                      .withValues(alpha: 0.08),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Card header
                                  Row(
                                    children: [
                                      Container(
                                        width: 4,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: ColorRes.appColor,
                                          borderRadius:
                                          BorderRadius.circular(2),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GlobalText(
                                        str: 'Login to your account',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: ColorRes.appColor,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 22),

                                  // Email field
                                  _buildFieldLabel('Email / ID / Phone'),
                                  const SizedBox(height: 6),
                                  GlobalTextFormField(
                                    controller: emailCon,
                                    hintText: 'Enter your email or ID',
                                    decoration: _fieldDecoration(
                                        Icons.person_outline_rounded),
                                    filled: true,
                                    fillColor:
                                    ColorRes.appColor.withValues(alpha: 0.03),
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (val) {
                                      setState(() => _saveCredentials());
                                    },
                                  ),

                                  const SizedBox(height: 16),

                                  // Password field
                                  _buildFieldLabel('Password'),
                                  const SizedBox(height: 6),
                                  GlobalTextFormField(
                                    controller: passCon,
                                    hintText: 'Enter your password',
                                    decoration: _fieldDecoration(
                                        Icons.lock_outline_rounded),
                                    filled: true,
                                    fillColor:
                                    ColorRes.appColor.withValues(alpha: 0.03),
                                    isDense: true,
                                    isPasswordField: true,
                                    onChanged: (val) {
                                      setState(() => _saveCredentials());
                                    },
                                  ),

                                  const SizedBox(height: 14),

                                  // Remember me row
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _rememberMe = !_rememberMe;
                                            _saveCredentials();
                                          });
                                        },
                                        child: AnimatedContainer(
                                          duration:
                                          const Duration(milliseconds: 200),
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: _rememberMe
                                                ? ColorRes.appColor
                                                : Colors.transparent,
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            border: Border.all(
                                              color: _rememberMe
                                                  ? ColorRes.appColor
                                                  : Colors.grey.shade400,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: _rememberMe
                                              ? const Icon(Icons.check_rounded,
                                              color: Colors.white, size: 14)
                                              : null,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GlobalText(
                                        str: "Remember Me",
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 24),

                                  // Sign In button
                                  GestureDetector(
                                    onTap: () async {
                                      Get.offAll(() => const DashboardScreen());
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(12),
                                        gradient: LinearGradient(
                                          colors: [
                                            ColorRes.appColor,
                                            ColorRes.appColor
                                                .withValues(alpha: 0.8),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorRes.appColor
                                                .withValues(alpha: 0.35),
                                            blurRadius: 14,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.login_rounded,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 10),
                                          GlobalText(
                                            str: 'SIGN IN',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                          ),
                                        ],
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
                  ),
                ),

                // ── Bottom spacer (bottom curved zone)
                SizedBox(height: h * 0.18),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildFieldLabel(String label) {
    return GlobalText(
      str: label,
      fontSize: 11,
      fontWeight: FontWeight.w700,
      color: ColorRes.appColor.withValues(alpha: 0.8),
    );
  }

  InputDecoration _fieldDecoration(IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: ColorRes.appColor.withValues(alpha: 0.5), size: 18),
      hintStyle: TextStyle(
        fontSize: 13,
        color: Colors.grey.shade400,
        fontWeight: FontWeight.w400,
      ),
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
        BorderSide(color: ColorRes.appColor.withValues(alpha: 0.15)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
        BorderSide(color: ColorRes.appColor.withValues(alpha: 0.15)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ColorRes.appColor, width: 1.5),
      ),
    );
  }
}