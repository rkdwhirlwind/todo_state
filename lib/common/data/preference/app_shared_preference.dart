import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  // Singleton
  AppSharedPreference._();
  static AppSharedPreference instance = AppSharedPreference._();

  late SharedPreferences _preferences;

  /// 생성자에 만들어서도 await을 사용할 수 없음
  /// 이유 : 생성자 호출시 _preferences가 비동기이기 때문에 아직 데이터를 받아오지 못 함
  /// 해결 방법 : main.dart에서 runApp을 하기 전에 미리 Singleton 기반으로 _preference를 미리 선언
  /*AppSharedPreference(){
    SharedPreferences.getInstance().then((value) => _preferences = value);

    /// 생성자에서는 async함수를 쓸 수 없으니 직접 then을 사용하여 호출 필요
    //_preferences = await SharedPreferences.getInstance();
  }*/

  static init() async {
    instance._preferences = await SharedPreferences.getInstance();
  }

  static void setCount(int count){
    instance._preferences.setInt('count', count);
  }

  static int getCount(){
    return instance._preferences.getInt('count') ?? 0;
  }


}