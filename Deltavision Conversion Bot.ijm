// Deltavision Format Changer 1.0
// David Stirling, 2019
// Runs through a directory
// Generates a maximum projection
// Saves to a new folder
//
run("Close All");
input_dir = getDirectory("Select Input Folder");
save_dir = getDirectory("Select Output Folder");
fileList = getFileList(input_dir);
directories = newArray();

// Generate a list of subfolders containing each set of images
   for (i = 0 ; i < lengthOf(fileList); i++) {
   	testName = File.getName(fileList[i]);
   	if (endsWith(testName, ".dv")) {
          		print("Opening image");
				print(input_dir + fileList[i]);
          	filename = input_dir + fileList[i];
          	run("Bio-Formats Windowless Importer", "open=[filename] split_channels");

    };
    
	//run("Z Project...", "projection=[Max Intensity]");
	savefilename = getInfo("image.filename");
	run("Z Project...", "projection=[Max Intensity]");
	run("Split Channels");
	
	saveAs("Tiff", save_dir + savefilename + "_c2");
	close();
	saveAs("Tiff", save_dir + savefilename + "_c1");
	run("Close All");
	
	};