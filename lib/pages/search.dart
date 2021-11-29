import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:fuzzywuzzy/model/extracted_result.dart';
import 'package:potato_fries/backend/data.dart';
import 'package:potato_fries/backend/extensions.dart';
import 'package:potato_fries/backend/models/pages.dart';
import 'package:potato_fries/ui/components/separated_flex.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Card(
          margin: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16 + context.mediaQuery.padding.top,
            bottom: 16,
          ),
          shape: const StadiumBorder(),
          child: _SearchBar(controller: _controller),
          color: context.theme.colorScheme.secondaryContainer,
        ),
        preferredSize: Size.fromHeight(56 + context.mediaQuery.padding.top),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (_controller.text.trim().isEmpty) {
            return _buildIllustration("Start typing to search", Icons.keyboard);
          }

          final Set<Preference> queryPrefs = {};
          final List<Preference> preferences =
              Pages.list.expand((p) => p.preferences).toList();

          final List<ExtractedResult<Preference>> titleResults =
              extractAll<Preference>(
            query: _controller.text.trim().toLowerCase(),
            choices: preferences,
            getter: (e) => e.title,
          );
          final List<ExtractedResult<Preference>> descriptionResults =
              extractAll<Preference>(
            query: _controller.text.trim().toLowerCase(),
            choices: preferences.where((e) => e.description != null).toList(),
            getter: (e) => e.description!,
          );
          final Iterable<ExtractedResult<Preference>> totalResults = [
            ...titleResults,
            ...descriptionResults
          ].where((e) => e.score >= 50);
          queryPrefs.addAll(totalResults.map((e) => e.choice));

          if (queryPrefs.isEmpty) {
            return _buildIllustration("Nothing found", Icons.search_off);
          }

          return ListView.builder(
            itemBuilder: (context, index) =>
                queryPrefs.toList()[index].build(context),
            itemCount: queryPrefs.length,
          );
        },
      ),
    );
  }

  Widget _buildIllustration(String text, IconData icon) {
    return SizedBox.expand(
      child: SeparatedFlex(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        separator: const SizedBox(height: 16),
        children: [
          Icon(
            icon,
            color: context.theme.colorScheme.primary,
            size: 64,
          ),
          Text(
            text,
            style: context.friesTheme.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;

  const _SearchBar({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SeparatedFlex(
        separator: const SizedBox(width: 8),
        axis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: true,
              style: context.friesTheme.textTheme.titleMedium!,
              decoration: const InputDecoration(
                hintText: "Search preferences...",
                border: InputBorder.none,
                constraints: BoxConstraints.expand(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
