class OnBoard {
  final String image, title, description;

  OnBoard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<OnBoard> demo_data = [
  OnBoard(
    image: "lib/images/onboard3.png",
    title: "Note Down Expenses",
    description: "Daily note your expenses to help manage money",
  ),
  OnBoard(
    image: "lib/images/onboard2.png",
    title: "Simple Money Management",
    description:
        "Get your notifications or alert when you do the over expenses",
  ),
  OnBoard(
    image: "lib/images/onboard3.png",
    title: "Easy to Track and Analyze",
    description:
        "Tracking your expense and helping to make sure you don't overspend",
  ),
];
