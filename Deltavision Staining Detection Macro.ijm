// Deltavision Analyser 1.0
// David Stirling, 2019
// Runs through a directory
// Segments max projection
// Analyses staining in C2
//
run("Close All");
input_dir = getDirectory("Select Input Folder");
fileList = getFileList(input_dir);

directories = newArray();

// Generate a list of subfolders containing each set of images
   for (i = 0 ; i < lengthOf(fileList); i++) {
   	testName = File.getName(fileList[i]);
   	if (endsWith(testName, "c1.tif")) {
          	filename = input_dir + fileList[i];
          	open(filename);
          	run("Duplicate...", "title=[blue image]");
			
    }; else if (endsWith(testName, "c2.tif")) {
    		filename = input_dir + fileList[i];
          	open(filename);
          	stainimage=getTitle;
          	//run("Duplicate...", "title=[stain image]");
          	selectWindow("blue image");
          	
	run("Subtract Background...", "rolling=50");
	run("Auto Threshold", "method=Default white");
	run("Open");
	run("Invert");
	run("Fill Holes");
	run("Watershed");
	run("Set Measurements...", "area mean min centroid integrated display add redirect="+stainimage+" decimal=3");

	run("Analyze Particles...", "size=20-Infinity show=[Count Masks] display");
	run("Close All");
    }
    

	
	};


