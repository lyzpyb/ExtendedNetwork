function Demand = findDemand(o,d)
    global OD;
    if OD(find(OD(:,1)==o & OD(:,2)==d),3)~=0
        Demand = OD(find(OD(:,1)==o & OD(:,2)==d),3);
    else Demand = 0;
    end
end

