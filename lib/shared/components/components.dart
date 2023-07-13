// ignore_for_file: unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/login.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

Widget buildarticleitem(article, context) => InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
Widget articlebuilder(list, context, {isserach = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildarticleitem(list[index], context),
        separatorBuilder: (context, index) => mydivider(),
        itemCount: 10,
        shrinkWrap: true,
      ),
      fallback: (context) =>
          isserach ? Container() : Center(child: CircularProgressIndicator()),
    );

void navigateto(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );
void navigateandfinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

Widget defaultff({
  required TextEditingController controller,
  required TextInputType kType,
  void Function(String)? onsubmit,
  void Function(String)? onChanged,
  required String? Function(String?)? validate,
  required String label,
  required Icon prefix,
  IconData? suffix,
  bool ispassword = false,
  void Function()? suffixpressed,
  void Function()? tap,
  bool isclickable = true,
}) =>
    TextFormField(
      obscureText: ispassword,
      validator: validate,
      controller: controller,
      keyboardType: kType,
      onChanged: onChanged,
      onFieldSubmitted: onsubmit,
      onTap: tap,
      enabled: isclickable,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: prefix,
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixpressed, icon: Icon(suffix))
            : null,
      ),
    );
Widget mydivider() => Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );
Widget defaultbutton({
  double width = double.infinity,
  Color background = Colors.blue,
  double borderradius = 3,
  required VoidCallback function,
  required String text,
  bool isuppercase = true,
}) =>
    Container(
      height: 55,
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isuppercase ? text.toUpperCase() : text,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderradius),
        color: background,
      ),
    );
Widget defaulttextbutton({
  required void Function()? fuction,
  required String text,
}) =>
    TextButton(
      onPressed: fuction,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
void showToast({
  required String text,
  required Toaststates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor:choosetoastcolor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum Toaststates { SUCCESS, ERROR, WARNING }

Color choosetoastcolor(Toaststates state) {
  Color color;
  switch (state) {
    case Toaststates.SUCCESS:
      color=Colors.green;
      break;
    case Toaststates.ERROR:
      color=Colors.red;
      break;
    case Toaststates.WARNING:
      color=Colors.amber;
      break;
  }
  return color;
}
void signout(context){
  Cashe_Helper.removedata(key: 'token').then((value){
              if(value)navigateandfinish(context, LoginScreen());
            });
}
  Widget buildlistproduct(model, context,{bool isoldprice=true}) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model!.image),
                    width: 120,
                    height: 120,
                  ),
                  if (model.discount != 0 && isoldprice)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          model.price.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (model.discount != 0 && isoldprice)
                          Text(
                            model.oldPrice.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Shopcubit.get(context)
                                .changefavourites(model.id);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor: Shopcubit.get(context)
                                        .favourites[model.id] ==
                                    true
                                ? Colors.blue
                                : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );