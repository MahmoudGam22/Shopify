// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var search_controller = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => searchcubit(),
      child: BlocConsumer<searchcubit, Searchstates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) => Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultff(
                      controller: search_controller,
                      kType: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'enter text to search';
                        }
                        return null;
                      },
                      onsubmit: (String text) {
                        searchcubit.get(context).search(text);
                      },
                      label: 'Search',
                      prefix: Icon(Icons.search)),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is Searchloadingstate)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  if(state is Searchsuccessstate)
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => buildlistproduct(searchcubit.get(context).model.data!.data![index],context,isoldprice: false),
                      separatorBuilder: (context, index) => mydivider(),
                      itemCount:
                          searchcubit.get(context).model.data!.data!.length,
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
}
