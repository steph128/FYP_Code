%% Clinical MCE Post-Processing Techniques 
for frame = first_frame:last_frame
    image = images{frame}
    % intensity adjustment operation
    image_imadjust = imadjust(image,[0.8 0.95],[0 1])
    % edge-preserving smoothing operation
    image_smooth = imguidedfilter(image_imadjust,'NeighborhoodSize',[40,40])
    % threshold operation
    [pixelCount, grayLevels] = imhist(image_smooth)
    pixel_value = 100
    threshold_intensity_index = find(pixelCount(pixel_value:end)>110,3) 
    threshold_intensity_value = grayLevels(median(threshold_intensity_index)+pixel_value)
    image_binary = image_smooth>threshold_intensity_value 
    % morphological opening operation
    se_erode = strel('disk',2);
    image_erode = imerode(image_binary,se_erode)
    se_dilate = strel('disk',1);
    image_dilate = imdilate(image_erode,se_dilate)
    % hole-filling operation
    filled = imfill(image_dilate,'holes')
    holes = filled & ~image_dilate
    bigholes = bwareaopen(holes,90);
    smallholes = holes & ~bigholes;
    image_hole = image_dilate | smallholes; % post-processed image 
end



%% Research HFR-CE Post-Processing Techniques 
for frame = first_frame:last_frame
    image = images{frame}
    % intensity adjustment operation
    image_imadjust = imadjust(image,[0.2 0.8],[0 1])
    % edge-preserving smoothing operation
    image_smooth = imguidedfilter(image_imadjust,'NeighborhoodSize',[40,40])
    % threshold operation
    [pixelCount, grayLevels] = imhist(image_smooth)
    pixel_value = 100
    threshold_intensity_index = find(pixelCount(pixel_value:end)>800,3) 
    threshold_intensity_value = grayLevels(median(threshold_intensity_index)+pixel_value)
    image_binary = image_smooth>threshold_intensity_value 
    % morphological opening operation
    se_erode = strel('disk',2);
    image_erode = imerode(image_binary,se_erode)
    se_dilate = strel('disk',1);
    image_dilate = imdilate(image_erode,se_dilate)
    % hole-filling operation
    filled = imfill(image_dilate,'holes')
    holes = filled & ~image_dilate
    bigholes = bwareaopen(holes,90);
    smallholes = holes & ~bigholes;
    image_hole = image_dilate | smallholes; % post-processed image 
end
