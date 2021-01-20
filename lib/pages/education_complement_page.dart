import 'package:flutter/material.dart';
import 'package:promotoraapp/models/education_model.dart';
import 'package:promotoraapp/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:audioplayer/audioplayer.dart';

class EducationComplementPage extends StatefulWidget {
  final EducationModel complement;
  EducationComplementPage({Key key, this.complement}) : super(key: key);

  @override
  _EducationComplementPageState createState() =>
      _EducationComplementPageState();
}

class _EducationComplementPageState extends State<EducationComplementPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.grey[900],
          title: Text(
            "Educación",
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white, fontSize: 18),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 6,
              ),
              Container(padding: EdgeInsets.all(4), child: _titleEducation()),
              SizedBox(
                height: 8,
              ),
              Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: _videoPlayer()),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(2),
                child: _audioPlayer(),
              ),
              Expanded(
                child: _document(context, widget.complement.documentFiles),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleEducation() {
    return Text(
      'Te brindamos material de apoyo que te ayudara con tu proceso.',
      style: Theme.of(context)
          .textTheme
          .bodyText1
          .copyWith(color: Colors.black, fontSize: 17),
    );
  }

  Widget _videoPlayer() {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId("https://" + widget.complement.videoUrl),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) {
        return Column(
          children: [
            player,
          ],
        );
      },
    );
  }

  Widget _audioPlayer() {
    bool _expanded = _player() == true;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 13, 20, 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.complement.podcastFile.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.black, fontSize: 17),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(widget.complement.podcastFile.caption,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black45, fontSize: 14))
              ],
            ),
          ),
          SizedBox(
            width: 70,
          ),
          _expanded == true
              ? IconButton(
                  color: PromotoraApp().primaryDark,
                  icon: Icon(Icons.play_circle_outline_outlined),
                  iconSize: 40,
                  onPressed: () => _player(),
                )
              : IconButton(
                  color: PromotoraApp().primaryDark,
                  icon: Icon(Icons.pause_circle_outline),
                  iconSize: 40,
                  onPressed: () => _stop())
        ],
      ),
    );
  }

  _player() {
    AudioPlayer audioPlayer = AudioPlayer();

    audioPlayer
        .play("http://66.228.51.95:1337" + widget.complement.podcastFile.url);
  }

  _stop() {
    AudioPlayer audioPlayer = AudioPlayer();
    audioPlayer.pause();
  }

  Widget _document(context, final List<DocumentFile> documentFiles) {
    return GridView.builder(
      itemCount: documentFiles.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        DocumentFile document = documentFiles[index];
        return ClipRect(
          child: Container(
            height: 150.0,
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 5.0),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(243, 243, 243, 1),
                  radius: 30.0,
                  child: IconButton(
                    color: PromotoraApp().primaryDark,
                    icon: Icon(Icons.file_download),
                    iconSize: 30,
                    onPressed: () => _launchURL(document.file.url),
                  ),
                ),
                Text(
                  document.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.black, fontSize: 17),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5.0)
              ],
            ),
          ),
        );
      },
    );
  }
}

_launchURL(url) async {
  if (await canLaunch('http://66.228.51.95:1337' + url)) {
    await launch('http://66.228.51.95:1337' + url);
  } else {
    throw 'Could not launch $url';
  }
}
