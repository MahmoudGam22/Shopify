// ignore_for_file: unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/login.dart';
import 'package:shop_app/modules/serach.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=Shopcubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title: Text(
            'salla',
          ),
        actions: [
          IconButton(onPressed: (){
            navigateto(context, SearchScreen());
          }, icon: Icon(Icons.search),),
        ],
        ),
        body: cubit.bottomscreens[cubit.currentindex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentindex,
          onTap: (value) {
            cubit.changebottom(value);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              ),
              BottomNavigationBarItem(
              icon: Icon(Icons.apps),
              label: 'Cateogries',
              ),
              BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
              ),
              BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              ),
              
          ],
          ),
      );
      },
 
    );
  }
}
