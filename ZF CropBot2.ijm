// Zebrafish Image Formatter
// David Stirling, 2019
// Open a brightfield and fluorescence image. Have nothing else open in ImageJ.
// Draw a box around the fish.
// This macro crops to the selection, flips to the correct orientation, binarises signal, overlays and adds a scale bar.
// Result is saved as a tif file.

// ################# SET THESE OPTIONS #################
threshold = 5100;  // Pick a threshold (pixel intensity value)
flipHorizontal = true; //true or false, does image need to be flipped horizontally? 
flipVertical = false; //true or false, does image need to be flipped vertically?
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
selectImage(fluor);
run("Restore Selection");
run("Crop");
if (flipHorizontal) run("Flip Horizontally");
if (flipVertical) run("Flip Vertically");
setThreshold(threshold, 65535);
setOption("BlackBackground", true);
run("Convert to Mask");
selectImage(bright);
run("Crop");
if (flipHorizontal) run("Flip Horizontally");
if (flipVertical) run("Flip Vertically");
setOption("ScaleConversions", true);
run("8-bit");

// ##### Tweak colours and scale bar settings in these lines if necessary #####
run("Merge Channels...", "c2=["+fluor+"] c4=["+bright+"]"); //c2 is green, c1 is red, c4 is grey
run("Scale Bar...", "width=0.05 height=4 font=14 color=Black background=None location=[Lower Left] bold hide");
// #####

run("RGB Color");
savepath = outputPath+bright;
saveAs("Tiff", savepath);
run("Close All");