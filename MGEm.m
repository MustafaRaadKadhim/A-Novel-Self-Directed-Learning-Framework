function idx = MGEm(data,K)
    [n,~]=size(data);
    cvp = cvpartition(n,'holdout',0.5);
    IDX = training(cvp,1);
    TrainSetIdx = find(IDX == 1); % Training set indices
    IDX = test(cvp,1);
    testSetIdx = find(IDX == 1); % Training set indices
    XTrain = data(TrainSetIdx,:)';
    XTest = data(testSetIdx,:)';
    [MGEm_labels,model,llh] = mixGaussEm(XTrain,K);
    MGP_labels = mixGaussPred(XTest,model);
    idx(TrainSetIdx,:) = MGEm_labels';
    idx(testSetIdx,:) = MGP_labels';
end 