import 'package:shop_app/models/Profile_model.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/register_model.dart';

abstract class loginstates{}
class logininitialstate extends loginstates{}
class loginloadingstate extends loginstates{}
class loginsuccessstate extends loginstates{
  final LoginModel loginModel;

  loginsuccessstate(this.loginModel); 
}
class loginerrorstate extends loginstates{ 
  final String error;

  loginerrorstate(this.error);

}
class loginpasswordvisiblestate extends loginstates{}
abstract class ShopStates{}
class Shopinitialstate extends ShopStates{}
class Shopchangebottomnavstate extends ShopStates{}
class Shoploadinghomedatastate extends ShopStates{}
class Shopsuccesshomedatastate extends ShopStates{}
class Shoperrorhomedatastate extends ShopStates{
  final String error;

  Shoperrorhomedatastate(this.error);
}
class Shopsuccesscategoriesdatastate extends ShopStates{}
class Shoperrorcategoriesdatastate extends ShopStates{
  final String error;

  Shoperrorcategoriesdatastate(this.error);
}

class Shopfavouritesdatastate extends ShopStates{}
class Shopsuccessfavouritesdatastate extends ShopStates{
  final FavouriteModel model;

  Shopsuccessfavouritesdatastate(this.model);
}
class Shoperrorfavouritesdatastate extends ShopStates{
  final String error;

  Shoperrorfavouritesdatastate(this.error);
}
class Shopsuccessgetfavouritesdatastate extends ShopStates{}
class Shoperrorgetfavouritesdatastate extends ShopStates{}
class Shopeloadinggetfavouritesdatastate extends ShopStates{}

class Shopsuccessuserdatastate extends ShopStates{
 final ProfileModel usermodel;

  Shopsuccessuserdatastate(this.usermodel);
}
class Shoperroruserdatastate extends ShopStates{}
class Shopeloadinguserdatastate extends ShopStates{}
class Shopsuccessupdateuserdatastate extends ShopStates{
 final ProfileModel? usermodel;

  Shopsuccessupdateuserdatastate(this.usermodel);
}
class Shoperrorupdateuserdatastate extends ShopStates{}
class Shopeloadingupdateuserdatastate extends ShopStates{}

abstract class Searchstates{}
class Searchinitialstate extends Searchstates{}
class Searchloadingstate extends Searchstates{}
class Searchsuccessstate extends Searchstates{}
class Searcherrorstate extends Searchstates{}



abstract class registerstates{}
class registerinitialstate extends registerstates{}
class registerloadingstate extends registerstates{}
class registersuccessstate extends registerstates{
  final RegisterModel registerModel;

  registersuccessstate(this.registerModel);
}
class registererrorstate extends registerstates{ 
}
class registerpasswordvisiblestate extends registerstates{}