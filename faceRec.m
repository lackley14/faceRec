%% =============== Part 1: Loading Face Data =============
%  We start by first loading and visualizing the dataset.
%  The following code will load the dataset into the enviorment
%
dir = ''; %setting directory in images_to_data instead so this is unnecessary
subjects = [1,2,3,4,5,6,7,8,9,10];
%only chose 10 of subjects for test set 
% Train on 4x10 (glasses, normal, surprised, happy)
types = [
         %'centerlight';
         %'noglasses';
         %'sleepy';
         'glasses';
         'normal';
         'surprised'
         'happy';
         %'rightlight';
         %'wink';
         %'leftlight';
         %'sad'
         ];

[pixels,y,rows,cols] = images_to_data(subjects, types, dir);


colormap(gray);
fprintf(['Here is my training set of 40 photos.     ']);
pixels = double(pixels);
displayData1(pixels(:,1:40)');
                fprintf('Program paused. Press enter to continue.\n');
                pause;
                

%% =========== Part 2.0: Average Face and Normalized face ===================

fprintf(['This is what the average face looks like.    ']);
pixels = double(pixels);
mu = mean(pixels');
[sizeX, sizeY] = size(mu);
displayData(mu');
          
          fprintf('Program paused. Press enter to continue. \n');
          pause;
          
fprintf(['This is what one normalized face looks like.   ']);
oneFace = pixels(:,1);
norm= oneFace-mu';
displayData(norm);
          
          fprintf('Program paused. Press enter to continue. \n');
          pause;
          

%% =========== Part 2: PCA on Face Data: Eigenfaces  ===================
%  Run PCA and visualize the eigenvectors which are in this case eigenfaces
%  We display the first 36 eigenfaces.
%
fprintf(['\nRunning PCA on face dataset. \n']);


[U,S,W,D, index]= pca(pixels,y,40);


displayDataMult(U(:,1:36)');
                
                fprintf('Program paused. Press enter to continue.\n');
                pause;
                
%%=========== Part 3: weights  ===================
                
fprintf(['\Calculating the weights of all subjects. \n']);
U_norm = normalizeU(U);

allW= getAllWeights(pixels,y,subjects,U_norm, mu');
                    
hist(allW);
title("distribution of weights for 10 classes");
                    
fprintf('Program paused. Press enter to continue. \n');
pause;

plot(allW,subjects,'bx');
xlabel('weights'); ylabel('subject#');
                    
                    fprintf('Program paused. Press enter to continue. \n');
                    pause;
imagesc(imread("p.png"))
percentages = imread("percentages.gif");
                    
                    imagesc(percentages)
                    
                    
%============= Part 4: pre-classification ============
                    
fprintf(['Now we recognize a face.']);
fprintf(['Here is the trainingset again.']);
              
displayData1(pixels(:,1:40)');
             
             fprintf('Program paused. Press enter to continue.');
             pause;

cd crop2;
fprintf(['Here is a photo of subject01 that is not in the training set.\n']);
subject01 = imread("subject01centerlightgif.gif");
             imagesc(subject01);
             title(subject01);
cd ..;


fprintf(['These are the photos of subject01 in the training set.\n']);

displayData1(pixels(:,1:4)');
                          
                fprintf('Program paused. Press enter to continue.');
                pause;
             
             
fprintf(['Average of subject01.\n']);

av1 = pixels(:,1)+pixels(:,2)+pixels(:,3)+pixels(:,4);
av1=av1./4;
im1 = reshape(av1,80,80);
imagesc(im1);
title('average of subject1');
             
             fprintf('Program paused. Press enter to continue.');
             pause;
             
fprintf(['Here is a photo of subject01 that is not in the training set.\n']);
             imagesc(subject01);
             title(subject01);
             
             fprintf('Program paused. Press enter to continue.');
             pause;
             
sub1 = double(reshape(subject01,6400,1));

[sub1weights]=getWeights(U_norm,sub1,mu');
                         
fprintf(['The weights for the new photo are calculated. Known subject01 weights in blue. New weights in red.\n']);
                         
plot(sub1weights,'rx',allW(:,1),'bo');
                         

            fprintf('Program paused. Press enter to continue.');
            pause;

fprintf(['Now add the weights for a different subject to the graph.\n']);
                         plot(sub1weights,'rx',allW(:,1),'bo',allW(:,5),'go');

            fprintf('Program paused. Press enter to continue.');
            pause;

fprintf(['Subject01 looks like the 11th eigenface.\n']);
            eig11=U(:,11);
            imagesc(reshape(eig11,80,80));
                          
            fprintf('Program paused. Press enter to continue.');
            pause;

%============= Part 5: classification ============
                          
[class,E]=euclidian(sub1weights,allW,subjects);

fprintf('Classified as ');
                         class
                          
plot(subjects,E,'o');
                         
%============= Part 6: accuracy =========
                         

[classes,accuracy,mins,cMins,iMins]=classifyM(U_norm,mu',allW,subjects);
accuracy
                                       
                                       
%============= Part 7: learning =========
                                       
