import 'package:chatter/helpers.dart';
import 'package:chatter/models/models.dart';
import 'package:chatter/screens/screens.dart';
import 'package:chatter/theme.dart';
import 'package:chatter/widgets/widgets.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: _Stories(),
        ),
        const SliverPadding(padding: EdgeInsets.all(8)),
        SliverList(delegate: SliverChildBuilderDelegate(_delegate))
      ],
    );
  }

  Widget _delegate(BuildContext context, int index) {
    final faker = Faker();
    final date = Helpers.randomDate();
    final messageData = MessageData(
        senderName: faker.person.firstName(),
        message: faker.lorem.sentence(),
        messageDate: date,
        dateMessage: Jiffy(date).fromNow(),
        profilePicture: Helpers.randomPictureUrl());
    return index.isEven
        ? _MessageTile(
            messageData: messageData,
          )
        : const Divider(
            color: Colors.grey,
            height: 0,
          );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({Key? key, required this.messageData}) : super(key: key);

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(ChatScreen.route(messageData)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Avatar.medium(url: Helpers.randomPictureUrl()),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  messageData.senderName,
                  style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.8),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  messageData.message,
                  style: const TextStyle(overflow: TextOverflow.ellipsis, fontSize: 12),
                )
              ],
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    messageData.dateMessage.toUpperCase(),
                    style: const TextStyle(fontSize: 12, color: AppColors.textFaded),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          "${faker.randomGenerator.integer(10)}",
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textLight),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Stories extends StatelessWidget {
  const _Stories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 144,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text(
              "Stories",
              style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.6, color: AppColors.textFaded),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final faker = Faker();
                return SizedBox(
                  width: 90,
                  child:
                      _StoryCard(storyData: StoryData(name: faker.person.firstName(), url: Helpers.randomPictureUrl())),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({Key? key, required this.storyData}) : super(key: key);

  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            storyData.name,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.3),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
