%------------ Applying K-means Algortihm in Data Clustering --------------%
%---------------- By Y.YELLA REDDY, BTech IIT BHUBANESWAR ----------------%
clc;
%--------------- Initializing the dataset of flowers ---------------------%
load C:\Users\Alumno\Downloads\irisdataset.txt 
DataSet=irisdataset;
Dim=size(DataSet);
%----------------------- Selecting 3 random centres ----------------------% 
Selection=rand(1,3);
Selection=Selection*Dim(1,1);
Selection=ceil(Selection); %Selecting the row number.
%--------------------------- 3 random centres ----------------------------%
Centre1=DataSet(Selection(1),:);
Centre2=DataSet(Selection(2),:);
Centre3=DataSet(Selection(3),:);
n=input('No Of Iterations : ')
%----------------------- Partitional Algorithm ---------------------------%
%-------------------------- K means Algorithm ----------------------------%
for j=1:1:n
   
    count1=0;
    Mean1=zeros(1,4);
    count2=0;
    group1=[];
    Mean2=zeros(1,4);
    group2=[];
    count3=0;
    group3=[];
    Mean3=zeros(1,4);
%Finding the minimum distance
    for i=1:1:Dim(1,1)
        
        %distancia1 = (DataSet(1,1) - Centre1(1,1))^2 + (DataSet(1,2) - Centre1(1,2))^2 + (DataSet(1,3) - Centre1(1,3))^2 + (DataSet(1,4) - Centre1(1,4))^2;
        distancia1 = (DataSet(i,1) - Centre1(1,1))^2 + (DataSet(i,2) - Centre1(1,2))^2 + (DataSet(i,3) - Centre1(1,3))^2 + (DataSet(i,4) - Centre1(1,4))^2;
        distancia2 = (DataSet(i,1) - Centre2(1,1))^2 + (DataSet(i,2) - Centre2(1,2))^2 + (DataSet(i,3) - Centre2(1,3))^2 + (DataSet(i,4) - Centre2(1,4))^2;
        distancia3 = (DataSet(i,1) - Centre3(1,1))^2 + (DataSet(i,2) - Centre3(1,2))^2 + (DataSet(i,3) - Centre3(1,3))^2 + (DataSet(i,4) - Centre3(1,4))^2;
        
        LessDist=[distancia1 distancia2 distancia3];
        Minimum = min(LessDist);
        %Finding the new centre
        %count1,2 y 3 lleva el conteo de elementos para cada cluster
        %Mean lleva la suma de elementos para calcular la media para los
        %centroides m?s delante
        if (Minimum==distancia1)
            
        count1 = count1 + 1;
        Mean1 = Mean1 + DataSet(i,:);
        group1 = [group1;DataSet(i,:)];
        
        else if (Minimum==distancia2)
        count2 = count2 + 1;
        Mean2 = Mean2 + DataSet(i,:);
        group2 = [group2;DataSet(i,:)];
        else
        count3 = count3 + 1;
        Mean3 = Mean3 + DataSet(i,:);
        group3 = [group3;DataSet(i,:)]; 
        end
        end
    end
%----------------------------- New Centres -------------------------------%
% Los centros son el promedio de los elementos de su cluster
Centre1 = Mean1 / count1;
Centre2 = Mean2 / count2;
Centre3 = Mean3 / count3;
plot(j,count1,'r');
hold on
plot(j,count2,'g');
plot(j,count3,'b');
end
hold off
% specify the indexed color for each point
icolor = ceil((group1(:,4)/max(group1(:,4)))*256);
figure,
scatter3(group1(:,1),group1(:,2),group1(:,3),group1(:,4),icolor,'filled');
figure,
scatter3(group1(:,1),group1(:,2),group1(:,3),[],group1(:,4),'filled');
count1
count2
count3
group1
group2
group3