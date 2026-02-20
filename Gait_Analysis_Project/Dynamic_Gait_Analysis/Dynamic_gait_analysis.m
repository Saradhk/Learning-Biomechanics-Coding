clear
clc
close all

%Filepath = fullfile('E:\Gaitlab','data','Model1','static_walk_1.trc');
Filepath = 'E:\Gaitlab\data\Model1\GIL01\GIL01\Slow3\IK\GIL01_slow3_ik.mot';      %#Alternativ way to open the file
T = readtable (Filepath,'FileType','text');

min_dist = 50;
time= T.time;
kneeR = T.knee_angle_r;
kneeL = T.knee_angle_l;
HipR = T.hip_flexion_r;
HipL = T.hip_flexion_l;

% Noise Filtering Section
%fs = 120;  % rate fc
%fc = 6;    % cut off
%[b, a] = butter(4, fc/(fs/2), 'low'); % Butterworth Filter 4 rate
% filtering all
%kneeL_f = filtfilt(b, a, kneeL);
%kneeR_f = filtfilt(b, a, kneeR);
%HipL_f = filtfilt(b, a, HipL); 
%HipR_f = filtfilt(b, a, HipR);

% Finding vallies in knee that show heal stricks
[~, HS_R_indices] = findpeaks(-kneeR, 'MinPeakDistance', 50);     %using - to find minimum angles of knee as the knee is on the extension at that time
[~, HS_L_indices] = findpeaks(-kneeL, 'MinPeakDistance', 50);
%adding manually to make a matrics based on the plot
HS_L_indices = [HS_L_indices, 160]; %adding 160 manually as we only had 1 vally in left side, and it makes it impossible to build a stride

% Showing number of them in each side
fprintf('right heal stricks: %d\n', length(HS_R_indices));
fprintf('left heal stricks: %d\n', length(HS_L_indices));

% Cheaking heal stricks
%figure;
%plot(kneeR, 'Color','k'); 
%hold on;
%plot(HS_R_indices, kneeR(HS_R_indices), 'ro', 'MarkerSize', 10);
%title('checking ');
%figure;
%plot(kneeL, 'Color','c'); 
%hold on;
%plot(HS_L_indices, kneeL(HS_L_indices), 'ro', 'MarkerSize', 10);
%title('checkingl ');

%Calculating Strides -  knee cycle 
all_strides_kneeR = [];
for i = 1: length(HS_R_indices) - 1
    start_idx = HS_R_indices(i);
    end_idx = HS_R_indices(i+1);
    one_stride = kneeR(start_idx : end_idx);
    old_x = linspace(1,100,length(one_stride));
    new_x = 1:100;
    normalized_stride = interp1(old_x, one_stride, new_x);
    all_strides_kneeR = [all_strides_kneeR; normalized_stride];
end

all_strides_kneeL = [];
for i = 1: length(HS_L_indices) - 1
    start_idx = HS_L_indices(i);
    end_idx = HS_L_indices(i+1);
    one_stride = kneeL(start_idx : end_idx);
    old_x = linspace(1,100,length(one_stride));
    new_x = 1:100;
    normalized_stride = interp1(old_x, one_stride, new_x);
    all_strides_kneeL = [all_strides_kneeL; normalized_stride];
end


%Mean of Right and Left knee Flexion
mean_kneeR = mean(all_strides_kneeR,1); 
mean_kneeL = mean(all_strides_kneeL,1);
%Standard Deviasion
std_kneeR = std(all_strides_kneeR,0,1); % 0 for normal weighting and 1 for mean in row level
std_kneeL = std(all_strides_kneeL,0,1);

%Symmetry Index
max_meanR = max(mean_kneeR);
max_meanL = max(mean_kneeL);
SI = ((max_meanR - max_meanL)/ (0.5*(max_meanR + max_meanL)))*100;
fprintf('\n--- Gait Symmetry Analysis Results ---\n');
fprintf('Peak Right Knee Flexion: %.2f degrees\n', max_meanR);
fprintf('Peak Left Knee Flexion:  %.2f degrees\n', max_meanL);
fprintf('Symmetry Index (SI):     %.2f%%\n', SI);
if abs(SI) < 10
    fprintf('Interpretation: Normal symmetry (within 10%% threshold).\n');
else
    if SI>0
        fprintf('Interpretation: Significant Asymmetry (Right leg is dominant/higher).\n');
    else
        fprintf('Interpretation: significant Asymmetry (Left leg is dominat/higher).\n');
    end
end
fprintf('--------------------------------------\n');

%Calculating Strides -  Hip cycle [I can add this into previous cycle too]
all_strides_HipR = [];
for i = 1: length(HS_R_indices) - 1
    start_idx = HS_R_indices(i);
    end_idx = HS_R_indices(i+1);
    one_stride = HipR(start_idx : end_idx);
    old_x = linspace(1,100,length(one_stride));
    new_x = 1:100;
    normalized_stride = interp1(old_x, one_stride, new_x);
    all_strides_HipR = [all_strides_HipR; normalized_stride];
end

