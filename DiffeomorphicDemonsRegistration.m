%% Diffeomorphic Demons Registration
% reference frames from phase designation methodology denoted as
% ref_frames(1), ref_frames(2), ref_frames(3) and ref_frames(4) and masks
% for these reference frames from automatic reference frames segmetnation
% denoted as new_reference_masks{1}, new_reference_masks{2},
% new_reference_masks{3} and new_reference_masks{4}

% first_group_frames, second_group_frames, third_group_frames and
% fourth_group_frames from frame phase temporal designation 

%generate predicted masks for all frames in newly acquired sequence
predicted_masks = cell(length(images),1);
for i=1:length(images)
    if ismember(i,first_group_frames)
        ref_mask = new_reference_masks{1};
        ref_image = ref_frames{1};
    elseif ismember(i,second_group_frames)
        ref_mask = new_reference_masks{2};
        ref_image = ref_frames{2}   ; 
    elseif ismember(i,third_group_frames)
        ref_mask = new_reference_masks{3};
        ref_image = ref_frames{3};
    elseif ismember(i,fourth_group_frames)
        ref_mask = new_reference_masks{4};
        ref_image = ref_frames{4};
    end
    deforming_image = images{i};
    [D,movingReg] = imregdemons(ref_image,deforming_image,[100],'PyramidLevels',5,...
        'AccumulatedFieldSmoothing',1);
    predicted_masks{i} = imwarp(ref_mask,D,'nearest');
end

