 QUANTIZATION_FACTOR =[16 11 10 16 24 40 51 61;
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56;
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 35 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99];
% QUANTIZATION_FACTOR =[16 16 16 16 16 16 16 16;
%                         16 16 16 16 16 16 16 16;
%                         16 16 16 16 16 16 16 16;
%                         16 16 16 16 16 16 16 16;
%                         16 16 16 16 16 16 16 16;
%                         16 16 16 16 16 16 16 16;
%                         16 16 16 16 16 16 16 16;
%                         16 16 16 16 16 16 16 16];
CELL_SIZE = 8; %greater than 4
 
original_img = imread('lena128.bmp');
 

 
%%% MAPPER RGB -> YCbCr
ycbcr_img = rgb2ycbcr(original_img);
 
y_image = ycbcr_img(:, :, 1);
cb_image = ycbcr_img(:, :, 2);
cr_image = ycbcr_img(:, :, 3);
 

repeat_height = size(y_image, 1)/CELL_SIZE;
repeat_width = size(y_image, 2)/CELL_SIZE;
repeat_height_mat = repmat(CELL_SIZE, [1 repeat_height]);
repeat_width_mat = repmat(CELL_SIZE, [1 repeat_width]);
y_sub_image = mat2cell(y_image, repeat_width_mat, repeat_height_mat);
cb_sub_image = mat2cell(cb_image, repeat_width_mat, repeat_height_mat);
cr_sub_image = mat2cell(cr_image, repeat_width_mat, repeat_height_mat);
 
%DCT TRANSFORM
for i=1:repeat_height
for j=1:repeat_width
y_sub_image{i, j} = dct2(y_sub_image{i, j});
cb_sub_image{i, j} = dct2(cb_sub_image{i, j});
cr_sub_image{i, j} = dct2(cr_sub_image{i, j});
end
end

show=y_sub_image{1,1};

%%Quanitzation
for i=1:repeat_height
for j=1:repeat_width
    for p=1:8
        for q=1:8
y_sub_image{i, j}(p,q) = round(y_sub_image{i, j}(p,q) / QUANTIZATION_FACTOR(p,q));
cb_sub_image{i, j}(p,q) = round(cb_sub_image{i, j}(p,q) / QUANTIZATION_FACTOR(p,q));
cr_sub_image{i, j}(p,q) = round(cr_sub_image{i, j}(p,q) / QUANTIZATION_FACTOR(p,q));
        end
    end
end
end
 
%%Combining all cell together
y_combined_image=cell2mat(y_sub_image);
cb_combined_image=cell2mat(cb_sub_image);
cr_combined_image=cell2mat(cr_sub_image);

%%Now Storing values of every sub image into array..so that we can mine
%%patterns

in=1;
for i=1:size(y_combined_image,1)
    for j=1:size(y_combined_image,2)
        list_1(in)=y_combined_image(i,j);
        list_2(in)=cb_combined_image(i,j);
        list_3(in)=cr_combined_image(i,j);
        in=in+1;
    end
end

%%now passing the elements of the every block in zigzag pattern to an
%%pattern

ind=0;

for i=1:repeat_height
   for j=1:repeat_width
        len=size(y_sub_image{i,j});
        sum=len(2)+len(1);
        for d=2:sum
            c=rem(d,2);
            for ii=1:len(1)
                for jj=1:len(2)
                    if((ii+jj)==d)
                        ind=ind+1;
                        if(c==0)
                            list_11(ind)=y_sub_image{i,j}(jj,d-jj);
                            list_22(ind)=cb_sub_image{i,j}(jj,d-jj);
                            list_33(ind)=cr_sub_image{i,j}(jj,d-jj);
                        else
                            list_11(ind)=y_sub_image{i,j}(d-jj,jj);
                            list_22(ind)=cb_sub_image{i,j}(d-jj,jj);
                            list_33(ind)=cr_sub_image{i,j}(d-jj,jj);
                        end
                    end
                end
            end
        end
    end
end


                        
                        
            
            
        
        
        
        
        
    
    
    
    