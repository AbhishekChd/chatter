import 'package:chatter/app.dart';
import 'package:chatter/helpers.dart';
import 'package:chatter/models/models.dart';
import 'package:chatter/screens/screens.dart';
import 'package:chatter/theme.dart';
import 'package:chatter/widgets/widgets.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  late final channelListController = StreamChannelListController(
      client: StreamChatCore.of(context).client,
      filter: Filter.and([
        Filter.equal('type', 'messaging'),
        Filter.in_('members', [StreamChatCore.of(context).currentUser!.id])
      ]));

  @override
  Widget build(BuildContext context) => Scaffold(
        body: PagedValueListenableBuilder<int, Channel>(
          valueListenable: channelListController,
          builder: (context, value, child) {
            return value.when(
              (channels, nextPageKey, error) {
                if (channels.isEmpty) {
                  return const Center(
                    child: Text(
                      'So empty.\nGo and message someone.',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return LazyLoadScrollView(
                  onEndOfPage: () async {
                    if (nextPageKey != null) {
                      channelListController.loadMore(nextPageKey);
                    }
                  },
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: _Stories(),
                      ),
                      const SliverPadding(padding: EdgeInsets.all(8)),
                      SliverList(
                          delegate: SliverChildBuilderDelegate((context, index) {
                        return _MessageTile(
                          channel: channels[index],
                        );
                      }, childCount: channels.length))
                    ],
                  ),
                );
              },
              loading: () => const Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (e) => Center(
                child: Text(
                  'Oh no, something went wrong. '
                  'Please check your config. $e',
                ),
              ),
            );
          },
        ),
      );

  @override
  void initState() {
    channelListController.doInitialLoad();
    super.initState();
  }

  @override
  void dispose() {
    channelListController.dispose();
    super.dispose();
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({Key? key, required this.channel}) : super(key: key);

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(ChatScreen.routeWithChannel(channel));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Avatar.medium(url: Helpers.getChannelImage(channel, context.currentUser!)),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Helpers.getChannelName(channel, context.currentUser!),
                  style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.8),
                ),
                const SizedBox(
                  height: 8,
                ),
                _buildLastMessage(),
              ],
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildLastMessageAt(),
                  const SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: UnreadMessagesIndicator(channel: channel),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLastMessage() {
    return BetterStreamBuilder<int>(
      stream: channel.state!.unreadCountStream,
      initialData: channel.state?.unreadCount ?? 0,
      builder: (context, count) {
        return BetterStreamBuilder<Message>(
          stream: channel.state!.lastMessageStream,
          initialData: channel.state!.lastMessage,
          builder: (context, lastMessage) {
            return Text(
              lastMessage.text ?? '',
              overflow: TextOverflow.ellipsis,
              style: (count > 0)
                  ? const TextStyle(
                      fontSize: 12,
                      color: AppColors.secondary,
                    )
                  : const TextStyle(
                      fontSize: 12,
                      color: AppColors.textFaded,
                    ),
            );
          },
        );
      },
    );
  }

  Widget _buildLastMessageAt() {
    return BetterStreamBuilder<DateTime>(
      stream: channel.lastMessageAtStream,
      initialData: channel.lastMessageAt,
      builder: (context, data) {
        final lastMessageAt = data.toLocal();
        String stringDate;
        final now = DateTime.now();

        final startOfDay = DateTime(now.year, now.month, now.day);

        if (lastMessageAt.millisecondsSinceEpoch >= startOfDay.millisecondsSinceEpoch) {
          stringDate = Jiffy(lastMessageAt.toLocal()).jm;
        } else if (lastMessageAt.millisecondsSinceEpoch >=
            startOfDay.subtract(const Duration(days: 1)).millisecondsSinceEpoch) {
          stringDate = 'YESTERDAY';
        } else if (startOfDay.difference(lastMessageAt).inDays < 7) {
          stringDate = Jiffy(lastMessageAt.toLocal()).EEEE;
        } else {
          stringDate = Jiffy(lastMessageAt.toLocal()).yMd;
        }
        return Text(
          stringDate,
          style: const TextStyle(
            fontSize: 11,
            letterSpacing: -0.2,
            fontWeight: FontWeight.w600,
            color: AppColors.textFaded,
          ),
        );
      },
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
