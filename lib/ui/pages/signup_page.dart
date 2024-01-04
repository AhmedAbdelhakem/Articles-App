import 'package:articles/components/components.dart';
import 'package:articles/components/input_field.dart';
import 'package:articles/logic/signup/signup_cubit.dart';
import 'package:articles/ui/pages/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();
  late SignupCubit signupCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signupCubit = context.read<SignupCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          onRegisterSuccess();
        } else if (state is RegisterFailureState) {
          onRegisterFailure(state.errorMessage);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(top: 55),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/coloredLogo.svg',
                      height: 45,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 450,
                      height: 750,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        boxShadow: [BoxShadow(color: Colors.white)],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Create an Account",
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
                                      text: "Already Have acccount ? ",
                                      style: GoogleFonts.redHatDisplay(
                                          color: Colors.grey[400],
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    TextSpan(
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen(),
                                              ));
                                        },
                                      text: "Sign in here",
                                      style: GoogleFonts.redHatDisplay(
                                          color: Colors.amber,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xfff5f8fa),
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
                                    SizedBox(width: 9.75),
                                    Text(
                                      "Continue with Google",
                                      style: GoogleFonts.redHatDisplay(
                                        color: Color(0xff7e8299),
                                        fontSize: 14.95,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 25,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xfff5f8fa),
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
                                    SizedBox(width: 9.75),
                                    Text(
                                      "Continue with Facebook",
                                      style: GoogleFonts.redHatDisplay(
                                        color: Color(0xff7e8299),
                                        fontSize: 14.95,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Text(
                                "OR",
                                style: GoogleFonts.redHatDisplay(
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            //put the email address
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: GoogleFonts.redHatDisplay(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            inputField(
                                label: "",
                                validator: (value) =>
                                    usernameValidator(value.toString()),
                                controller: userNameController,
                                keyboardType: TextInputType.name),
                            SizedBox(
                              height: 16,
                            ),
                            //put the email address
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Mobile",
                                  style: GoogleFonts.redHatDisplay(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            inputField(
                                label: "",
                                validator: (value) =>
                                    phoneValidator(value.toString()),
                                controller: phoneController,
                                keyboardType: TextInputType.number),
                            SizedBox(
                              height: 16,
                            ),
                            //put the email address
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
                            SizedBox(
                              height: 12,
                            ),
                            inputField(
                                label: "",
                                validator: (value) =>
                                    emailValidator(value.toString()),
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress),
                            SizedBox(
                              height: 16,
                            ),
                            //put the password address
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  style: GoogleFonts.redHatDisplay(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            inputField(
                                label: "",
                                validator: (value) =>
                                    passwordValidator(value.toString()),
                                controller: passwordController,
                                obscureText: isPasswordVisable,
                                suffixIcon: myIconWidget()),
                            SizedBox(
                              height: 26,
                            ),
                            myButtonWidget(
                              texts: "REGISTER",
                              onPressed: () => register(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //used widget icon for visibility of password
  Widget myIconWidget() {
    return InkWell(
        onTap: () {
          isPasswordVisable = !isPasswordVisable;
          setState(() {});
        },
        child: isPasswordVisable
            ? Icon(
                Icons.visibility_off,
                size: 22,
                color: Colors.amber,
              )
            : Icon(
                Icons.visibility,
                size: 22,
                color: Colors.amber,
              ));
  }

  void register() {
    if (formKey.currentState!.validate()) {
      signupCubit.register(
        email: emailController.text,
        password: passwordController.text,
        username: userNameController.text,
        phone: phoneController.text,
      );
    }
  }

  void onRegisterSuccess() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        ));
  }

  void onRegisterFailure(String errorMessage) {
    SnackBar snackBar = SnackBar(
      content: Text(errorMessage),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
