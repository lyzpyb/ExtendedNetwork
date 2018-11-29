for i=1:24
    nodes.id(i+24)=i+24;
    nodes.xco(i+24)=nodes.xco(i);
    nodes.yco(i+24)=nodes.yco(i)+500000;
end

for i=1:24
    nodes.id(i+48)=i+48;
    nodes.xco(i+48)=nodes.xco(i);
    nodes.yco(i+48)=nodes.yco(i)+1000000;
end

for i=72+1:72+size(s_links,1)/2
    nodes.id(i)=i;
    nodes.xco(i)=30000;
    nodes.yco(i)=100000+(i-72)*50000;
end