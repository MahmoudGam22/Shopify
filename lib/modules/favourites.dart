// ignore_for_file: unused_import

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/shared/components/components.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! Shopeloadinggetfavouritesdatastate,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildlistproduct(
                Shopcubit.get(context).getfavouritesModel!.data!.data![index].product,
                context),
            separatorBuilder: (context, index) => mydivider(),
            itemCount:
                Shopcubit.get(context).getfavouritesModel!.data!.data!.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}
