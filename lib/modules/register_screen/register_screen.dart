import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mowitter/layout/mowitter_layout/mowitter_layout.dart';
import 'package:mowitter/modules/login_screen/login_screen.dart';
import 'package:mowitter/modules/register_screen/cubit/cubit.dart';
import 'package:mowitter/modules/register_screen/cubit/states.dart';
import 'package:mowitter/shared/componants/componants.dart';

class RegisterScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var repeatPasswordController = TextEditingController();
  var phoneController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
         if(state is CreateUserSuccessStates) {
           navGoTo(context, SocialLayout());
         }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
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
                          'Register',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10,),
                        const Text(
                          'register to communicate with friends. ',
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
                            controller: nameController,
                            keyboardtype: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your Name';
                              }else {
                                return null;
                              }
                            },
                            prefix: Icons.person,
                            labelText: 'your name ...'),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(context,
                            controller: emailController,
                            keyboardtype: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(r'^[\w-]+@([\w-]+\.)+[\w]{2,10}')
                                  .hasMatch(value!)) {
                                return 'Email Should be like salla@example.com \n Email can\'t contain * / - + % # \$ !';
                              }
                              return null;
                            },
                            prefix: Icons.email_outlined,
                            labelText: 'email address ...'),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                          context,
                          controller: phoneController,
                          keyboardtype: TextInputType.phone,
                          validator: (value) {
                            if(value.isEmpty) {
                              return 'phone can\'t be empty';
                            }else if (value.toString().length < 4 || value.toString().length > 20) {
                              return 'phone should be between 4 to 20 number';
                            }else {
                              return null;
                            }
                          },
                          prefix: Icons.phone,
                          labelText: 'phone ...',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(context,
                            controller: passwordController,
                            keyboardtype: TextInputType.visiblePassword,
                            labelText: 'password...',
                            onchange: (String value) {},
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'password Can\'t be empty';
                              } else if (value.toString().length < 6) {
                                return 'Password can\'t be less than 6';
                              }else {
                                return null;
                              }
                            },
                            prefix: Icons.lock_outline,
                            isPassword: cubit.isPassword,
                            suflix: cubit.suflixIcon,
                            suflixpressed: () {
                              cubit.changePasswordShow(1);
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(context,
                            controller: repeatPasswordController,
                            keyboardtype: TextInputType.visiblePassword,
                            labelText: 'repeat password...',
                            onchange: (String value) {},
                            validator: (value) {
                              if(value.isEmpty) {
                                return 'Please enter your new password';
                              } else if (value.toString().length < 6) {
                                return 'Password can\'t be less than 6';
                              }else if(value != passwordController.text){
                                return 'Password did\'t match';
                              }
                              return null;
                            },
                            prefix: Icons.lock_outline,
                            isPassword: cubit.repeatPasswordHide,
                            suflix: cubit.repeatSuflixIcon,
                            suflixpressed: () {
                              cubit.changePasswordShow(2);
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        BuildCondition(
                          condition: state is! RegisterLoadingStates,
                          builder: (context) => defultButton(
                              pressfunction: () {
                                if (formkey.currentState!.validate()) {
                                  cubit.userRegister(
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      name: nameController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                              text: 'Register'),
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
                            const Text('have an account'),
                            TextButton(
                                onPressed: () {
                                  navGoTo(context, LoginScreen());
                                },
                                child: const Text('login here.')),
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
