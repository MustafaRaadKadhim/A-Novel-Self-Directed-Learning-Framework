clc;
clear;
load HTRU2.mat;
Y = labels;
k = max(labels); % Get No of k
np = 10; % Number of posibilites 20 (Recommended)
LabelsRate = 0.3; % 30%
n = size(data,1);
c = cvpartition(n,'Holdout',(1-LabelsRate));
T = find(c.training == 1);
TS = find(c.test == 1);
NY = zeros(length(Y),1);
NY(T,:) = Y(T,:);

disp([' --------------- High Time Resolution Universe 2 dataset - Size : ' num2str(size(data,1)) 'x' num2str(size(data,2)) 'x' num2str(k) ' --------------- ']);

%% Obtain the base Clustering Results
disp([' --------------- k-means - start --------------- ']);
tic;
BC = zeros(n,np);
for i=1:np
	BC(:,i) = kmeans(data,k);
end
toc;
disp([' --------------- k-means - end --------------- ']);

%% Deep Ensembling
disp([' --------------- SDL - start  --------------- ']);
tic;
[~,SDLr,~,~,DBRD,~,~,DBRS] = SDLEnsembling(BC,np,k,Y,T,TS);
toc;
disp([' --------------- SDL - end --------------- ']);


disp([' _______________ Evaluation - start _______________ ']);
results = {BC,SDLr,DBRD,DBRS};
methods = {'k-means','SDL','DBR-D','DBR-S'};
for i=1:4
    R = caculateAccuracy(Y,results{i});
    Msg = [methods{i} ' Min Accuracy = ' num2str(min(R(:,1))) ' Max Accuracy = ' num2str(max(R(:,1)))];
    disp(Msg);
    Msg = [methods{i} ' precision = ' num2str(max(R(:,4))) ' recall = ' num2str(max(R(:,5))) ' F1-measure = ' num2str(max(R(:,5)))];
    disp(Msg);
    disp('----------------------------------------');
end
disp([' _______________ Evaluation - end _______________ ']);

