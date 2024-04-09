function [RTest, RTrain, R] = DetectBestResults(X,Z,T,TS,Y,M)
Xtest = X(TS,:);
Ztest = Z(TS,:);
if(M==1)
    for i=1:length(TS)
        LValue=0;
        [~, mI] = min(pdist2(Xtest, Ztest(i,:)));
        %% Start ------ max(duplicate(Xtest(mI,:)))
        [C,ia,ic] = unique(Xtest(mI,:),'rows');
        if(length(C) ==1)
            LValue = C;
        else
            a_counts = accumarray(ic,1);
            value_counts = [C, a_counts];
            [a mI] = max(value_counts(:,2));
            LValue = value_counts(mI,1);
        end
        %% End
        RTest(i,:) = LValue;
        
    end
elseif(M==2)
    P= [];
    for i=1:length(TS)
        for j=1:size(Ztest,2)
            if(Xtest(i,j) == Ztest(i,j))
                P(i,j) = Xtest(i,j);
            else
                P(i,j) = 0;
            end
        end
        %% Start ------ max(duplicate(P(i,m))) 
        [C,ia,ic] = unique(P(i,:),'rows');
        if(length(C) ==1)  
            LValue = C;
        else  
            a_counts = accumarray(ic,1);
            value_counts = [C, a_counts];
            I=find(value_counts == 0);
            value_counts(:,I) = [];
            if(length(value_counts)==1)
                LValue = unique(Xtest(i,:));
                LValue = LValue(1);
            else
                [a mI] = max(value_counts(:,2));
                LValue = value_counts(mI,1);
            end
        end
        %% End
        RTest(i,:) = LValue;
    end
end
[Xaccuracy,Xidx] = max(ObtainAccuracy(X(T,:),Y(T,:)));
[Yaccuracy,Yidx] = max(ObtainAccuracy(Z(T,:),Y(T,:)));
if(Yaccuracy<=Xaccuracy)
    RTrain = X(T,Xidx);
elseif (Yaccuracy>Xaccuracy)
    RTrain = Z(T,Yidx);
end
R(T,:) = RTrain;
R(TS,:) = RTest;
end