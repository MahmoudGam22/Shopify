import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';

class CateogriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(itemBuilder: (context, index) => buildcatitem(Shopcubit.get(context).cateogriesmodel!.data.data[index]),
       separatorBuilder: (context, index) => mydivider(),
        itemCount: Shopcubit.get(context).cateogriesmodel!.data.data.length,
        );
      },
      
    );
  }
  Widget buildcatitem(Datamodel model)=>Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(image: NetworkImage(model.image),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            model.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_sharp,
          ),
        ],
      ),
    );
}
