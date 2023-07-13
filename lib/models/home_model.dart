// ignore_for_file: unused_local_variable, empty_constructor_bodies, unused_import

import 'package:flutter/material.dart';

class HomeModel {
  late bool status;
  late HomeDataModel data;
  HomeModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromjson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductsModel> products = [];
  HomeDataModel.fromjson(Map<String,dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromjson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductsModel.fromjson(element));
    });
  }
}

class BannerModel {
  late int id;
  late String image;
  BannerModel.fromjson(Map<String,dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  late int id;
  late dynamic price;
  late dynamic oldprice;
  late dynamic discount;
  late String image;
  late String name;
  late bool favorites;
  late bool cart;

  ProductsModel.fromjson(Map<String, dynamic> json) {
    id=json['id'];
    price=json['price'];
    oldprice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    favorites=json['in_favorites'];
    cart=json['in_cart'];
  }
}
