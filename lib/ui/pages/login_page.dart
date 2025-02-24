import 'package:articles/components/components.dart';
import 'package:articles/components/input_field.dart';
import 'package:articles/logic/login/login_cubit.dart';
import 'package:articles/models/validator.dart';
import 'package:articles/ui/pages/home_screen.dart';
import 'package:articles/ui/pages/signup_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  late LoginCubit loginCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginCubit = context.read<LoginCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          onLoginSuccess();
        } else if (state is LoginFailure) {
          onLoginFailure(state.errorMessage);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              child: ListView(
                shrinkWrap: true,
                children: [
                  SvgPicture.asset(
                    'assets/coloredLogo.svg',
                    height: 45,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    width: 450,
                    height: 600,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      boxShadow: const [BoxShadow(color: Colors.white)],
                    ),
                    child: ListView(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Sign In to INSITE OOH",
                              style: GoogleFonts.redHatDisplay(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "New Here? ",
                                  style: GoogleFonts.redHatDisplay(
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpScreen(),
                                          ));
                                    },
                                  text: "Create an account",
                                  style: GoogleFonts.redHatDisplay(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: GoogleFonts.redHatDisplay(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        //put the email address
                        inputField(
                            label: "",
                            validator: (value) =>
                                emailValidator(value.toString()),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress),
                        const SizedBox(
                          height: 16,
                        ),
                        //put the password address
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Password",
                              style: GoogleFonts.redHatDisplay(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUpScreen(),
                                    ));
                              },
                              child: const Text(
                                " Forget Password ?",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ],
                        ),
                        inputField(
                            label: "",
                            validator: (value) =>
                                passwordValidator(value.toString()),
                            controller: passwordController,
                            obscureText: isPasswordVisable,
                            suffixIcon: myIconWidget()),
                        const SizedBox(
                          height: 26,
                        ),
                        myButtonWidget(
                          texts: "LOGIN",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              loginCubit.login(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: Text(
                            "OR",
                            style:
                                GoogleFonts.redHatDisplay(color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xfff5f8fa),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/google.png',
                                  width: 20,
                                  height: 50,
                                ),
                                const SizedBox(width: 9.75),
                                Text(
                                  "Continue with Google",
                                  style: GoogleFonts.redHatDisplay(
                                    color: const Color(0xff7e8299),
                                    fontSize: 14.95,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xfff5f8fa),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/facebook.png',
                                  width: 20,
                                  height: 50,
                                ),
                                const SizedBox(width: 9.75),
                                Text(
                                  "Continue with Facebook",
                                  style: GoogleFonts.redHatDisplay(
                                    color: const Color(0xff7e8299),
                                    fontSize: 14.95,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onLoginSuccess() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ArticlesScreen(),
        ));
  }

  void onLoginFailure(String errorMessage) {
    SnackBar snackBar = SnackBar(
      content: Text(errorMessage),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget myIconWidget() {
    return InkWell(
        onTap: () {
          isPasswordVisable = !isPasswordVisable;
          setState(() {});
        },
        child: isPasswordVisable
            ? const Icon(
                Icons.visibility_off,
                size: 22,
                color: Colors.amber,
              )
            : const Icon(
                Icons.visibility,
                size: 22,
                color: Colors.amber,
              ));
  }
}
