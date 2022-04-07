function [ x1, x2 ] = quadpolynroots( a,b,c )
%quadpolynroots Funkcja zwracajaca pierwistki wielomianu stopnia 2
%   a,b,c - wspolczynniki wielomianu
    l1 = -b + sqrt(b*b - 4*a*c);
    l2 = -b - sqrt(b*b - 4*a*c);
    %wybieramy licznik o wiekszym module
    if abs(l1) > abs(l2)
       licznik = l1;
    else
        licznik = l2;
    end
    x1 = licznik/(2*a);
    %drugi pierwiastek obliczmy ze wzorów Viete'a
    x2 = ((-b)/a) - x1;
end