function [Z,R,QDTest,QDTrain,QDFinal,QSTest,QSTrain,QSFinal] = DeepEnsembling(X,np,k,Y,T,TS)
    D=[];
    for i=1:np/2
%         disp([' --------------- DE - Iteration: ' num2str(i) ' --------------- ']);
        %% Get The Deep Self-Ensembling Results
        if(i==1)
            [F,R] = PredictTestLabels(X,np,k,Y,T,TS);
        else
            [F,R] = PredictTestLabels(R,np,k,Y,T,TS);
        end
        %% Cluster The Deep Self-Ensembling Results by unsupervised DP
        TF(:,i) = F;
        D(:,i) = GetComparedModel(R,k,1);
        %% Finding Correct Labels bwtween the NData and DPData
        [Ztest,~,~] = DetectBestResults(TF,D,T,TS,Y,1);
        Z(TS,i) = Ztest;
        Z(T,i) = F(T,:);
        % we don't need this as 
        Bidx = randperm(size(R,2),i);        
        %Bidx = GetBetterIndexes(R(T,:),Y(T,:),i);
        [Ztest,~,~] = DetectBestResults(TF,R(:,1),T,TS,Y,2);
        R(TS,i) = Ztest;
        %R(T,:) = X(T,B2);
    end
    [QDTest,QDTrain,QDFinal] = DetectBestResults(Z,R,T,TS,Y,1); % The Best Choice
    [QSTest,QSTrain,QSFinal] = DetectBestResults(R,Z,T,TS,Y,2); % The Best when R to Z
    
end



 
%      %% Check Best Train labels
%     FinalAccuracy = ObtainAccuracy(TF,Y);                           % Just for checking
%     OM_Max = max(FinalAccuracy); OM_Min = min(FinalAccuracy);
%     FinalAccuracy = ObtainAccuracy(D,Y);                           % Just for checking
%     DP_Max = max(FinalAccuracy); DP_Min = min(FinalAccuracy);
%     
%     disp([' Min OM : ' num2str(OM_Min),...
%         ' Max OM : ' num2str(OM_Max) ,...
%         ' Min DP : ' num2str(DP_Min) ,...
%         ' Max DP : ' num2str(DP_Max) ,...
%         ' FBR Final : ' num2str(FBR_FinalAccuracy) ,...
%         ' FBR Test : ' num2str(FBR_TestAccuracy) ,...
%         ' SM Final : ' num2str(SM_FinalResults) ,...
%         ' SM Final : ' num2str(SM_TestAccuracy)]);
% 
%     AllAccuracries(:,1:8) = [OM_Min,OM_Max,DP_Min,DP_Max,FBR_FinalAccuracy,FBR_TestAccuracy,SM_FinalResults,SM_TestAccuracy];
