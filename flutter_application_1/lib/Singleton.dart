/*
Singleton._privateConstructor(); 类似这种就是把构造函数私有化了，
外部无法直接调用构造函数来创建实例了，只能通过类内部提供的静态方法或者属性来获取实例，
这样就保证了全局只有一个实例存在。
*/
class Singleton {
  Singleton._privateConstructor();
  static final Singleton _instance = Singleton._privateConstructor();
  factory Singleton() => _instance;
}

class Singleton1 {
  Singleton1._privateConstructor();
  static final Singleton1 _instance = Singleton1._privateConstructor();
  static Singleton1 get instance => _instance;
}

class Singleton2 {
  Singleton2._privateConstructor();
  static final Singleton2 _instance = Singleton2._privateConstructor();
  static Singleton2 getInstance() => _instance;
}

class Singleton3 {
  Singleton3._privateConstructor();
  static Singleton3? _instance;
  static Singleton3 getInstance() {
    _instance ??= Singleton3._privateConstructor();
    return _instance!;
  }
}
