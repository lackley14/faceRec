function [pixels,y,rows,cols] = images_to_data(subjects,types,dir)

%gotta make this return the original size of the pictures in rows and cols and then return the boolean bol as 0 or 1 to decide if all the pictures in the set are of the same size which is important because if they aren't there is a problem with running pca on the data (possibly actually not entirly sure on this but I assume)



%paramater subjects is which numberings of subjects you want to use
%parameter types is the ending after subtec (i.e. glasses)
%dir is the directory that contains the photos to be read

cd crop2/;

%=======creates a variable files of all the files

[a, b] = size(types);
[c, d] = size(subjects);
m = size(subjects) * a;

fileGroups = cell(1);
for i=1:d
    files = cell(1);
    for j=1:a
        %file = sprintf('%ssubject%02d.%s.gif', dir, i, strtrim(types(j,:)));
        file = sprintf('%ssubject%02d%sgif.gif',dir,i,strtrim(types(j,:)));
        files{j} = file;
    end
fileGroups{i} = files;
end

%cell is like an array
%sprintf loads the file


%======== takes this variable files and reads the images into pixels matrix



[g,m] = size(fileGroups);

pixels = [,];
y=[];
count = 1;
for i=1:m
    entry = fileGroups{i};
    for j=1:a
        name = sprintf("%s", entry{j});
        image = imread(name);
        [rows,cols,u]=size(image);;
        imEdit = reshape(image,rows*cols,1);
        pixels = [pixels,imEdit];
        y=[y,i];
    end
end


cd ..;
