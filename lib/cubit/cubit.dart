// ignore_for_file: unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/Profile_model.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/cateogries.dart';
import 'package:shop_app/modules/favourites.dart';
import 'package:shop_app/modules/products.dart';
import 'package:shop_app/modules/settings.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/endpoint.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class logincubit extends Cubit<loginstates> {
  logincubit() : super(logininitialstate());
  static logincubit get(context) => BlocProvider.of(context);
  late LoginModel loginModel;
  void userlogin({
    required String email,
    required String password,
  }) {
    emit(loginloadingstate());
    DioHelper.PostData(
            url: LOGIN,
            data: {
              'email': email,
              'password': password,
            },
            token: Cashe_Helper.getdata(key: 'token'))
        .then((value) {
      print(value.data);
      loginModel = LoginModel.fromjson(value.data);
      emit(loginsuccessstate(loginModel));
    }).catchError((Error) {
      print(Error.toString());
      emit(loginerrorstate(Error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool ispassword = true;
  void changepasswordvisibility() {
    ispassword = !ispassword;
    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(loginpasswordvisiblestate());
  }
}

class Shopcubit extends Cubit<ShopStates> {
  Shopcubit() : super(Shopinitialstate());
  static Shopcubit get(context) => BlocProvider.of(context);
  String? token = Cashe_Helper.getdata(key: 'token');
  int currentindex = 0;
  List<Widget> bottomscreens = [
    ProductsScreen(),
    CateogriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];
  void changebottom(int index) {
    currentindex = index;
    emit(Shopchangebottomnavstate());
  }

  Map<int, bool> favourites = {};
  HomeModel? homemodel;
  void gethomedata() {
    emit(Shoploadinghomedatastate());
    DioHelper.GetData(url: HOME, token: token).then((value) {
      homemodel = HomeModel.fromjson(value.data);
      homemodel!.data.products.forEach(
        (element) {
          favourites.addAll({
            element.id: element.favorites,
          });
        },
      );
      print(favourites.toString());
      emit(Shopsuccesshomedatastate());
    }).catchError((Error) {
      print(Error.toString());
      emit(Shoperrorhomedatastate(Error));
    });
  }

  CateogriesModel? cateogriesmodel;
  void getcategories() {
    DioHelper.GetData(url: GET_CATEGORIES, token: token).then((value) {
      cateogriesmodel = CateogriesModel.fromjson(value.data);
      emit(Shopsuccesscategoriesdatastate());
    }).catchError((Error) {
      print(Error.toString());
      emit(Shoperrorcategoriesdatastate(Error));
    });
  }

  FavouriteModel? favouriteModel;
  void changefavourites(int productid) {
    favourites[productid] = !favourites[productid]!;
    emit(Shopfavouritesdatastate());
    DioHelper.PostData(
            url: FAVOUTITE, data: {'product_id': productid}, token: token)
        .then((value) {
      favouriteModel = FavouriteModel.fromjson(value.data);
      print(value.data);
      if (!favouriteModel!.status) {
        favourites[productid] = !favourites[productid]!;
      } else {
        getfavourites();
      }
      emit(Shopsuccessfavouritesdatastate(favouriteModel!));
    }).catchError((error) {
      favourites[productid] = !favourites[productid]!;
      emit(Shoperrorfavouritesdatastate(error));
    });
  }

  GetFavouritesModel? getfavouritesModel;
  void getfavourites() {
    emit(Shopeloadinggetfavouritesdatastate());
    DioHelper.GetData(url: FAVOUTITE, token: token).then((value) {
      getfavouritesModel = GetFavouritesModel.fromJson(value.data);
      emit(Shopsuccessgetfavouritesdatastate());
    }).catchError((Error) {
      print(Error.toString());
      emit(Shoperrorgetfavouritesdatastate());
    });
  }

  ProfileModel? usermodel;
  void getUserData() {
    emit(Shopeloadinguserdatastate());
    DioHelper.GetData(url: PROFILE, token: token).then((value) {
      usermodel = ProfileModel.fromjson(value.data);
      emit(Shopsuccessuserdatastate(usermodel!));
    }).catchError((Error) {
      print(Error.toString());
      emit(Shoperroruserdatastate());
    });
  }

  void UpdateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(Shopeloadingupdateuserdatastate());
    DioHelper.PutData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      usermodel = ProfileModel.fromjson(value.data);
      emit(Shopsuccessupdateuserdatastate(usermodel));
    }).catchError((Error) {
      print(Error.toString());
      emit(Shoperrorupdateuserdatastate());
    });
  }
}

class registercubit extends Cubit<registerstates> {
  registercubit() : super(registerinitialstate());
  static registercubit get(context) => BlocProvider.of(context);
  late RegisterModel registerModel;
  void userregister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(registerloadingstate());
    DioHelper.PostData(
            url: REGISTER,
            data: {
              'name': name,
              'phone': phone,
              'email': email,
              'password': password,
            },
            token: Cashe_Helper.getdata(key: 'token'))
        .then((value) {
      print(value.data);
      registerModel = RegisterModel.fromjson(value.data);
      emit(registersuccessstate(registerModel));
    }).catchError((Error) {
      print(Error.toString());
      emit(registererrorstate());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool ispassword = true;
  void changepasswordvisibility() {
    ispassword = !ispassword;
    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(registerpasswordvisiblestate());
  }
}

class searchcubit extends Cubit<Searchstates> {
  searchcubit() : super(Searchinitialstate());
  static searchcubit get(context) => BlocProvider.of(context);
  late SearchModel model;
  void search(String text) {
    emit(Searchloadingstate());
    DioHelper.PostData(url: SEARCH,data: {
      'text': text,
    },token: Cashe_Helper.getdata(key: 'token')).then((value) {
      model=SearchModel.fromJson(value.data);
      emit(Searchsuccessstate());
    }).catchError((error) {
      print(error.toString());
      emit(Searcherrorstate());
    });
  }
}
