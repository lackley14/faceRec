function [classes,accuracy,mins,cMins,iMins,pics] = classifyM(U,avgFace,allW,subjects)
%given a matrix of pictures (1 pic as a col in pics) and the actual classes these pictures are in, return a vector of classifications and error

dir = ''; %set in images_to_data for now
types = [
         'centerlight';
         'noglasses';
         'sleepy';
         %'glasses';
         %'normal';
         %'surprised'
         %'happy';
         'rightlight';
         'wink';
         'leftlight';
         'sad'
         ];

[pics]=images_to_data(subjects,types,dir);


y=[];
for i = 1:size(subjects,2)
    for j = 1:size(types)
        y = [y,i];
    end
end


correct = 0;
classes = [];
mins = [];
cMins = [];
iMins =[];

for i = 1:size(pics,2)
    pic = pics(:,i);
    %pic = pics(:,i)-avgFace;
    weights = getWeights(U,pic,avgFace);
    [class,e]=euclidianM(weights,allW,subjects);
    mins = [mins,e(class)];
    classes = [classes,class];
    if class == y(i)
        correct++;
        cMins = [cMins,e(class)];
    else
        iMins = [iMins,e(class)];
    end
end

accuracy = correct/size(pics,2);





end
