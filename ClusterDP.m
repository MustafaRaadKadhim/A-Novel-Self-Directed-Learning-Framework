function cl=ClusterDP(X,k, Clusters)
    dism=pdist2(X,X);
    dc=2;
    N=size(X,1);
    percent=dc;%chose dc(cutoff distance)
    %fprintf('average percentage of neighbours (hard coded): %5.6f\n', percent);
    position=round(N*percent/100);
    sda=sort(X(:,1));
    %fprintf('Computing Rho with gaussian kernel of radius: %12.6f\n', dc);
    rho = zeros(1,N);
    for i=1:N-1
        for j=i+1:N
            rho(i)=rho(i)+exp(-(dism(i,j)/dc)*(dism(i,j)/dc));%sum e^(d_ij)
            rho(j)=rho(j)+exp(-(dism(i,j)/dc)*(dism(i,j)/dc));
        end
    end
    maxd=max(max(dism));
    [rho_sorted,ordrho]=sort(rho,'descend');
    delta(ordrho(1))=-1.;
    nneigh(ordrho(1))=0;
    for ii=2:N
        delta(ordrho(ii))=maxd;%maxd=max(max(dism));
        for jj=1:ii-1
            if(dism(ordrho(ii),ordrho(jj))<delta(ordrho(ii)))
                delta(ordrho(ii))=dism(ordrho(ii),ordrho(jj));
                nneigh(ordrho(ii))=ordrho(jj);
            end
        end
    end
    delta(ordrho(1))=max(delta(:));%maxd=max(max(dism));
    cl = zeros(1,N);cl(:,:) = -1;
    NCLUST=k;
    dr=delta.*rho;
    [dr_sorted,orddr]=sort(dr,'descend');
    drmin=dr_sorted(NCLUST+1);
    NCLUST=0;
    for i=1:N
        if (dr(i)>drmin)
            NCLUST=NCLUST+1;
            cl(i)=NCLUST;%number of clusters
            icl(NCLUST)=i;%cluster centers
        end
    end
    %fprintf('NUMBER OF CLUSTERS: %i \n', NCLUST);
    %disp('Performing assignation')
    for i=1:N
        if (cl(ordrho(i))==-1)
            try
                if(nneigh(ordrho(i)) ~= 0) cl(ordrho(i))=cl(nneigh(ordrho(i))); end
            catch
            end
        end
    end
    cl=cl';
end


%     for i=1:size(X,1)
%         I = find(Constraints(i,:) == 0);
%         if(length(I) == 0)
%             A = Constraints(i,1);
%             B = Constraints(i,2);
%             C = Constraints(i,3);
%
%             dism(i,A) = 1;
%             dism(i,B) = 1;
%             dism(i,C) = 1;
%             dism(A,i) = 1;
%             dism(B,i) = 1;
%             dism(C,i) = 1;
%             Constraints(i,:) = 0;
%         end
%     end