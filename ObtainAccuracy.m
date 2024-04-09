function [Accuracy,Correct,InCorrect] = ObtainAccuracy(PredictedLabels,DataLabels)
    [n m] = size(PredictedLabels);
    for Results=1:m
        data = PredictedLabels(:,Results);
        Correct = 0;
        InCorrect = 0;
        N = length(data);
        idx = 1:N;
        I = find(data(idx,:) == DataLabels(idx,:));
        Correct = length(I);
        InCorrect = length(idx) - length(I);
        Accuracy(Results) = Correct/N;
    end
end

