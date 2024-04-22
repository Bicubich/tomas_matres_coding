class CustomRoute {
  final String title;
  final String path;
  final bool shouldRewrite;

  const CustomRoute(
      {required this.title, required this.path, this.shouldRewrite = false});
}
