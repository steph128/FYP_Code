%% Automatic Reference Frames Segmentation
% load in all segmented images and corresponding manual segmentations 
all_segmented_images = load(all_segmented_images)
all_segmented_masks = load(all_segmented_masks)

% reference frames from phase designation methodology denoted as
% ref_frames(1), ref_frames(2), ref_frames(3) and ref_frames(4)
% identify most similar pairs 
DSC1 = []
DSC2 = []
DSC3 = []
DSC4 = []

for i=1:length(all_segmented_images)
    DSC1(i) = dice(all_segmented_images{i},ref_frames{1})
end
for i=1:length(all_segmented_images)
    DSC2(i) = dice(all_segmented_images{i},ref_frames{2})
end
for i=1:length(all_segmented_images)
    DSC3(i) = dice(all_segmented_images{i},ref_frames{3})
end
for i=1:length(all_segmented_images)
    DSC4(i) = dice(all_segmented_images{i},ref_frames{4})
end

most_similar_frames = []
[~,most_similar_frames(1)]=max(DSC1)
[~,most_similar_frames(2)]=max(DSC2)
[~,most_similar_frames(3)]=max(DSC3)
[~,most_similar_frames(4)]=max(DSC4)

segmented_ref_images = cell(4,1)
segmented_ref_images{1}=all_segmented_images{most_similar_frames(1)}
segmented_ref_images{2}=all_segmented_images{most_similar_frames(2)}
segmented_ref_images{3}=all_segmented_images{most_similar_frames(3)}
segmented_ref_images{4}=all_segmented_images{most_similar_frames(4)}
segmented_ref_masks= cell(4,1)
segmented_ref_masks{1} = all_segmented_masks{most_similar_frames(1)}
segmented_ref_masks{2} = all_segmented_masks{most_similar_frames(2)}
segmented_ref_masks{3} = all_segmented_masks{most_similar_frames(3)}
segmented_ref_masks{4} = all_segmented_masks{most_similar_frames(4)}

% generate reference frames segmentations
new_reference_masks = cell(4,1)
for i =1:4
    ref_image = segmented_ref_images{i}
    ref_mask = segmented_ref_masks{i}
    deforming_image = ref_frames{i}
    [D,movingReg] = imregdemons(ref_image,deforming_image,[100],'PyramidLevels',5,...
        'AccumulatedFieldSmoothing',1.0);
    new_reference_masks{i} = imwarp(ref_mask,D,'nearest')
end















