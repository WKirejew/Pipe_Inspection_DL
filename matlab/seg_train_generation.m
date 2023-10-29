clear
close all
clc

input_file = "src/crack_roi_";
output_file = "train/masked_roi_";
file_format = ".png";

dataset = 124;

% index = 51;

for index = 1:1:dataset
    
    fprintf("Index: %d \n", index)
    
    if index ~= 52 && index ~= 53 && index ~= 54
        file = input_file + index + file_format;
        img = imread( file );
        img = img > 0.2;

        img0 = img;

        img = bwpropfilt( ~img, "Area", 1 );

        img = img * 1;
        out = img * 0;

        for i = 1:1:size(img, 1)
            for j = 1:1:size(img, 2)
                if img0(i, j) == 1
                   out(i, j) = 1;
                else
                    if img(i, j) == 1
                        out(i, j) = 1;
                    end
                end
            end
        end

        file = output_file + index + file_format;

        imwrite( out , file )
    end

    
end




