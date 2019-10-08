
import 'package:flutter/material.dart';
import 'package:gym_go/model/gym.dart';
import 'package:gym_go/service/firebase_storage.dart';
import 'package:gym_go/widget/button/button_add_gym.dart';
import 'package:gym_go/widget/picture_delete.dart';

class ListPictureField extends FormField<List> {
  ListPictureField({
    Key key,
    FormFieldSetter<List> onSaved,
    FormFieldValidator<List> validator,
    bool autovalidate = false,
    bool enabled = true,
    String userId,
    BuildContext context,
  }) : super(
            key: key,
            initialValue: [],
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            enabled: enabled,
            builder: (FormFieldState<List> field) {
              final _ListPictureFieldState state = field;
              return Container(
                height: 100,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        for (Picture picture in state._effectiveListPictures)
                          PictureDelete(
                            url: picture.url,
                            onTap: () {
                              final index =
                                  state._effectiveListPictures.indexOf(picture);
                              state.deleteImage(index, userId);
                            },
                          ),
                        ButtonAddGym(
                          size: 100,
                          color: Colors.blue,
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                builder: (BuildContext context) {
                                  return Container(
                                    child: Wrap(
                                      children: <Widget>[
                                        ListTile(
                                            leading:
                                                new Icon(Icons.photo_library),
                                            title: new Text('Galeria'),
                                            onTap: () => {
                                                  state.uploadImage(
                                                      'galery', userId)
                                                }),
                                        new ListTile(
                                          leading: new Icon(Icons.camera_alt),
                                          title: new Text('Video'),
                                          onTap: () => {
                                            state.uploadImage('camera', userId)
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                    state.hasError?Text('${state.errorText}'):Container()
                  ],
                ),
              );
            });
  List<Picture> pictures = List();
  @override
  _ListPictureFieldState createState() => _ListPictureFieldState();
}

class _ListPictureFieldState extends FormFieldState<List> {
  Storage storage;
  void deleteImage(int i, String userId) {
    storage.deleteImage(widget.pictures[i].name, userId);
    widget.pictures.removeAt(i);
    didChange(widget.pictures);
  }

  void uploadImage(String type, String userId) async {
    final picture = await storage.uploadImage(type, userId);
    widget.pictures.add(picture);
    didChange(widget.pictures);
  }

  @override
  ListPictureField get widget => super.widget;

  List<Picture> get _effectiveListPictures => widget.pictures;
  @override
  void initState() {
    widget.pictures = List();
    storage = Storage();
    super.initState();
  }
}
