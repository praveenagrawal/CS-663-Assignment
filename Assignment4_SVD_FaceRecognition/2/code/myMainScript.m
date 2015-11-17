%% MyMainScript

% Run-time ~ 3.26 minutes
tic;
%% Your code here
%% ORL database
clear;
clc;

directoryname = uigetdir('/home', 'Choose the folder which contains your database');
k = [2, 3, 5, 10, 20, 30, 50, 75, 100, 125, 150, 170];
recogRate = zeros(1,length(k));
xaxis = zeros(1,length(k));
for i = 1:length(k)
    recogRate(i) = q2a(k(i),directoryname);
    xaxis(i) = k(i);
end
figure()
scatter(xaxis,recogRate, 'k'); hold on;
plot(xaxis,recogRate);
title('Variation of recognition rate with k (ORL Database)');
xlabel('k');
ylabel('Recognition rate (in %)');

savefig( '../images/RecogRateORL');

%% YALE database
clear;
clc;

directoryname = uigetdir('/home/ankita/Acads/Sem 7/CS663-DIP/Assign/Assign 4', 'Choose the folder which contains your database');
k = [2, 3, 5, 10, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
recogRate = zeros(1,length(k));
xaxis = zeros(1,length(k));
for i = 1:length(k)
    recogRate(i) = q2b(k(i),directoryname);
    xaxis(i) = k(i);
end
figure()
scatter(xaxis,recogRate, 'k'); hold on;
plot(xaxis,recogRate);
title('Variation of recognition rate with k (YALE Database)');
xlabel('k');
ylabel('Recognition rate (in %)');

savefig( '../images/RecogRateYALE');

toc;


