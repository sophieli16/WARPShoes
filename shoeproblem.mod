# Define the sets
set product;
set demand;
set rawMat;
set machine;
set stores;
set yearr;

#Define parameters
param salesprice{i in product};
param RMcost{l in rawMat};
param RMQuan{l in rawMat};
param avgDur{i in product, k in machine} default 0;
param opCost{k in machine};
param demandd{i in product};
param quant{i in product, l in rawMat} default 0;



# decision variables
var x {i in product} >= 0;
#var y {i in product} >= 0;  

# objective function
maximize z: 
sum {i in product} (salesprice[i]*x[i]) 
- sum {i in product, k in machine} ((opCost[k]/60) * x[i])
- sum {i in product, k in machine} (25/3600*(avgDur[i,k] * x[i]))
- sum {i in product, l in rawMat} (quant[i,l] * x[i])
- sum {i in product} (10*(demandd[i] - x[i]));
#- sum {i in product} (10*(y[i]));

# constraints
subject to maxDuration{i in product}: sum{k in machine} avgDur[i,k]*x[i] <= 43200;
subject to budgetRawMat{i in product}: sum{l in rawMat} RMcost[l]*quant[i,l]*x[i]<= 10000000;
subject to maxDemand{i in product}: x[i] <= (demandd[i]*2);
subject to maxProd{i in product}: x[i] <=140000;
#subject to maxProd{i in product}: x[i] <=140000 + y[i];
