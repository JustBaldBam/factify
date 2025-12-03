// lib/models/mock_data.dart
import 'package:flutter/material.dart';
import 'category.dart';

// THIS IS THE ONLY AppTab IN THE ENTIRE PROJECT
enum AppTab { home, search, saved, profile }

const List<String> dailyFacts = [
  "Honey never spoils. Pots found in ancient Egyptian tombs are still edible!",
  "A 'jiffy' is an actual unit of time: 1/100th of a second.",
  "Sharks existed before trees.",
];

final Map<String, List<FactItem>> factDataStore = {
  'science': [
    FactItem(fact: "Lightning can power a bulb for 3 months.", imageAlt: "Lightning"),
    FactItem(fact: "Ants outweigh humans globally.", imageAlt: "Ants"),
    FactItem(fact: "A day on Venus > a year on Venus.", imageAlt: "Venus"),
    FactItem(fact: "Sharks predate Saturn's rings.", imageAlt: "Shark"),
    FactItem(fact: "Jiffy = 1/100 second.", imageAlt: "Time"),
  ],
  'animals': [
    FactItem(fact: "Flamingos group = flamboyance", imageAlt: "Flamingos"),
    FactItem(fact: "Shrimp heart is in head", imageAlt: "Shrimp"),
    FactItem(fact: "Owls group = parliament", imageAlt: "Owls"),
    FactItem(fact: "Butterflies taste with feet", imageAlt: "Butterfly"),
    FactItem(fact: "Snail can sleep 3 years", imageAlt: "Snail"),
  ],
  'christmas': [
    FactItem(fact: "Jingle Bells was for Thanksgiving", imageAlt: "Sleigh"),
    FactItem(fact: "Santa's red suit = Coca-Cola ad", imageAlt: "Santa"),
  ],
  'history': [
    FactItem(fact: "Cleopatra lived closer to iPhone than Pyramids.", imageAlt: "Cleopatra Pyramids"),
    FactItem(fact: "The shortest war lasted 38 minutes.", imageAlt: "Shortest War"),
    FactItem(fact: "Eiffel Tower grows 15cm in summer.", imageAlt: "Eiffel Tower"),
  ],
  'space': [
    FactItem(fact: "More trees on Earth than stars in Milky Way.", imageAlt: "Tree Stars"),
    FactItem(fact: "Largest known volcano is on Mars.", imageAlt: "Olympus Mons"),
    FactItem(fact: "Moon footprints last 100 million years.", imageAlt: "Moon Footprint"),
  ],
  'technology': [
    FactItem(fact: "First computer mouse was made of wood.", imageAlt: "Wooden Mouse"),
    FactItem(fact: "First tweet was by Jack Dorsey.", imageAlt: "Twitter Tweet"),
    FactItem(fact: "Child's tablet has more power than Apollo 11.", imageAlt: "Apollo Tablet"),
  ],
  'random': [
    FactItem(fact: "Illegal to own one guinea pig in Switzerland.", imageAlt: "Guinea Pig Law"),
    FactItem(fact: "Longest word without a vowel is 'rhythms'.", imageAlt: "Rhythms Word"),
    FactItem(fact: "Person walks five times Earth's circumference.", imageAlt: "Walking Globe"),
  ],
};

final List<Category> categories = [
  Category(id: 'science', name: 'Science', icon: Icons.science, color: Colors.blue.shade600),
  Category(id: 'animals', name: 'Animals', icon: Icons.pets, color: Colors.green.shade600),
  Category(id: 'christmas', name: 'Christmas', icon: Icons.star, color: Colors.red.shade700),
  Category(id: 'history', name: 'History', icon: Icons.schedule, color: Colors.yellow.shade700),
  Category(id: 'space', name: 'Space', icon: Icons.rocket_launch, color: Colors.purple.shade700),
  Category(id: 'technology', name: 'Technology', icon: Icons.computer, color: Colors.cyan.shade600),
  Category(id: 'random', name: 'Random', icon: Icons.casino, color: Colors.orange.shade600),
];

Map<String, dynamic> getRandomFactFromStore() {
  final all = factDataStore.values.expand((list) => list).toList();
  if (all.isEmpty) return {'fact': 'No facts!', 'categoryId': 'none'};
  final fact = all[DateTime.now().millisecond % all.length];
  final catId = factDataStore.keys.firstWhere((k) => factDataStore[k]!.contains(fact), orElse: () => 'random');
  return {'fact': fact.fact, 'categoryId': catId};
}