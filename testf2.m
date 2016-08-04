clearvars -except list_11 list_22 list_33 comp QUANTIZATION_FACTOR y_image cb_image cr_image original_img y_combined_image
for p=1:3
if p==1
a =list_11;
elseif p==2
    a =list_22;
else
    a =list_33;
end
k=2;
L=[];
c=[];
C=[];
COUNT=[];
ccount=2;
c{1}=unique(a);
C{1}=c{1};
L{1}=C{1};
COUNT{1}=histc(a,c{1});
minsup=50;
len=size(c{1},2);
s=1;
  while((size(L{ccount-1},2)~=0)&&k<=6)
  count=1;
  c=[];
  for i=1:(size(a,2)-k+1)
      j=i+k-1;
        c{count}=a(i:j);
        count=count+1;
  end
  b=[];
 b=cellfun(@(x)(mat2str(x)),c,'uniformoutput',false);
 ia=[];
 x=[];
[x,ia,idx]=unique(b);
ex=[];
ex= histc(idx, 1:size(x,2));
un=[];
for u=1:size(ia,1)
    un{u}=c{ia(u)};
end
C{ccount}=un;
count=1;
c=[];
temp=[];
for i=1:size(ex,1)
if(ex(i,1)>=minsup)
    c{count}=C{ccount}{i};
    temp(count)=ex(i,1);
    count=count+1;
end
end
L{ccount}=c;
COUNT{ccount}=temp;
ccount=ccount+1;
k=k+1;
s=s+1;
  end
%for j=1:size(L{2},2)
%     i=1;
%    while (i<=size(L{1},2))
%        if((all(L{1}(i)==L{2}{j}(1))&&COUNT{1}(i)==COUNT{2}(j))||(all(L{1}(i)==L{2}{j}(2))&&COUNT{1}(i)==COUNT{2}(j)))
%            L{1}(i)=[];
% 
%            COUNT{1}(i)=[];
%        else
%        i=i+1;
%        end
%    end
%end
for k=3:s
for j=1:size(L{k},2)
     i=1;
    while (i<=size(L{k-1},2))
        if(((all(L{k-1}{i}(1:size(L{k-1}{i},2))==L{k}{j}(2:k)))&&COUNT{k-1}(i)==COUNT{k}(j))||((all(L{k-1}{i}(1:size(L{k-1}{i},2))==L{k}{j}(1:(k-1))))&&COUNT{k-1}(i)==COUNT{k}(j)))
            L{k-1}(i)=[];
            COUNT{k-1}(i)=[];
        else
        i=i+1;
        end
    end
end
end
patc=1;
pat=[];
patlen=[];
for k=s:-1:2
    j=1;
    while(j<=size(L{k},2))
        pat{patc}=L{k}{j};
        patlen(patc)=COUNT{k}(j);
        j=j+1;
        patc=patc+1;
    end
end
j=1;
while(j<=size(L{1},2))
    pat{patc}=L{1}(j);
    patlen(patc)=COUNT{1}(j);
    j=j+1;
    patc=patc+1;
end
t=a;
newpat=[];
patc=0;
newlen=[];
for i=1:size(pat,2)
    t1=[];
t1=strfind(t,pat{i});
if(size(t1,2)>0)
        patc=patc+1;
    newlen(patc)=0;
    newpat{patc}=pat{i};
end
while (size(t1,2)>0)
    newlen(patc)=newlen(patc)+1;
        x=size(pat{i},2);
        t(t1(1):t1(1)+x-1)=2000;
        t1=[];
        t1=strfind(t,pat{i});
end 
end
l=sum(newlen);
prob=[];
for i=1:size(newpat,2)
    prob(i)=newlen(i)/l;
end
[dict,avglen]=huffmandict(newpat,prob);
maxsize = 0;
dictlen = size(dict,1);
for i = 1 : dictlen
    tempSize = size(dict{i,2},2);
    if (tempSize > maxsize)
        maxsize = tempSize;
    end
