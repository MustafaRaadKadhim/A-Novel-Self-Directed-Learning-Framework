function [BCL] = KGensemble(data,np,k)
    %% Get Base Clustering Results
    BCL=[];
    Iter= round(np/2);
	for i=1:Iter
        X= kmedoids(data,k);
        BCL = [BCL, X];
        X= MGEm(data,k);
        idx = randperm(size(data,2),1);
        data(:,idx) =X;
    	BCL = [BCL, X];
	end
end

