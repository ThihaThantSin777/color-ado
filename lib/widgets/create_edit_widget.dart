import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_ado/bloc/widget/create_edit_bloc.dart';
import 'package:color_ado/utils/files_utils.dart';
import 'package:color_ado/utils/string_extensions.dart';
import 'package:color_ado/widgets/card_item_widget.dart';
import 'package:color_ado/widgets/loadin_dialog_widget.dart';
import 'package:color_ado/widgets/sample_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateEditWidget extends StatefulWidget {
  const CreateEditWidget({
    super.key,
    this.preDescription,
    this.preImageURL,
    this.prePDFName,
    this.prePDFurl,
    this.preTitle,
    required this.title,
    required this.path,
    this.isEnableDescription = false,
    this.isEnableImage = false,
    this.isEnablePDFName = false,
    this.isEnableTitle = false,
    this.id,
    this.isEnableUploadPDF = false,
  });

  final String? preImageURL;
  final bool isEnableImage;
  final String? preTitle;
  final bool isEnableTitle;
  final String? prePDFName;
  final bool isEnablePDFName;
  final String? prePDFurl;
  final bool isEnableUploadPDF;
  final String? preDescription;
  final bool isEnableDescription;
  final String title;
  final int? id;
  final String path;

  @override
  State<CreateEditWidget> createState() => _CreateEditWidgetState();
}

class _CreateEditWidgetState extends State<CreateEditWidget> {
  final _titleController = TextEditingController();
  final _pdfNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.preTitle?.isNotEmpty ?? false) {
      _titleController.text = widget.preTitle ?? '';
    }
    if (widget.prePDFName?.isNotEmpty ?? false) {
      _pdfNameController.text = widget.prePDFName ?? '';
    }

    if (widget.preDescription?.isNotEmpty ?? false) {
      _descriptionController.text = widget.preDescription ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _pdfNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateEditBloc>(
      create: (_) => CreateEditBloc(
        userSelectImage: widget.preImageURL,
        userDescription: widget.preDescription,
        userTitle: widget.preTitle,
        path: widget.path,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isEnableImage) ...[
                  const _ImageView(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
                if (widget.isEnableTitle) ...[
                  Builder(builder: (context) {
                    return TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Enter Title'),
                      onChanged: (text) {
                        final bloc = context.read<CreateEditBloc>();
                        bloc.setTitle(text);
                      },
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
                if (widget.isEnableDescription) ...[
                  Builder(builder: (context) {
                    return TextField(
                      controller: _descriptionController,
                      maxLines: 7,
                      decoration: const InputDecoration(labelText: 'Enter Description'),
                      onChanged: (text) {
                        final bloc = context.read<CreateEditBloc>();
                        bloc.setDescription(text);
                      },
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
                if (widget.isEnablePDFName) ...[
                  Builder(builder: (context) {
                    return TextField(
                      controller: _pdfNameController,
                      decoration: const InputDecoration(labelText: 'Enter PDF Name'),
                      onChanged: (text) {
                        final bloc = context.read<CreateEditBloc>();
                        bloc.setPDFName(text);
                      },
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
                if (widget.isEnableUploadPDF) ...[
                  const _PDFUploadView(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
                Selector<CreateEditBloc, bool>(
                    selector: (_, bloc) => bloc.isBtnDisable,
                    builder: (context, isDisable, __) {
                      return MaterialButton(
                        minWidth: double.infinity,
                        height: 50,
                        color: Colors.blue,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        onPressed: isDisable
                            ? null
                            : () {
                                final bloc = context.read<CreateEditBloc>();
                                showDialog(context: context, builder: (_) => const LoadingDialog());
                                final cID = widget.id ?? DateTime.now().microsecondsSinceEpoch;
                                bloc.onTapSave(cID).then((value) {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }).catchError((error) {
                                  Navigator.of(context).pop();
                                  showDialog(
                                      context: context,
                                      builder: (_) => SampleDialogWidget(
                                            title: 'Error',
                                            content: error.toString(),
                                            buttonText: 'OK',
                                            onButtonPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ));
                                });
                              },
                        child: const Text('Save'),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PDFUploadView extends StatelessWidget {
  const _PDFUploadView();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MaterialButton(
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: () {
            FilesUtils.pickPdfFile().then((value) {
              if (value != null) {
                final bloc = context.read<CreateEditBloc>();
                bloc.setPDFUrl(value.path);
              }
            });
          },
          child: const Text('Upload PDF'),
        ),
        const SizedBox(
          width: 10,
        ),
        Selector<CreateEditBloc, String?>(
            selector: (_, bloc) => bloc.getPDFUrl,
            builder: (_, pdfPath, __) {
              if (pdfPath?.isNotEmpty ?? false) {
                return Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                          child: Text(
                        pdfPath ?? '',
                        maxLines: 2,
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            final bloc = context.read<CreateEditBloc>();
                            bloc.clearPDFURL();
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            })
      ],
    );
  }
}

class _ImageView extends StatelessWidget {
  const _ImageView();

  @override
  Widget build(BuildContext context) {
    return Selector<CreateEditBloc, String?>(
        selector: (_, bloc) => bloc.getUserSelectImage,
        builder: (_, userSelectImage, __) {
          if (userSelectImage?.isNotEmpty ?? false) {
            return SizedBox(
              width: double.infinity,
              height: 200,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: (userSelectImage ?? '').isNetworkImage
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: userSelectImage ?? '',
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(userSelectImage ?? ''),
                              ),
                            )),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          final bloc = context.read<CreateEditBloc>();
                          bloc.setClearUserSelectImage();
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Row(
            children: [
              Expanded(
                child: CardItemWidget(
                  iconData: Icons.camera,
                  title: "Camera",
                  onTapCard: () {
                    FilesUtils.takeImage().then((image) {
                      if (image != null) {
                        final bloc = context.read<CreateEditBloc>();
                        bloc.setUserSelectImage(image.path);
                      }
                    });
                  },
                ),
              ),
              Expanded(
                child: CardItemWidget(
                  iconData: Icons.image,
                  title: "Gallery",
                  onTapCard: () {
                    FilesUtils.takeImage(
                      isCamera: false,
                    ).then((image) {
                      if (image != null) {
                        final bloc = context.read<CreateEditBloc>();
                        bloc.setUserSelectImage(image.path);
                      }
                    });
                  },
                ),
              ),
            ],
          );
        });
  }
}
