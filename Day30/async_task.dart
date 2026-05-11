import 'dart:async';

Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 3));

  // Simulated error
  throw Exception("Connection Timeout");

  // If you want success output instead, comment above line
  // and use:
  // return "Data fetched successfully";
}

void main() async {
  print("Fetching data...");

  try {
    String result = await fetchData();
    print(result);
  } catch (e) {
    print("Error: $e");
  }

  print("Program completed");
}