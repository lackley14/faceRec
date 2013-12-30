function [h, display_array] = displayData(U,r)
%displays the column vectors of U as pictures

[m,n] = size(U);
width = m^(1/2);
X = [];

width = 0;

for i = 1:n

    vec= U(:,i);
    [a,b]=size(vec);
    im = reshape(vec, width,width);

    X = [X,im];

end

z = [X(:,width*m);








end
