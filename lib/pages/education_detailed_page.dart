import 'package:flutter/material.dart';
import 'package:mi_promotora/models/education_model.dart';
import 'package:mi_promotora/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:global_configuration/global_configuration.dart';

class EducationDetailedPage extends StatefulWidget {
  final EducationModel complement;
  EducationDetailedPage({Key key, this.complement}) : super(key: key);

  @override
  _EducationDetailedPageState createState() => _EducationDetailedPageState();
}

final String _url = GlobalConfiguration().getValue("api_url");

class _EducationDetailedPageState extends State<EducationDetailedPage> {
  var playerState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
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
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(4),
              child: Text(
                'Te brindamos material de apoyo que te ayudara con tu proceso.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black, fontSize: 17),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
              ),
              child: widget.complement.videoUrl == null ||
                      widget.complement.videoUrl == ''
                  ? SizedBox()
                  : _videoPlayer(),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(2),
              child: widget.complement.podcastFile == null
                  ? SizedBox()
                  : _audioPlayer(context),
            ),
            widget.complement.documentFiles == null
                ? SizedBox()
                : _document(context, widget.complement.documentFiles),
          ],
        ),
      ),
    );
  }

  Widget _videoPlayer() {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.complement.videoUrl),
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
        return Container(
          child: player,
        );
      },
    );
  }

  Widget _audioPlayer(context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    AudioPlayer audioPlayer = AudioPlayer();

    audioPlayer.onPlayerStateChanged.listen((s) {
      setState(() => playerState = s);
    }, onError: (msg) {
      setState(() {
        playerState = AudioPlayerState.STOPPED;
      });
    });

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 13, 20, 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: width * 0.7,
                  child: Text(
                    widget.complement.podcastFile.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(color: Colors.black, fontSize: 17),
                  ),
                ),
                Text(widget.complement.podcastFile.caption,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black45, fontSize: 14))
              ],
            ),
          ),
          playerState == AudioPlayerState.PLAYING
              ? IconButton(
                  color: MiPromotora().primaryDark,
                  icon: Icon(Icons.pause_circle_outline),
                  iconSize: 40,
                  onPressed: () => _stop(audioPlayer))
              : IconButton(
                  color: MiPromotora().primaryDark,
                  icon: Icon(Icons.play_circle_outline_outlined),
                  iconSize: 40,
                  onPressed: () => _play(audioPlayer),
                )
        ],
      ),
    );
  }

  _play(AudioPlayer audioPlayer) {
    audioPlayer.play(_url + widget.complement.podcastFile.url);
  }

  _stop(AudioPlayer audioPlayer) {
    audioPlayer.pause();
    setState(() {});
  }

  Widget _document(context, final List<DocumentFile> documentFiles) {
    return GridView.builder(
      itemCount: documentFiles.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        DocumentFile document = documentFiles[index];
        return ClipRect(
          child: Container(
            height: 150.0,
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.symmetric(horizontal: 10),
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
                    color: MiPromotora().primaryDark,
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
  if (await canLaunch(_url + url)) {
    await launch(_url + url);
  } else {
    throw 'Could not launch $url';
  }
}
