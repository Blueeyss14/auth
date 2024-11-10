import 'package:fd/models/model.dart';

void main() async {
  final List<UserListP> userData = await UserListP.fetchDataP();

  for (int i = 0; i < userData.length; ++i) {
    print("${userData[i].category} ${userData[i].price}");
  }
}
