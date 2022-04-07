function [A,B,x] = gepp(A, B, n)
    for j = 1:n
           %finding pivot
            m = j;
            pivot = abs(A(j, j));
                for i = j+1:n
                    if abs(A(i, j)) > pivot
                        pivot = abs(A(i, j));
                        m = i;
                    end
                end
             if pivot == 0
                disp(pivot);
                disp('Iimproper Matrix');
                return
              end
              if m ~= j
                 %swaping the rows if needed
                 A([m, j],:) = A([j, m],:);
                 B([m, j]) = B([j, m]);
               end
               for i = j+1:n
                   r = A(i, j)/A(j,j);
                   %if r = 0 the system is singular and there is no need to
                   %continue
                   if r ~= 0
                      %changing the main array A
                       for locj = j+1:n
                           A(i, locj) = A(i, locj) - r*A(j, locj);
                        end
                        %and the B array aswell
                        B(i) = B(i) - r*B(j);
                    end
               end
    end
               %now finally we can obtain the results
               %Xn value is rather obvious
               x(n) = B(n)/A(n, n);
            for i = n-1:-1:1
                Q = 0;
                for j = i+1:n
                    Q = Q + A(i, j)*x(j);
                end
                x(i) = (B(i) - Q)/A(i,i);
            end
        end