function [rgbImage_DBI] = Compute_Color_DMD_BGI(D,rows,cols)
    
    D_ = [D{1};D{2};D{3}];
    S1 = D_(:,1:(end-1)); 
    S2 = D_(:,2:end);
    [U, Si, V] = svd(S1,'econ');
    A_ = U'*S2*V;
    A = A_/Si;
    [Evec, Eval] = eig(A);
    Psi = ((S2*V)/Si)*Evec;
    Fourierfreq = abs(log(diag(Eval)));
    [~, index] = min(Fourierfreq);
    DMS = Psi(:,index);

    R = abs(reshape(DMS(1:rows*cols,1),rows,cols));
    G = abs(reshape(DMS(rows*cols+1:2*rows*cols,1),rows,cols));
    B = abs(reshape(DMS(2*rows*cols+1:end,:),rows,cols));

    rgbImage_DBI = cat(3, mat2gray(R),mat2gray(G),mat2gray(B));
            

end




