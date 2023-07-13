// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/shop_layout.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

class RegisterScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => registercubit(),
      child: BlocConsumer<registercubit,registerstates>(
        listener: (context, state) {
           if (state is registersuccessstate) {
            if (state.registerModel.status) {
              print(state.registerModel.message);
              Cashe_Helper.savedata(
                      key: 'token', value: state.registerModel.data!.token)
                  .then((value) {
                Shopcubit.get(context).token = state.registerModel.data!.token;
                navigateandfinish(context, ShopLayout());
              });
            } else {
              showToast(
                  text: state.registerModel.message, state: Toaststates.ERROR);
            }
          }
        },
        builder:(context, state)=> Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        'register now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultff(
                          controller: namecontroller,
                          kType: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          label: ' NAME',
                          prefix: Icon(Icons.person)),
                      SizedBox(
                        height: 15,
                      ),
                      defaultff(
                          controller: emailcontroller,
                          kType: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email';
                            }
                            return null;
                          },
                          label: 'Email Adrress',
                          prefix: Icon(Icons.email_outlined)),
                      SizedBox(
                        height: 15,
                      ),
                      defaultff(
                          controller: passwordcontroller,
                          kType: TextInputType.visiblePassword,
                          suffix: registercubit.get(context).suffix,
                          ispassword: registercubit.get(context).ispassword,
                          suffixpressed: () {
                            registercubit.get(context).changepasswordvisibility();
                          },
                          onsubmit: (value) {
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },
                          label: 'password',
                          prefix: Icon(Icons.lock_clock_outlined)),
                          SizedBox(
                        height: 15,
                      ),
                      defaultff(
                          controller: phonecontroller,
                          kType: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone';
                            }
                            return null;
                          },
                          label: 'Phone',
                          prefix: Icon(Icons.phone)),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! registerloadingstate ,
                        builder: (context) => defaultbutton(
                            function: () {
                              if (formkey.currentState!.validate()) {
                                registercubit.get(context).userregister(
                                  name: namecontroller.text,
                                  phone: phonecontroller.text,
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text);
                              }
                            },
                            text: 'register',
                            isuppercase: true),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
