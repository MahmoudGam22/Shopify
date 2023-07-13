// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var namecontroller = TextEditingController();
    var emailcontroller = TextEditingController();
    var phonecontroller = TextEditingController();

    return BlocConsumer<Shopcubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = Shopcubit.get(context).usermodel;
        namecontroller.text = model!.data!.name;
        emailcontroller.text = model.data!.email;
        phonecontroller.text = model.data!.phone;
        return ConditionalBuilder(
          condition: Shopcubit.get(context).usermodel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  if(state is Shopeloadingupdateuserdatastate)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  defaultff(
                      controller: namecontroller,
                      kType: TextInputType.name,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      label: 'name',
                      prefix: Icon(Icons.person)),
                  SizedBox(
                    height: 20,
                  ),
                  defaultff(
                      controller: emailcontroller,
                      kType: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        }
                        return null;
                      },
                      label: 'Email Address',
                      prefix: Icon(Icons.email_outlined)),
                  SizedBox(
                    height: 20,
                  ),
                  defaultff(
                      controller: phonecontroller,
                      kType: TextInputType.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'phone number must not be empty';
                        }
                        return null;
                      },
                      label: 'phone',
                      prefix: Icon(Icons.phone)),
                  SizedBox(
                    height: 20,
                  ),
                  defaultbutton(
                      function: () {
                        if (formkey.currentState!.validate()) {
                          Shopcubit.get(context).UpdateUserData(
                              name: namecontroller.text,
                              email: emailcontroller.text,
                              phone: phonecontroller.text);
                        }
                      },
                      text: 'update'),
                  SizedBox(
                    height: 20,
                  ),
                  defaultbutton(
                      function: () {
                        signout(context);
                        Shopcubit.get(context).currentindex = 0;
                      },
                      text: 'Logout'),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
