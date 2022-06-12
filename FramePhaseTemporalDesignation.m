%% Clinical MCE Frame Phase Temporal Designation
% generate average pixel intensity vs frame number plot for post-procesed
% images
intensity = [];
for k = 1:length(images)
    intensity(k) = mean(images{k},'all');
end

% interval are the frame numbers for the first 5 frames after microbubble
% destruction; set intensity for first 5 frames after microbubble destruction to 0
intensity(interval(1):interval(5))= 0;
% find local minima and maxima for each heart beat
localmaxpoints = islocalmax(intensity,'MinSeparation',20);
localminpoints = islocalmin(intensity,'MinSeparation',20);
% remove local minima and maxima for 5 frames after microbubble destruction
localmaxpoints(interval(1):interval(5))= 0;
localminpoints(interval(1):interval(5))= 0;

%First group
localmaxframe = find(localmaxpoints==1,2);
DSC_firstgroup = [];
for i = 1:length(images)
    DSC_firstgroup(i)=dice(images{localmaxframe(2)},images{i});
end 
first_group_frames = find(DSC_firstgroup>mean(DSC_firstgroup))

%Second group
localminframe = find(localminpoints==1,2);
DSC_secondgroup = [];
for i = 1:length(images)
    DSC_secondgroup(i)=dice(images{localminframe(2)},images{i});
end 
second_group_frames = find(DSC_secondgroup>mean(DSC_secondgroup));
% remove second group frames that have already been classified
keep_frames_secondgroup = (~ismember(second_group_frames,first_group_frames));
second_group_frames = second_group_frames(keep_frames_secondgroup);

%Third group
third_group_frames = interval(1):interval(5);
allocated_frames1 = sort([first_group_frames second_group_frames]);
keep_frames_thirdgroup = (~ismember(third_group_frames,allocated_frames1));
third_group_frames = third_group_frames(keep_frames_thirdgroup);

%Fourth group
allocated_frames2 = sort([first_group_frames second_group_frames third_group_frames]);
keep_frames_fourthgroup = ~ismember(all_frame_no,allocated_frames);
fourth_group_frames = all_frame_no(keep_frames_fourthgroup);

% Identify reference frames
first_group_frames_ref = first_group_frames(1);
second_group_frames_ref = second_group_frames(1);
third_group_frames_ref = third_group_frames(1);
fourth_group_frames_ref = fourth_group_frames(1);

%% HFR-CE Frame Phase Temporal Designation
% generate average pixel intensity vs frame number plot for post-procesed
% images
intensity = [];
for k = 1:length(images)
    intensity(k) = mean(images{k},'all');
end

% interval are the frame numbers for the first 5 frames after microbubble
% destruction; set intensity for first 5 frames after microbubble destruction to 0
intensity(interval(1):interval(5))= 0;
% find local minima and maxima for each heart beat
localmaxpoints = islocalmax(intensity,'MinSeparation',40);
localminpoints = islocalmin(intensity,'MinSeparation',50);

%First group
localmaxframe = find(localmaxpoints==1,2);
DSC_firstgroup = [];
for i = 1:length(images)
    DSC_firstgroup(i)=dice(images{localmaxframe(2)},images{i});
end 
first_group_frames = find(DSC_firstgroup>mean(DSC_firstgroup))

%Second group
localminframe = find(localminpoints==1,2);
DSC_secondgroup = [];
for i = 1:length(images)
    DSC_secondgroup(i)=dice(images{localminframe(2)},images{i});
end 
second_group_frames = find(DSC_secondgroup>mean(DSC_secondgroup));
% remove second group frames that have already been classified
keep_frames_secondgroup = (~ismember(second_group_frames,first_group_frames));
second_group_frames = second_group_frames(keep_frames_secondgroup);

%Third group
allocated_frames1 = sort([first_group_frames second_group_frames]);
third_group_frames_prelim = (~ismember(all_frame_no,allocated_frames1);
DSC_thirdgroup = []
for i = 1:length(images)
    DSC_thirdgroup(i)=dice(third_group_frames_prelim{2},images{i});
end 
third_group_frames = find(DSC_thirdgroup>mean(DSC_thirdgroup));
keep_frames_thirdgroup = (~ismember(third_group_frames,allocated_frames1));
third_group_frames = third_group_frames(keep_frames_thirdgroup)

%Fourth group
allocated_frames2 = sort([first_group_frames second_group_frames third_group_frames]);
keep_frames_fourthgroup = ~ismember(all_frame_no,allocated_frames2);
fourth_group_frames = all_frame_no(keep_frames_fourthgroup);

% Identify reference frames
first_group_frames_ref = first_group_frames(1);
second_group_frames_ref = second_group_frames(1);
third_group_frames_ref = third_group_frames(1);
fourth_group_frames_ref = fourth_group_frames(1);

















