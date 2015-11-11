function [ Test, Train ] = GetSets( Cases, percentage )
        num_casos=size(Cases,1);
        n=ceil(num_casos*(percentage/100));
        %train
        Train_idx=randperm(num_casos);
        Train_idx=Train_idx(1:n);
        Train=Cases(Train_idx,:);
        %test
        Test=Cases;
        Test(Train_idx,:)=[];       
end