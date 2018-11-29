%clear the work space
clear
%clear the command window
clc
%close all windows
close all

matrix = csvread('SiouxFalls_OD.csv',1,1);
load('links.mat');
linksCopy=links;%��һ���������
linksCopy.link_type(:)=1;
linksCopy.link_mapping(1:size(links,1))=1:size(links,1);
%�ڶ����������
for i=size(links,1)+1:size(links,1)*2
    linksCopy.id(i)=i;
    linksCopy.link_o(i)=linksCopy.link_o(i-size(links,1))+24;
    linksCopy.link_d(i)=linksCopy.link_d(i-size(links,1))+24;
    linksCopy.link_type(i)=2;
    linksCopy.link_mapping(i)=i-size(links,1);
end

%�������������
for i=size(links,1)*2+1:size(links,1)*3
    linksCopy.id(i)=i;
    linksCopy.link_o(i)=linksCopy.link_o(i-size(links,1))+24;
    linksCopy.link_d(i)=linksCopy.link_d(i-size(links,1))+24;
    linksCopy.link_type(i)=3;
    linksCopy.link_mapping(i)=i-size(links,1)*2;
end

%�ҳ����з����OD��ϵ
global OD;
for i=1:size(matrix,1)
    for j=1:size(matrix,1)
        if matrix(i,j)~=0
            OD((i-1)*24+j,1)=i;
            OD((i-1)*24+j,2)=j;
            OD((i-1)*24+j,3)=matrix(i,j);
        end
    end
end
OD(all(OD==0,2),:)=[]; 
OD = unique(OD(:,:),'row');

%174������OD��ϵ��30%
rng(1);%������������ɣ�����Ҫ��ע�͵�
n = randperm(size(OD,1),174);
for i=1:174
        driverOD_1(i,1)=OD(n(i),1);
        driverOD_1(i,2)=OD(n(i),2);
        driverOD_1(i,3)=OD(n(i),3);
        driverOD_1(i,4)=1;
end

rng(2);%������������ɣ�����Ҫ��ע�͵�
riderOD_1_1 = driverOD_1(randperm(size(driverOD_1,1),87),:);%rider_ODȡdriverOD��15%
%�ٴ����е�OD��ȡ15%��87��                                        
for i=1:87
        riderOD_1_2(i,1)=OD(n(i),1);
        riderOD_1_2(i,2)=OD(n(i),2);
        riderOD_1_2(i,3)=OD(n(i),3);
        riderOD_1_2(i,4)=1;
end
riderOD_1 = [riderOD_1_1; riderOD_1_2]; %combine

driverOD_2(:,1:2) = driverOD_1(:,1:2)+24;%�ڶ���driverOD
driverOD_2(:,3)=driverOD_1(:,3);
driverOD_2(:,4)=2;
driverOD_3(:,1:2) = driverOD_1(:,1:2)+48;%������driverOD
driverOD_3(:,3)=driverOD_1(:,3);
driverOD_3(:,4)=3;

riderOD_2(:,1:2) = riderOD_1(:,1:2)+24;%�ڶ���riderOD
riderOD_2(:,3)=riderOD_1(:,3);
riderOD_2(:,4)=3;
riderOD_3(:,1:2) = riderOD_1(:,1:2)+48;%�ڶ���riderOD
riderOD_3(:,3)=riderOD_1(:,3);
riderOD_3(:,4)=3;

%pickup��dropup link�Ĵ���������Ϊ��
%pick_up: ��һ���riderO���ڶ����riderO
%drop_off: �ڶ����riderD���������riderD
for i=1:size(driverOD_1,1)
        pickup_links_origin(i,1)=riderOD_1(i,1);
        pickup_links_origin(i,2)=riderOD_1(i,1)+24;
        dropoff_links_origin(i,1)=riderOD_1(i,2)+24;
        dropoff_links_origin(i,2)=riderOD_1(i,2)+24+24;
end

%ȥ��pickup_links���ظ���
pickup_links=unique(pickup_links_origin(:,1:2),'row');
for i=229:229+size(pickup_links,1)-1
    linksCopy.id(i)=i;
    linksCopy.link_o(i)=pickup_links(i-228,1);
    linksCopy.link_d(i)=pickup_links(i-228,2);
    linksCopy.link_type(i)=4;
    linksCopy.link_mapping(i)=0;
end

%ȥ��dropoff_links���ظ���
dropoff_links=unique(dropoff_links_origin(:,1:2),'row');
for i=(229+size(pickup_links,1)):(229+size(pickup_links,1)+size(dropoff_links,1)-1)
    linksCopy.id(i)=i;
    linksCopy.link_o(i)=dropoff_links(i-228-size(pickup_links,1),1);
    linksCopy.link_d(i)=dropoff_links(i-228-size(pickup_links,1),2);
    linksCopy.link_type(i)=4;
    linksCopy.link_mapping(i)=0;
end

driverOD_1_unique = unique(driverOD_1(:,1));
for i=1:size(driverOD_1_unique,1)
    s_links(i*2-1,1)=72+i;
    s_links(i*2-1,2)=driverOD_1_unique(i);
    s_links(i*2,1)=s_links(i*2-1,1);
    s_links(i*2,2)=s_links(i*2-1,2)+48;
end

for i=size(linksCopy.id,1)+1:size(linksCopy.id,1)+size(s_links,1)
    linksCopy.id(i)=i;
    linksCopy.link_o(i)=s_links(i-276,1);
    linksCopy.link_d(i)=s_links(i-276,2);
    linksCopy.link_type(i)=5;
    linksCopy.link_mapping(i)=0;
end

%���յ�driverOD����s��driverOD_1��Destination
for i=1:size(driverOD_1,1)
    driverOD(i,1) = s_links(driverOD_1(i,1)*2-1,1);
    driverOD(i,2) = driverOD_3(i,2);
    %ÿһ��driverOD��Demand=D(driverOD_O,pick_up_O)+D(riderOD)+D(dropoff_D,driverOD_D)
    Demand = findDemand(driverOD_1(i,1),pickup_links_origin(i,1))+findDemand(riderOD_2(i,1)-24,riderOD_2(i,2)-24)+findDemand(dropoff_links_origin(i,2)-48,driverOD_3(i,2)-48);
    if Demand ~=0
        driverOD(i,3)=Demand;
    end
end

ExtendedOD = array2table(driverOD,...
    'VariableNames',{'Origin','Destination','Demand'});

riderOD = riderOD_2;

linksCopy_order = sortrows(linksCopy,'link_o','ascend');
for i = 1:max(linksCopy_order.link_o)
    for j = 1:size(linksCopy_order.link_o)
        if(linksCopy_order.link_o(j) == i)
            linksCopy_order.point(i)=j;
            break;
        end
    end
end

writetable(linksCopy_order,'linksCopy_order.xlsx');
writetable(ExtendedOD,'ExtendedOD.xlsx');