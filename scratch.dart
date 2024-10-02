import 'dart:io';

void main() {
  performTasks();
}
void performTasks() async {
  task1();
  task3(await task2());
}

void task1() {
  String result = 'task 1 data result';
  print('Task 1 complete');
}

Future task2() async {
  Duration threeSecond = Duration(seconds: 3);
  String result='null';
  //异步
  await Future.delayed(threeSecond,(){
    result = 'task 2 data result';
    print('Task 2 complete');
  });
  return result;
}

void task3(String task2Data) {
  String result = 'task 3 data result';
  print('Task 3 complete $task2Data');
}
