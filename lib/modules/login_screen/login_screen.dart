import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mowitter/modules/login_screen/cubit/cubit.dart';
import 'package:mowitter/modules/login_screen/cubit/states.dart';
import 'package:mowitter/modules/register_screen/register_screen.dart';
import 'package:mowitter/shared/componants/componants.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state) {},
        builder:(context,state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10,),
                      const Text(
                        'login to communicate with friends. ',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(context,
                          controller: emailController,
                          keyboardtype: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,10}').hasMatch(value!)) {
                              return 'Email Should be like salla@example.com \n Email can\'t contain * / - + % # \$ !';
                            }
                            return null;
                          },
                          prefix: Icons.email_outlined,
                          labelText: 'Email Address ...'),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextFormField(context,
                          controller: passwordController,
                          keyboardtype: TextInputType.visiblePassword,
                          labelText: 'Password...',
                          onchange: (String value) {},
                          validator: (value) {
                            if (value == null || value!.isEmpty) {
                              return 'password can\'t be empty.';
                            }
                            return null;
                          },
                          prefix: Icons.lock_outline,
                          isPassword: cubit.isPassword,
                          suflix: cubit.suflixIcon,
                          suflixpressed: () {
                            cubit.changePasswordShow();
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      BuildCondition(
                        condition: state is! LoginLoadingStates,
                        builder: (context) => defultButton(
                            pressfunction: () {
                              if (formkey.currentState!.validate()) {
                                cubit.userLogin(context,
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: 'login'),
                        fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account'),
                          TextButton(
                              onPressed: () {
                                navGoTo(context, RegisterScreen());
                              },
                              child: const Text('Register Now !')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        },
      ),
    );
  }
}
