function EVAL = caculateAccuracy(ACTUAL,PREDICTED)
    % Barnan Das (2021). Performance Measures for Classification 
    % (https://www.mathworks.com/matlabcentral/fileexchange/37758-performance-measures-for-classification), 
    %     MATLAB Central File Exchange. Retrieved April 2, 2021.
    % This fucntion evaluates the performance of a classification model by 
    % calculating the common performance measures: 
     
    % 1- Accuracy,
    % 2- Sensitivity,
    % 3- Specificity,
    % 4- Precision,
    % 5- Recall,
    % 6- F-Measure,
    % 7- G-mean
 
    % Input: ACTUAL = Column matrix with actual class labels of the training
    %                 examples
    %        PREDICTED = Column matrix with predicted class labels by the
    %                    classification model
    % Output: EVAL = Row matrix with all the performance measures
    for i=1:size(PREDICTED,2)
        idx = (ACTUAL()==1);
        p = length(ACTUAL(idx));
        n = length(ACTUAL(~idx));
        N = p+n;
        tp = sum(ACTUAL(idx)==PREDICTED(idx,i));
        tn = sum(ACTUAL(~idx)==PREDICTED(~idx,i));
        fp = n-tn;
        fn = p-tp;
        tp_rate = tp/p;
        tn_rate = tn/n;
        accuracy = (tp+tn)/N;
        sensitivity = tp_rate;
        specificity = tn_rate;
        precision = tp/(tp+fp);
        recall = sensitivity;
        f_measure = 2*((precision*recall)/(precision + recall));
        gmean = sqrt(tp_rate*tn_rate);
        EVAL(i,:) = [accuracy sensitivity specificity precision recall f_measure gmean];
    end
    
 end