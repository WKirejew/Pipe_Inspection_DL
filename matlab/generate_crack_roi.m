clear
close all
clc


dataset = 124;
start = 1;

errors = [];

exception = [];

for index = start:1:dataset

    fprintf("Index <strong>%d</strong> out of <strong>%d</strong>\n", index, dataset);
    
    try
        pipe_img = imrotate( imread( "crack_img/crack_img_" + index + ".jpg"), -90);
        pipe_roi = imrotate( imread( "cracked_pipe_roi/cracked_pipe_roi_" + index + ".jpg"), 0);
    catch
    end
    
    try
        img_out = get_cracks_fx( pipe_img, pipe_roi );

        file_name = "cracks_roi/crack_roi_" + index + ".jpg";
        imwrite( img_out , file_name )

    catch
        fprintf("  -> Error!\n")
        errors = [errors, index];
    end



end

fprintf("\n<strong>Error indexes: </strong>\n")
fprintf("  " + mat2str( errors ) + "\n")

clear dataset file_name img_in img_out index path
save("error_indexes.mat")