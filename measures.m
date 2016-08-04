a=original_img;
b=rgbimage;
[psnr,mse]=measerr(a,b)
mssimr=ssim_index(a(:,:,1),b(:,:,1))
mssimg=ssim_index(a(:,:,1),b(:,:,1))
mssimb=ssim_index(a(:,:,1),b(:,:,1))