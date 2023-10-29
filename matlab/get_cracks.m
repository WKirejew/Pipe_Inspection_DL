clear
close all
clc

%% IMPORT DATA

index = randi(124, 1);


pipe_img = imrotate( imread( "crack_img/crack_img_" + index + ".jpg"), -90);
pipe_roi = imrotate( imread( "cracked_pipe_roi/cracked_pipe_roi_" + index + ".jpg"), 0);


%% PROCESS DATA

th1 = 0.105;
th2 = 1;
th3 = 20;

img_in = pipe_img;

pipe_img_gr = rgb2gray( pipe_img );

img = rgb2hsv( pipe_img );
img = img(:, :, 1);
img = img > th1;

img = bwpropfilt( img, "Area", 1 );
SE = strel("square", 4);
img = imdilate( img, SE );

img_out = img * 0;


for i = 1:1:size(pipe_img, 1)
    for j = 1:1:size(pipe_img, 2)

        if img(i, j) == 1
            if pipe_roi(i, j) > th2
                img_out(i, j) = 1;
            end

        end

    end
end

img_out = ~img_out;
img_out = bwpropfilt( img_out, "Area", 1 );
img_out = ~img_out;

img_out = im2uint8( img_out );

for i = 1:1:size(pipe_img, 1)
    for j = 1:1:size(pipe_img, 2)
        if img_out(i, j) ~= 0
            img_out(i, j) = pipe_img_gr(i, j);
        end
    end
end


img_out = img_out > 120;

img = ~img_out;
img = bwpropfilt( img, "Area", 1 );
img = ~img_out;
SE = strel("square", 15);
img = imopen( img, SE );

img = bwpropfilt( img, "Area", 1 );

img_out = ~img_out - img;
img_out = ~img_out;
 
% SE = strel("square", 10);
% img_out = imclose( img_out, SE );

Amax = 1e12;
Amin = 200;


img_out = bwpropfilt( ~img_out, "Area", [Amin Amax] );
img_out = ~img_out;
% img_out = bwpropfilt( ~img_out, "Area", n );
% img_out = ~img_out;



%% DATA OUTPUT

figure;
subplot(1, 2, 1)
    imshow( img_in )
subplot(1, 2, 2)
    imshow( img_out )









