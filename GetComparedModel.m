function cl = GetComparedModel(X,k,EI)
    n = size(X,1);
    for Iter = 1:EI
        if(n<=3500)
            cl(:,Iter) = ClusterDP(X,k);
        else
            cl(:,Iter) = MGEm(X,k);
        end
    end
end