import 'package:Weather/presentation/widgets/carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  testWidgets('Carousel widget should render correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Carousel(
            children: [
              Container(color: Colors.red),
              Container(color: Colors.blue),
              Container(color: Colors.green),
            ],
            height: 0.7,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ),
    );

    expect(find.byType(CarouselSlider), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);

    await tester.drag(find.byType(CarouselSlider), const Offset(-300.0, 0.0));
    await tester.pumpAndSettle();
  });
}
