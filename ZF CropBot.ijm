//"Draw the polygon ROI on transmission, then select the target image and hit run. Macro will replicate the ROI and save a subsetted image.
run("Restore Selection");
run("Crop");
run("Make Inverse");
setBackgroundColor(0, 0, 0);
run("Clear", "slice");
name=getTitle;
path="C:/Users/user/Desktop/croppedtif/";
savepath = path+name
saveAs("Tiff", savepath);
run("Close All");