all_strides_HipL = [];
for i = 1: length(HS_L_indices) - 1
    start_idx = HS_L_indices(i);
    end_idx = HS_L_indices(i+1);
    one_stride = HipL(start_idx : end_idx);
    old_x = linspace(1,100,length(one_stride));
    new_x = 1:100;
    normalized_stride = interp1(old_x, one_stride, new_x);
    all_strides_HipL = [all_strides_HipL; normalized_stride];
end
%Toe Off  
% At first I used min of hip flexion and the point of max hip extension,
% but it gives me 83% for estimated toe off and when I use the figure to
% check that, it was a point in the lowest part and it was wrong so it
% couldn't be the toe off point. So, I use knee data. Before the sudden
% flexion of the knee, it's a point of toe off

%%Checking the toe off point for hip %%
%figure;
%plot(mean_hipL, 'LineWidth', 2);
%hold on;
%plot(toe_off_idx, mean_hipL(toe_off_idx), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
%title(['Hip Angle - Selected Toe Off at ', num2str(toe_off_idx), '%']);
%grid on;

% Differation of knee
knee_velocity = diff(mean_kneeL); 
% The peak point of knee flexion
[~, max_vel_idx] = max(knee_velocity(40:70));
toe_off_knee = max_vel_idx + 40 - 5; % 5% before the peak speed, its toe off
fprintf('Toe-off estimation from Knee: %.2f%%\n', toe_off_knee);
t_off = toe_off_knee;

%ROM
rom_kneeR = max(mean_kneeR) - min(mean_kneeR);
rom_kneeL = max(mean_kneeL) - min(mean_kneeL);
fprintf('---kinemataic Results---\n');
fprintf('Knee ROM(Right): %.2f degrees\n', rom_kneeR);
fprintf('Knee ROM(Left): %.2f degrees\n', rom_kneeL);

%Figures
figure(1)

plot(kneeR); %plot knee as we calculate hs based on knee data in dynamic
hold on
plot(HS_R_indices,kneeR(HS_R_indices),'ro');
title('Comparing Heal Strikes and Right knee minimum angles');
hold off

figure(2)
plot(kneeL);
hold on
plot(HS_L_indices,kneeL(HS_L_indices),'ro');
title('Comparing Heal Strikes and Left knee minimum angles');
hold off

figure(3)
plot(time,kneeR,'Color','r');
hold on
plot(time,kneeL,'Color','b');
xlabel('time');
ylabel('Knee angle');
title('Comparing Knee angle');
legend('Right Knee', 'Left Knee','Location','best')

figure(4)
plot(1:100, mean_kneeR, 'r', 'LineWidth',1.5);
hold on
plot(1:100, mean_kneeL, 'b', 'LineWidth', 1.5);
title('Comparing Right and Left knee mean angles in gait cycle');
xlabel('Gait Cycle (%)');
ylabel('Knee Flextion Angle (deg)');
grid on;
hold on;
line([toe_off_knee toe_off_knee], ylim, 'Color', 'k', 'LineStyle', '--');
legend('Right Knee', 'Left Knee','Toe Off');

figure(5)
x = 1:100;
% Finding if we have enough data to calculate std 
if size(all_strides_kneeL, 1) > 1
    std_kneeL = std(all_strides_kneeL);
    upper_line = mean_kneeL + std_kneeL;
    lower_line = mean_kneeL - std_kneeL;
    fill([x, fliplr(x)], [upper_line, fliplr(lower_line)], 'b', 'FaceAlpha', 0.1, 'EdgeColor', 'none');
    hold on;
end

plot(x, mean_kneeL, 'r', 'LineWidth', 2);
line([t_off t_off], ylim, 'Color', 'k', 'LineStyle', '--'); 
%text(t_off, max(ylim)-5, 'Toe-Off', 'Rotation', 90, 'VerticalAlignment', 'bottom');
title('Knee Angle Mean (Left Leg)');
xlabel('Gait Cycle (%)'); ylabel('Angle (deg)');
grid on;

%Adding phase  text
y_limits = ylim;
y_top = y_limits(2); %top y
y_pos = y_top - (y_top - y_limits(1)) *0.1; % 5% lesser than top


%Adding line to showing stance and swing phases
line([t_off t_off], y_limits, 'Color', 'k', 'LineStyle', '--', 'LineWidth', 1.5);
text(30, y_pos, 'STANCE','HorizontalAlignment', 'center', 'FontWeight','bold', 'FontSize', 10);
text(80, y_pos, 'SWING','HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 10);

%Adding text of the line
y_mid = mean(y_limits);
text(60, y_mid + 0.12, '  \leftarrow Toe-Off', 'Rotation', 90, ...
    'FontSize', 10, 'FontWeight', 'bold', 'Color', 'b', ...
    'VerticalAlignment', 'middle');

title('Knee Angle Mean \pm SD (Left Leg)');
xlabel('Gait Cycle (%)');
ylabel('Angle (deg)');
grid on;

%Finding the claumn and row with them most changes
%all_data = table2array(T);
%variations = max(all_data) - min(all_data);
%[max_var, column_idx] = max(variations);

%fprintf('max changes; %.2f\n', column_idx, max_var);

