import 'package:fd/models/model.dart';

void main() async {
  print("coba");

  final List<UserList> dataUser = await UserList.fetchData();

  for (int i = 0; i < dataUser.length; i++) {
    print('${dataUser[i].firstName} ${dataUser[i].lastName}');
    print(dataUser[i].email);
    print("--------------------");
  }
}
