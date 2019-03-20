// Zebrafish Binary Overlay Maker 1.0
// David Stirling, 2019
// Pulls images from a directory, must be in sequence.
// Binarises the green channel
// Overlays in green and transmission
// Saves to a new folder with the same structure
//

run("Close All");
input_dir = getDirectory("Select Montage Folder");
save_dir = getDirectory("Select Output Folder");
fileList = getFileList(input_dir);
directorieslist = newArray();
firstimage = true;

// Generate a list of subfolders containing each set of images
   for (i = 0 ; i < lengthOf(fileList); i++) {
                if (endsWith(fileList[i], "/")) {
                      directorieslist = Array.concat(directorieslist, fileList[i]); 
                };
                };

// Cycle Through directories and images
for (j=0 ; j < lengthOf(directorieslist); j++){
	littlefilelist = getFileList(input_dir + directorieslist[j]);
	print(lengthOf(littlefilelist));
	if (lengthOf(littlefilelist) > 0) {
	current = littlefilelist[0];
	for (id=0 ; id < lengthOf(littlefilelist); id++){
		 testName = File.getName(littlefilelist[id]);
		if (endsWith(testName, ".tif")) {
          if (firstimage == true) {
          	// This must be the green image
          	savefilename = testName;
          		print("Opening image");
				print(input_dir + directorieslist[j] + littlefilelist[id]);
          	open(input_dir + directorieslist[j] + littlefilelist[id]);

			//Perform operations to fix and binarise
			rename("green");
			if (bitDepth() != 8) {
				run("8-bit");
			};
			run("Auto Threshold", "method=RenyiEntropy white");
          	firstimage = false;
          	
         		} else {
          	// This must be the bf image
          	open(input_dir + directorieslist[j] + littlefilelist[id]);
			// Overlay and save file
			rename("bf");
			run("8-bit");
			run("Merge Channels...", "c2=green c4=bf create");
			if (!File.exists(save_dir + directorieslist[j])) File.makeDirectory(save_dir + directorieslist[j]);
			saveAs("PNG", save_dir + directorieslist[j] + savefilename);
      		run("Close All");
      		firstimage = true;
          	};
          };
	};
    };
};