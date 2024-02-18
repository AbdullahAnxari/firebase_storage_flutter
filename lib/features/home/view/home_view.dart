import '../../../firebase_storage_flutter.dart';

class HomeView extends GetView<StorageController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body,
      appBar: _appBar,
    );
  }

  //*AppBar
  AppBar get _appBar => AppBar(
        title: const Text('Firebase Auth'),
      );

  //*Body
  Widget get _body => GetBuilder<StorageController>(builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                controller.result != null
                    ? Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: FileImage(
                                File(controller.result!.files.single.path!)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),

                //* FilePicker button
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    await controller.filePicker();
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.attach_file),
                      SizedBox(width: 8.0),
                      Text('Choose File'),
                    ],
                  ),
                ),
                //*upload file
                ElevatedButton(
                  onPressed: () async {
                    await controller.storageRef();
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cloud_upload),
                      SizedBox(width: 8.0),
                      Text('Upload to Storage'),
                    ],
                  ),
                ),
                // Add more spacing between the buttons
                const SizedBox(height: 16.0),

                //* Delete Uploaded File button
                //!Not working
                ElevatedButton(
                  onPressed: () async {
                    String filePath = 'images/dfd level 0.png';
                    await controller.deleteUploadedFile(fullPath: filePath);
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 8.0),
                      Text('Delete Uploaded File'),
                    ],
                  ),
                ),

                //*Get SINGLE IMAGE from firebase
                // FutureBuilder<String>(
                //   future:
                //       _.getImageUrl(), // Call storageController's getImageUrl()
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       return Image.network(
                //         snapshot.data!,
                //         width: 200.0, // Adjust width as needed
                //         height: 200.0, // Adjust height as needed
                //         fit: BoxFit.cover, // Adjust fit as needed
                //         loadingBuilder: (context, child, loadingProgress) {
                //           if (loadingProgress == null) {
                //             return child;
                //           }
                //           return const Center(
                //               child: CircularProgressIndicator());
                //         },
                //         errorBuilder: (context, error, trace) {
                //           return Text("Error loading image: $error");
                //         },
                //       );
                //     } else if (snapshot.hasError) {
                //       return Text(
                //           "Error retrieving image URL: ${snapshot.error}");
                //     }
                //     return const Text("Loading image...");
                //   },
                // ),

                //*Mulitple images
                FutureBuilder<List<String>>(
                  future: _.getImageUrlList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // Successfully retrieved image URLs
                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Adjust as needed
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                        ),
                        // Build each image widget based on the number of URLs
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            // Use the URL from the list at the current index
                            snapshot.data![index],
                            fit: BoxFit.cover, // Adjust as needed
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                // Show the image while it's loading
                                return child;
                              }
                              // Show a progress indicator while loading
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, trace) {
                              return Text("Error loading image: $error");
                            },
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                          "Error retrieving image URLs: ${snapshot.error}");
                    }
                    return const Text("Loading images...");
                  },
                ),
              ],
            ),
          ),
        );
      });
}
