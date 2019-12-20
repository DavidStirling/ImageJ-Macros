// Zebrafish Image Formatter - Interactive
// David Stirling, 2019
// Open a brightfield and fluorescence image. Have nothing else open in ImageJ.
// Set the parameters below then select the brightfield image. Run the macro.
// This macro interactively flips to the correct orientation, binarises signal,
// overlays, rotates, crops, and adds a scale bar.
// Result is saved as a tif file.

// ################# SET THESE OPTIONS #################
threshold = 5100;  // Pick a threshold (pixel intensity value)
outputPath="C:/Users/dstirlin/Downloads/Images_forSciRepReviews_for_DS/Done/"; //Directory to save images to
// #####################################################

// Identify Images, assumes currently selected image is Brightfield.
list = getList("image.titles");
  if (list.length==0)
     print("No image windows are open");
  else {
  	if (getTitle==list[0]){
  		bright=list[0];
  		fluor = list[1];
  	}
  	else{
  		bright = list[1];
  		fluor = list[0];
  	};
  };
selectImage(bright);
run("8-bit");
selectImage(fluor);
setThreshold(threshold, 65535);
setOption("BlackBackground", true);
run("Convert to Mask");

// ##### Tweak overlay colours here if necessary #####
run("Merge Channels...", "c2=["+fluor+"] c4=["+bright+"]"); //c2 is green, c1 is red, c4 is grey
// #####

if (getBoolean("Does the image need to be flipped horizontally?")) run("Flip Horizontally");
if (getBoolean("Does the image need to be flipped vertically?")) run("Flip Vertically");
run("RGB Color");
run("Rotate... ");
overlayimg = getTitle;
setTool("rectangle");

title = "Select Region for Cropping";
msg = "Draw a box around the fish, then click \"OK\".";
waitForUser(title, msg);
selectImage(overlayimg);
run("Crop");

// ##### Tweak scale bar settings here if necessary #####
run("Scale Bar...", "width=0.05 height=4 font=14 color=Black background=None location=[Lower Left] bold hide");
// #####


savepath = outputPath+bright;

if (getBoolean("Do you want to save this result image?")) saveAs("Tiff", savepath);
run("Close All");