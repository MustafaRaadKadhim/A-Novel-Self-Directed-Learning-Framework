function [F,R] = PredictTestLabels(X,np,k,Y,T,TS)
    % disp([' --------------- Predicting Test Set Labels  --------------- ']);
    Ytrain = Y(T,:);
    for i=1:np/2
        %% First Unsupervised Cluster Ensemble 
        if(i<=2)
            [Z] = KGensemble(X,np,k);            
        else
            [Z] = KGensemble(R,np,k);
        end
        %% Obtain high Train Accuracy to Create New Labels
        [~, Zidx] = max(ObtainAccuracy(Z(T,:),Ytrain));
        if(mod(i,2)==1) 
            R(T,i) = Z(T,Zidx);
        else
            R(T,i) = Ytrain;
        end
        R(TS,i) = Z(TS,Zidx);
    end
    [~,Ridx] = max(ObtainAccuracy(R(T,:),Ytrain));
    F(T,1) = R(T,Ridx); 
    F(TS,1) = R(TS,Ridx);
end