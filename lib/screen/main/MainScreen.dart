import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/di/Di.dart';
import 'package:untitled/screen/main/MainScreenViewModel.dart';
import 'package:untitled/screen/main/TranslateListItemViewModel.dart';

class MainScreen extends StatefulWidget {

  final MainScreenViewModel viewModel = getIt<MainScreenViewModel>();

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('translate number: ${widget.viewModel.translateList.length}'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: TranslateList(widget.viewModel),
            ),
            Text('Tap a flag to start speaking'),
            MainBottomBar(widget.viewModel)
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    widget.viewModel.addListener(() {
      setState(() {});
    });
  }
}

class TranslateList extends StatefulWidget {
  TranslateList(this._viewModel);

  MainScreenViewModel _viewModel;

  @override
  State<StatefulWidget> createState() {
    return TranslateListState();
  }
}

class TranslateListState extends State<TranslateList> {
  @override
  Widget build(BuildContext context) {
    print('build state');
    return ListView.builder(
        itemCount: widget._viewModel.translateList.length,
        itemBuilder: (context, index) {
          final item = widget._viewModel.translateList[index];

          return TranslateListItem(item);
        });
  }

  @override
  void initState() {
    print('init state');
    super.initState();
    widget._viewModel.addListener(() {
      print('list changed');
      setState(() {});
      build(context); //todo
    });
  }
}

class TranslateListItem extends StatelessWidget {
  TranslateListItem(this._listItemViewModel);

  TranslateListItemViewModel _listItemViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _listItemViewModel.translate.inputLanguage,
                        style: const TextStyle(color: Colors.pink),
                      ),
                      Text(
                        _listItemViewModel.translate.inputText,
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: _listItemViewModel.vocalizeInput,
                  icon: const Icon(
                    Icons.volume_down,
                    color: Colors.blueGrey,
                    size: 24,
                  ))
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade100
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _listItemViewModel.translate.outputLanguage,
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                        Text(
                          _listItemViewModel.translate.outputText,
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: _listItemViewModel.vocalizeOutput,
                    icon: const Icon(
                      Icons.volume_down,
                      color: Colors.blueGrey,
                      size: 24,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MainBottomBar extends StatefulWidget {
  MainScreenViewModel viewModel;

  MainBottomBar(this.viewModel);

  @override
  State<MainBottomBar> createState() => _MainBottomBarState();


}

class _MainBottomBarState extends State<MainBottomBar> {
  Color backgorundColor = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgorundColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.elliptical(500, 50),
              topLeft: Radius.elliptical(500, 50))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            IconButton(
                onPressed: widget.viewModel.onInputVoiceToTextPressed,
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 32,
                  color: Colors.blue,
                )),
            const Spacer(),
            IconButton(
                onPressed: widget.viewModel.textToSpeechService.stopTextToSpeech,
                icon: SvgPicture.asset(
                  "icons/mic_ic.svg",
                  color: Colors.lightGreen,
                )
            ),
            const Spacer(),
            IconButton(
                onPressed: widget.viewModel.onOutputVoiceToTextPressed,
                icon: const Icon(
                  Icons.arrow_back,
                  size: 32,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    widget.viewModel.addListener(() {
      if (widget.viewModel.isLoading) {
        backgorundColor = Colors.red;
      } else {
        backgorundColor = Colors.blueGrey;
      }
      setState(() {});
    });
  }

}
