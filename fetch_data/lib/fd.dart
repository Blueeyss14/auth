import 'package:fd/models/model.dart';

void main() async {
  final List<UserLst> user = await UserLst.fetchData();

  for (int i = 0; i < user.length; i++) {
    print(user[i].category);
  }
}
