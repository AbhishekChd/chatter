import 'package:flutter/material.dart';

const users = [
  userAbhishek,
  userSalvatore,
  userSacha,
  userDeven,
  userSahil,
  userReuben,
  userNash,
];

const userAbhishek = DemoUser(
  id: 'abhishek',
  name: 'Abhishek Chaudhary',
  image: 'https://randomuser.me/api/portraits/men/58.jpg',
);

const userSalvatore = DemoUser(
  id: 'salvatore',
  name: 'Salvatore Giordano',
  image: 'https://randomuser.me/api/portraits/men/11.jpg',
);

const userSacha = DemoUser(
  id: 'sacha',
  name: 'Sacha Arbonel',
  image: 'https://randomuser.me/api/portraits/men/82.jpg',
);

const userDeven = DemoUser(
  id: 'deven',
  name: 'Deven Joshi',
  image: 'https://randomuser.me/api/portraits/men/89.jpg',
);

const userSahil = DemoUser(
  id: 'sahil',
  name: 'Sahil Kumar',
  image: 'https://randomuser.me/api/portraits/men/90.jpg',
);

const userReuben = DemoUser(
  id: 'reuben',
  name: 'Reuben Turner',
  image: 'https://randomuser.me/api/portraits/men/43.jpg',
);

const userNash = DemoUser(
  id: 'nash',
  name: 'Nash Ramdial',
  image: 'https://randomuser.me/api/portraits/men/56.jpg',
);

@immutable
class DemoUser {
  final String id;
  final String name;
  final String image;

  const DemoUser({
    required this.id,
    required this.name,
    required this.image,
  });
}
