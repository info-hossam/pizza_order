import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginAndRegisterScreen extends StatefulWidget {
  const LoginAndRegisterScreen({Key? key}) : super(key: key);

  @override
  State<LoginAndRegisterScreen> createState() => _LoginAndRegisterScreenState();
}

class _LoginAndRegisterScreenState extends State<LoginAndRegisterScreen> {
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _numberController;
  TextEditingController? _passController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLogin = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _numberController = TextEditingController();
    _passController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController?.dispose();
    _emailController?.dispose();
    _numberController?.dispose();
    _passController?.dispose();
    super.dispose();
  }

  void _changePageState() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //TODO: CHANGE THIS TO THAE APP LOGO
                  Text(
                    (_isLogin) ? 'Login' : 'REGISTER',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (!_isLogin)
                    defaultFormField(
                      hint: 'Jhon Duo',
                      label: 'Username',
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'This field can not be empty';
                        }
                        if (value.length > 8) {
                          return 'Username can not be more than 8 characters';
                        }
                        return null;
                      },
                      controller: _nameController,
                      prefixIcon: EvaIcons.personOutline,
                    ),

                  if (!_isLogin) const SizedBox(height: 16),
                  defaultFormField(
                    hint: 'example@gmail.com',
                    label: 'Email',
                    validate: (String? value) {
                      if (value!.isEmpty) return 'This field can not be empty';
                      return null;
                    },
                    controller: _emailController,
                    prefixIcon: EvaIcons.emailOutline,
                  ),

                  if (!_isLogin) const SizedBox(height: 16),
                  if (!_isLogin)
                    defaultFormField(
                      hint: '+20 12345678912',
                      label: 'Phone Number',
                      keyboardType: TextInputType.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'This field can not be empty';
                        }
                        if (value.length > 11) {
                          return 'Phone number can not be more than 11 characters';
                        }
                        return null;
                      },
                      controller: _numberController,
                      prefixIcon: EvaIcons.phoneOutline,
                    ),

                  const SizedBox(height: 16),
                  defaultFormField(
                    hint: '*********',
                    label: 'Password',
                    keyboardType: const TextInputType.numberWithOptions(),
                    validate: (String? value) {
                      if (value!.isEmpty) return 'This field can not be empty';
                      if (value.length < 8) {
                        return 'Password can not be more less than 11 characters';
                      }
                      return null;
                    },
                    controller: _passController,
                    prefixIcon: EvaIcons.lockOutline,
                    isPassword: true,
                    hidePassword: true,
                  ),

                  const SizedBox(height: 30),
                  MaterialButton(
                    onPressed: () {
                      if (_isLogin) {
                      } else {}
                    },
                    elevation: 7.5,
                    color: const Color(0xFFFFC56B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minWidth: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      (_isLogin) ? 'Login' : 'REGISTER',
                      style: const TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => _changePageState(),
                    child: Text(
                      (_isLogin)
                          ? 'Don\'t have an account? Register'
                          : 'Already have an account? Login',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField defaultFormField({
    TextEditingController? controller,
    @required String? hint,
    @required String? label,
    @required String? Function(String?)? validate,
    VoidCallback? changePasswordVisibilty,
    IconData? prefixIcon,
    TextInputType? keyboardType,
    bool isPassword = false,
    bool? hidePassword,
  }) =>
      TextFormField(
        controller: controller,
        obscureText: hidePassword ?? false,
        keyboardType: keyboardType ?? TextInputType.name,
        validator: validate,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            // fontFamily: ConstantFonts.fontMonteserat,
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          prefix: Icon(
            prefixIcon,
            color: Colors.black,
          ),
          suffix: (isPassword)
              ? IconButton(
                  onPressed: changePasswordVisibilty,
                  icon: Icon(
                    (hidePassword!)
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                    color: Colors.black,
                    size: 20,
                  ),
                )
              : null,
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      );
}