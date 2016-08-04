for p=1:3
if p==1
str1='list11.txt';
elseif p==2
str1='list22.txt';
else
str1='list33.txt';
end
fid=fopen(str1,'r');
patc=0;
str=fgetl(fid);
while ischar(str)
     patc=patc+1;
     l=size(str,2);
     t1=[];
     t1=strfind(str,'/');
     if(size(t1,2)>0)
         if(t1(1)==l)
             pattern{patc}=str2num(str(1:l-1));
         else
             y=str2num(str(1:t1(1)-1));
             x=str2num(str((t1(1)+1):l));
             pattern{patc}(1:x)=y;
         end
     else
         index=1;
         i=1;
         while(i<=l)
           if(str(i)=='-')
             y=str2num(str(i:i+1));
             pattern{patc}(index)=y;
             index=index+1;
             i=i+1;
           elseif(str(i)==',')
             y=pattern{patc}(index-1);
             d=i;
             while(d<=l&&~(str(d)=='.'))
                 d=d+1;
             end
             if(d==l+1)
                 x=str2num(str(i+1:l));
             else
                 x=str2num(str(i+1:d-1));
             end    
             pattern{patc}(index:index+(x-1)-1)=y;
             index=index+x-1;
             i=d;
           elseif(str(i)=='.')
             d=i+1;
             while(d<=l&&~(str(d)=='.'))
                 d=d+1;
             end
             if(d==l+1)
                 x=str2num(str(i+1:l));
             else
                 x=str2num(str(i+1:d-1));
             end    
                 pattern{patc}(index)=x;
                 index=index+1;
                 i=d;
           elseif(str(i)=='(')
              d=i;
              while(d<=l&&~(str(d)==','))
                  d=d+1;
              end
                  y=str2num(str(i+1,d-1));
                  i=d;
              while(d<=l&&~(str(d)==')'))
                  d=d+1;
              end
              if(d==l+1)
                 x=str2num(str(i+1:l));
              else
                 x=str2num(str(i+1,d-1));
              end
                 pattern{patc}(index:index+(x-1))=y;
                 index=index+x;
                 i=d;
           else
                pattern{patc}(index)=str2num(str(i));
                index=index+1;
           end
           i=i+1;
         end
     end     
str = fgetl(fid);
end
if p==1
str1='code11.txt';
elseif p==2
str1='code22.txt';
else
str1='code33.txt';
end

patc=0;
fid=fopen(str1,'r');
str=fgetl(fid);
while ischar(str)
    patc=patc+1;
    index=1;
    for i=1:size(str,2)
    code{patc}(index)=str2num(str(i));
    index=index+1;
    end
    str=fgetl(fid);
end
fclose(fid);
if p==1
str1='comp11.txt';
elseif p==2
str1='comp22.txt';
else
str1='comp33.txt';
end
mat=[];
fid=fopen(str1,'r');
str=fgetl(fid);
l=size(str,2);
while ischar(str)
    for i=1:l
    mat(i)=str2num(str(i));
    end
    str=fgetl(fid);
    l=size(str,2);
end
fclose(fid);
i=1;
index=1;
a1=[];
while(i<=size(mat,2))
    a1=[a1 mat(i)];
    temppat=[];
    j=1;
    while (j<=size(code,2))
        if(size(a1,2)==size(code{j},2)&&all(a1==code{j}))
            temppat=pattern{j};
            j=size(code,2)+1;
        else
            j=j+1;
        end
    end
    if(size(temppat,2)~=0)
        x=size(temppat,2);
        matrix(index:index+x-1)=temppat;
        index=index+x;
        a1=[];
    end
    i=i+1;
end
im=matrix;
t=0;
he=sqrt(size(im,2))/8;
sum=16;
newd=[];
  for po=1:he
    for qo=1:he
            for d=2:sum
             c=rem(d,2);  
                for i=1:8
                    for j=1:8
                        if((i+j)==d)
                            t=t+1;
                            if(c==0)
                            newd{po,qo}(j,d-j)=(im(t))*QUANTIZATION_FACTOR(j,d-j);
                            else          
                            newd{po,qo}(d-j,j)=(im(t))*QUANTIZATION_FACTOR(j,d-j);
                            end
                         end    
                     end
                 end
            end
    end
 end

for po=1:he
    for qo=1:he
        newd{po,qo}=idct2(newd{po,qo});
        newd{po,qo}=round(newd{po,qo}); 
   end   
end

newdm=uint8(cell2mat(newd));

if p==1
matrix11=newdm;
elseif p==2
matrix22=newdm;
else
matrix33=newdm;
end
clearvars -except list_11 list_22 list_33 matrix11 matrix22 matrix33  matrix QUANTIZATION_FACTOR y_image cb_image cr_image original_img y_combined_image
end
 ima(:,:,1)=matrix11;
 ima(:,:,2)=matrix22;
 ima(:,:,3)=matrix33;
 rgbimage=ycbcr2rgb(ima);