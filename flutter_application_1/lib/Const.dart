/*
class BusinessData {
  final Dio dio;
  const BusinessData({required this.dio});
} 

在 Dart 中，构造方法的 const 关键字主要有以下区别：
主要区别

1. 常量构造 vs 普通构造

dart
// 有 const
const BusinessData({required this.dio});  // 可以创建编译时常量

// 没有 const  
BusinessData({required this.dio});  // 只能创建运行时实例
2. 实例化方式的区别

dart
// 有 const 构造时：
final data1 = const BusinessData(dio: dioInstance);
final data2 = const BusinessData(dio: dioInstance);  // 相同参数的相同实例
print(identical(data1, data2));  // true - 同一个实例

// 没有 const 构造时：
final data1 = BusinessData(dio: dioInstance);
final data2 = BusinessData(dio: dioInstance);  // 新实例
print(identical(data1, data2));  // false - 不同实例
3. 性能影响

dart
// 有 const - 编译时确定，性能更好
const BusinessData(dio: dioInstance);

// 没有 const - 运行时创建，有轻微性能开销
BusinessData(dio: dioInstance);
4. 使用场景限制

dart
// 有 const - 要求所有字段都是 final 的 ✅
class BusinessData {
  final Dio dio;  // 必须是 final
  const BusinessData({required this.dio});
}

// 没有 const - 字段可以是非 final ✅
class BusinessData {
  Dio dio;  // 可以不是 final
  BusinessData({required this.dio});
}


什么才是真正的编译时常量？

dart
// ✅ 编译时常量：基本类型、字符串、数字等
const int number = 42;
const String name = "John";
const List<String> list = [];  // 空的或全常量的列表

// ❌ 不是编译时常量：大多数对象实例
const dio = Dio();  // 错误！Dio 的构造不是 const
const date = DateTime.now();  // 错误！运行时计算

// ✅ 只有本身是 const 构造的对象才能作为常量
class Person {
  final String name;
  const Person(this.name);  // const 构造
}
const person = Person("John");  // ✅ 正确
为什么 Dio 不能是编译时常量？

dart
// Dio 的源码大致是这样的
class Dio {
  BaseOptions options;
  
  Dio([BaseOptions? options])  // 没有 const 关键字
      : options = options ?? BaseOptions();  // 有初始化逻辑
}
 */