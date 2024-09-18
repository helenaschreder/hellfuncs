%func to split checks
%% Split Checks
function [splitchecks]=hellsplitcheck(foodprice,tipntax)
bill_food=sum(foodprice);
bill_total=bill_food+tipntax;
rat=bill_total/bill_food;
splitchecks=foodprice*rat;

for i=1:length(splitchecks)
    disp([num2str(i) ': $' num2str(splitchecks(i))])
end
end
