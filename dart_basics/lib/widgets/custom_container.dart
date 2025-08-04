import 'package:flutter/material.dart';

const width = 150.0;
const height = 150.0;

class CustomContainerConfig {
  final List<Color> gradientColors;
  final String containerText;

  const CustomContainerConfig({
    this.gradientColors = defaultGradientColors,
    required this.containerText,
  });

  static const defaultGradientColors = [
    Color.fromARGB(255, 39, 44, 56),
    Color.fromARGB(255, 31, 35, 45),
  ];
}

class CustomContainer extends StatelessWidget {
  const CustomContainer(this.config, {super.key});
  final CustomContainerConfig config;

  @override
  Widget build(BuildContext context) => Container(
    color: const Color.fromARGB(255, 39, 44, 56),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://avatars.githubusercontent.com/u/50490077?v=4',
            width: width,
            height: height,
            fit: BoxFit.contain,
            loadingBuilder:
                (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent? loadingProgress,
                ) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                      backgroundColor: Colors.blueAccent,
                    ),
                  );
                },
            errorBuilder:
                (
                  BuildContext context,
                  Object exception,
                  StackTrace? stackTrace,
                ) {
                  return const Text('Could not load image');
                },
          ),
          const SizedBox(height: 20),
          Text(
            config.containerText,
            style: const TextStyle(color: Color.fromARGB(255, 233, 234, 236)),
          ),
        ],
      ),
    ),
  );
}
