// Hermes Zebrafish Overlay Maker 1.0
// David Stirling, 2018
// Pulls images from two directories
// Overlays in green and transmission
// Saves to a new folder
//

greenPath = getDirectory("Select the folder with the green images");
greenList = getFileList(greenPath)
whitePath = getDirectory("Select the folder with the brightfield images");
whiteList = getFileList(whitePath)
greenFiltered = newArray();
whiteFiltered = newArray();
//Make me into a function and apply to both
        for (i = 0 ; i < lengthOf(greenList); i++) {
        	
                testName = File.getName(greenList[i]);
                if (endsWith(testName, ".bmp")) {
                      path = greenPath + greenList[i];
                      greenFiltered = Array.concat(greenFiltered,path); 
                };
                };
        for (i = 0 ; i < lengthOf(whiteList); i++) {
        	
                testName = File.getName(whiteList[i]);
                if (endsWith(testName, ".bmp")) {
                      path = whitePath + whiteList[i];
                      whiteFiltered = Array.concat(whiteFiltered,path); 
                };
                };

total = lengthOf(greenFiltered);
saveDir = getDirectory("Choose a folder in which to save the overlays");

for (i=0; i<total; i++) {
     open(greenFiltered[i]);
     greenImage = getInfo("image.filename");
     run("8-bit");
     open(whiteFiltered[i]);
     whiteImage = getInfo("image.filename");
     run("8-bit");
	
     fullName = File.getName(whiteFiltered[i]);
     name = substring(fullName, 0, 3);  
	run("Merge Channels...", "c2=["+greenImage+"] c4=["+whiteImage+"]");
	saveTgt = saveDir + name + ".tif";
	saveAs("TIFF", saveTgt);
	close();
   };



