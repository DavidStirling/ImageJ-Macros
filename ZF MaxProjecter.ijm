// Hermes Zebrafish Montager 1.0
// David Stirling, 2018
// Runs through a montage directory
// Generates a maximum projection
// Crops off noise on the left side
// Saves to a new folder
//
run("Close All");
input_dir = getDirectory("Select Montage Folder");
save_dir = getDirectory("Select Output Folder");
fileList = getFileList(input_dir);
//whiteList = getFileList(whitePath);
directories = newArray();

// Generate a list of subfolders containing each set of images
   for (i = 0 ; i < lengthOf(fileList); i++) {
                if (endsWith(fileList[i], "/")) {
                      directories = Array.concat(directories, fileList[i]); 
                };
                };

// Cycle Through directories
for (j=0 ; j < lengthOf(directories); j++){
	littlefilelist = getFileList(input_dir + directories[j]);
	if (lengthOf(littlefilelist) > 0) {
	current = littlefilelist[0];
	for (id=0 ; id < lengthOf(littlefilelist); id++){
		 testName = File.getName(littlefilelist[id]);
		if (endsWith(testName, ".tif")) {
          if (indexOf(testName, "Green") >= 0) {
          	savefilename = testName;
          		print("Opening image");
				print(input_dir + directories[j] + littlefilelist[id]);
          	open(input_dir + directories[j] + littlefilelist[id]);

          };
	};
    };
    run("Images to Stack");
	//target = "open=" + littlefilelist[0] + " file=Green sort";
	//run("Image Sequence...", target);
	run("Z Project...", "projection=[Max Intensity]");
	run("Canvas Size...", "width=4300 height=1040 position=Center-Right");
	File.makeDirectory(save_dir + directories[j]);
	saveAs("Tiff", save_dir + directories[j] + savefilename);
	run("Close All");
	
	for (id=0 ; id < lengthOf(littlefilelist); id++){
		 testName = File.getName(littlefilelist[id]);
		if (endsWith(testName, ".tif")) {
          if (indexOf(testName, "Trans") >= 0) {
          	savefilename = testName;
          		print("Opening image");
				print(input_dir + directories[j] + littlefilelist[id]);
          	open(input_dir + directories[j] + littlefilelist[id]);

          };
	};
    };
    run("Images to Stack");
	//target = "open=" + littlefilelist[0] + " file=Green sort";
	//run("Image Sequence...", target);
	run("Z Project...", "projection=[Max Intensity]");
	run("Canvas Size...", "width=4300 height=1040 position=Center-Right");
	File.makeDirectory(save_dir + directories[j]);
	saveAs("Tiff", save_dir + directories[j] + savefilename);
	run("Close All");
	
	};

};