end
for i=1:(maxsize*size(a,2))
    comp(i)=-1;
end
t=a;
for i=1:size(newpat,2)
    t1=[];
t1=strfind(t,newpat{i});
while (size(t1,2)>0)
    x=size(newpat{i},2);
    zz=t1(1);
     t(zz:zz+x-1)=2000;
     x=size(dict{i,2},2);
     z=(((t1(1)-1)*maxsize)+1);
     comp(z:(z+x-1))=dict{i,2};
     t1=[];
        t1=strfind(t,newpat{i});
end
end
i=1;
zz=size(comp,2);
while i<=(zz)
if(comp(i)==-1)
   comp(i)=[];
        zz=zz-1;
    else
        i=i+1;
 end
end
if p==1
str1='list11.txt';
elseif p==2
str1='list22.txt';
else
str1='list33.txt';
end
fid=fopen(str1,'w');
for j=1:size(newpat,2)
count=1;
a=newpat{j}(1);
for i=2:size(newpat{j},2)
    if(newpat{j}(i)==a)
            count=count+1;
    else
        if(count>=2&&(a/10>=1||a/10<=-1))
        fprintf(fid,'(%d,%d)',a,count);
        elseif(count>=3&&~(a/10>=1||a/10<=-1))
         fprintf(fid,'%d,%d.',a,count);
        else
            if(count==1&&(a/10>=1||a/10<=-1))
                fprintf(fid,'.%d.',a);
            else
            while(count>0)
        fprintf(fid,'%d',a);
        count=count-1;
            end
            end
        end
        a=newpat{j}(i);
        count=1;
    end
end
   if(count==size(newpat{j},2)&&count==1&&(a/10>=1||a/10<=-1))
        fprintf(fid,'%d/',a);
   elseif(count==size(newpat{j},2)&&count==1&&~(a/10>=1||a/10<=-1))
        fprintf(fid,'%d',a);
   elseif(count==size(newpat{j},2)&&~(a/10>=1||a/10<=-1)&&count>2)
   fprintf(fid,'%d/%d',a,count);
   elseif(count==size(newpat{j},2)&&(a/10>=1||a/10<=-1))
   fprintf(fid,'%d/%d',a,count);
   elseif(count>=3&&~(a/10>=1||a/10<=-1))
        fprintf(fid,'%d,%d',a,count);
   elseif(count>=2&&(a/10>=1||a/10<=-1))
       fprintf(fid,'(%d,%d',a,count);
   else
            if(count==1&&(a/10>=1||a/10<=-1))
                fprintf(fid,'.%d',a);
            else
            while(count>0)
        fprintf(fid,'%d',a);
        count=count-1;
            end
            end
   end
   fprintf(fid,'\n');
end
fclose(fid);
s=size(comp,2);
s=s/8;
s=s/1024;
if p==1
str1='comp11.txt';
s11=s;
elseif p==2
str1='comp22.txt';
s22=s;
else
str1='comp33.txt';
s33=s;
end
fid=fopen(str1,'w');
for i=1:size(comp,2)
    fprintf(fid,'%d',comp(i));
end
fclose(fid);
c1=0;
for i=1:size(dict,1)
c1=c1+size(dict{i,2},2);
c1=c1+8;
end
c1=c1-8;
c1=c1/8;
c1=c1/1024;
if p==1
str1='code11.txt';
c11=c1;
elseif p==2
str1='code22.txt';
c22=c1;
else
str1='code33.txt';
c33=c1;
end
fid=fopen(str1,'w');
for i=1:size(dict,1)
    for j=1:size(dict{i,2},2)
    fprintf(fid,'%d',dict{i,2}(j));
    end
    fprintf(fid,'\n');
end
fclose(fid);   
clearvars -except list_11 list_22 list_33 QUANTIZATION_FACTOR y_image cb_image cr_image original_img y_combined_image c11 c22 c33 s11 s22 s33
end
codesize=c11+c22+c33
compsize=s11+s22+s33