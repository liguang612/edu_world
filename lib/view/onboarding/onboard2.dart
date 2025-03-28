import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CardSlider(),
    );
  }
}

class CardSlider extends StatelessWidget {
  final List<Map<String, String>> cards = [
    {
      'image': 'assets/learning.png', // Đường dẫn hình ảnh đầu tiên
      'title': 'Học mọi lúc & mọi nơi',
      'description': 'Khám phá kiến thức bất cứ khi nào bạn muốn.',
    },
    {
      'image': 'assets/visual.png', // Đường dẫn hình ảnh thứ hai
      'title': 'Bài giảng sinh động',
      'description': 'Học dễ dàng thông qua các bài giảng trực quan.',
    },
    {
      'image': 'assets/quiz.png', // Đường dẫn hình ảnh thứ ba
      'title': 'Ôn & luyện thi',
      'description': 'Kiểm tra kiến thức với các bài trắc nghiệm.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    cards[index]['image']!,
                    height: 200,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    cards[index]['title']!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cards[index]['description']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (index == cards.length - 1) {
                        // Logic cho nút cuối cùng
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Hành trình bắt đầu!')),
                        );
                      }
                    },
                    child: Text(index == cards.length - 1 ? "Bắt đầu" : "Tiếp theo"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
