function QRMethod(isShift) %isShift takes either 'Y' when it should use the
                           %algorithm with shifts or 'N' if not
    A = [1 2 3 4 5; 2 1 2 3 4; 3 2 1 2 3; 4 3 2 1 4; 5 4 3 4 1];
    function eigenVal = QRNoShifts(A, tol, imax)
    % I = [1 0 0 0 0; 0 1 0 0 0; 0 0 1 0 0; 0 0 0 1 0; 0 0 0 0 1];
    j = 1;
%     n = size(A,1);
%     eigenVal = zeros(n,1);
    while j <= imax && max(max(A-diag(diag(A)))) > tol
            [Q,R] = qrmgs(A);
            A = R*Q;
            j = j + 1;
    end
    disp(j);
    eigenVal = diag(A);
    disp(eigenVal);
    end
    function eigenvalues = QRShifts(Q,tol,imax)
        %tol - tolerance (upper bound) for nulled elements
        %max - max number of iterations to calculate an eigenvalue
        n = size(Q,1);
        eigenvalues = diag(ones(n));
        INITIALsubmatrix = Q; %initial matrix
        for k = n:-1:2
            DK=INITIALsubmatrix; %initial matrix to calculate a single eigenvalue
            i=0;
            while i<=imax && max(abs(DK(k,1:k-1))) > tol
                DD = DK(k-1:k,k-1:k); %2x2 bottom right corner submatrix
                [ev1,ev2] = quadpolynroots(1,-(DD(1,1) + DD(2,2)),DD(2,2) * DD(1,1) - DD(2,1)*DD(1,2));
                 if abs(ev1-DD(2,2)) < abs(ev2-DD(2,2))
                     shift=ev1; %shift - DD eigenvalue closest to DK(k,k)
                 else
                     shift=ev2;
                 end
                 DP=DK-eye(k)*shift; %shifted matrix
                 [Q1,R1] = qrmgs(DP);
                 DK = R1*Q1 + eye(k)*shift; %transformed matrix
                 i = i+1;
                 if i > imax
                     error('imax exceeded, program terminated');
                 end
                 eigenvalues(k) = DK(k,k);
                 if k>2
                     INITIALsubmatrix = DK(1:k-1,1:k-1); %matrix deflation
                 else
                     eigenvalues(1)=DK(1,1); %last eigenvalue
                 end
                 disp(DK);
            end
        end
        disp(k);
        disp(eigenvalues);
    end
if isShift == 'N'
    QRNoShifts(A,1e-6,10000);
elseif isShift == 'Y'
    QRShifts(A,1e-6,10000);
end
end