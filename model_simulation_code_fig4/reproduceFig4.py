import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as st

def varTheory(n,alpha,C):
    part1=(2-2*alpha**(n))*alpha**2/(1-alpha**2)
    part2=-2*alpha*(1-alpha**n)/(1-alpha)+n
    z=part1+part2
    z*=C**2*(1/(1-alpha)**2)
    return z
def varianceAtrophysTheory(k1,k2,ke,CA,CE,n):
    alpha=1-k1*k2-ke
    CE_=np.sqrt(CE**2+(k2*CA)**2)
    varE=CE_**2/(1-alpha**2)
    part1=k1**2*varTheory(n,alpha,CE_)
    part2=n*CA**2
    part3=-2*k1*k2*CA**2*(n-1-alpha*(1-alpha**n)/(1-alpha))/(1-alpha)
    return part1+part2+part3

#parameters setting
k1=0.9
k2=0.9
ke=0.15
CA=0.45
CE=0.05
n0=2 # n0 time steps corresponds to 2 years

#parameters of standarization
mean_E=0.64
mean_A_2year=0.0258
var_E=0.14**2
var_A_2year=0.024

#Moodel for evolution of standarized atrophy and efficiency
#Calculate their standarized value from their value at last time step
def updateState(e,a,k1,k2,ke,CA,CE):
    """ 
    k1:the effect of efficiency on atrophy
    k2:the effect of atrophy on efficiency
    ke: negative feedback by efficiency self
    CA:noise of atrophy
    CE：noise of efficiency
    """
    a=k1*e+CA*np.random.normal()
    DeltaE=-ke*e-k2*a+CE*np.random.normal()
    e+=DeltaE
    return a,e

def inverse_standarization(e_list,a_list,n0,mean_E,var_A_2year,mean_A_2year,k1,k2,ke,CA,CE):
    C_=np.sqrt((k2*CA)**2+CE**2)
    alpha=1-ke-k1*k2
    var_e=varTheory(1,alpha,C_)
    var_a_2year=varianceAtrophysTheory(k1,k2,ke,CA,CE,n0)
    E_list=np.array(e_list)
    A_list=np.array(a_list)
    E_list*=var_E/var_e
    A_list*=var_A_2year/var_a_2year
    E_list+=mean_E
    A_list+=mean_A_2year/n0
    return E_list,A_list

a,e=0,0 #
for i in range(100): 
    a,e=updateState(e,a,k1,k2,ke,CA,CE) # runs 100 steps to exclude the effect initial value
e_list=[e] #initial standarized efficiency
a_list=[a] #inital atrophy rate
t=0
t_list=[t] #initial time
steps_in_20_years=int(20/(n0/2)) # number of steps for 20 years, where n0 steps ~ 2 years
for i in range(steps_in_20_years):
    t+=1
    a,e=updateState(e,a,k1,k2,ke,CA,CE)
    a_list.append(a)
    e_list.append(e)
    t_list.append(t)

#get corresponding real value for a_list and e_list by inverse standarization
E_list,A_list=inverse_standarization(e_list,a_list,n0,mean_E,var_A_2year,mean_A_2year,k1,k2,ke,CA,CE)
V=1 # initial volume is set to 1
volume_list=[] #volume at each time point
for i in range(len(A_list)):
    volume_list.append(V)
    A=A_list[i]
    V*=(1-A)
    
plt.plot(t_list,E_list,c='r',label="Efficiency")
plt.plot(t_list,volume_list,c='b',label="Volume")
line1,=plt.plot([0,20],[mean_E,mean_E],c='r',label="Mean of Efficiency")
line1.set_dashes([8,4,2,8])
plt.legend()
plt.scatter(t_list,E_list,c='r')
plt.scatter(t_list,volume_list,c='b')
plt.xlabel("t / years")
plt.xticks([0, 5, 10, 15, 20])
plt.savefig("fig4(b).png")
plt.show()


########Fig. 4c####################
#Simulating 51 individuals in 6 years for Atrophy0,1, E1, Atrophy1,2
individual_num=51 # same to empirical data
steps_in_6_years=int(6/(n0/2)) # number of steps for 6 years, where n0 steps ~ 2 years
Atrophy01_simulated_list=[]
Efficiency1_simulated_list=[]
Atrophy12_simulated_list=[]

for _ in range(individual_num):
    a,e=0,0 #
    for i in range(100): 
        a,e=updateState(e,a,k1,k2,ke,CA,CE) # runs 100 steps to exclude the effect initial value
    e_list=[e] #initial standarized efficiency
    a_list=[a] #inital atrophy rate
    t=0
    t_list=[t] #initial time
    for i in range(steps_in_6_years):
        t+=1
        a,e=updateState(e,a,k1,k2,ke,CA,CE)
        a_list.append(a)
        e_list.append(e)
        t_list.append(t)
    E_list,A_list=inverse_standarization(e_list,a_list,n0,mean_E,var_A_2year,mean_A_2year,k1,k2,ke,CA,CE)
    Efficiency1=E_list[2]
    Atrophy01=A_list[1]+A_list[2]
    Atrophy12=A_list[3]+A_list[4]+A_list[5]+A_list[6]
    
    Atrophy01_simulated_list.append(Atrophy01)
    Atrophy12_simulated_list.append(Atrophy12)
    Efficiency1_simulated_list.append(Efficiency1)
#Calculate Z-scores and divide 51 individuals into Adaptation groups and Degeneration Group groups
A01_list=np.array(Atrophy01_simulated_list)
E1_list=np.array(Efficiency1_simulated_list)
A12_list=np.array(Atrophy12_simulated_list)
zscore_A01=(A01_list-np.mean(A01_list))/np.std(A01_list)
zscore_E1=(E1_list-np.mean(E1_list))/np.std(E1_list)
zscore_A12=(A12_list-np.mean(A12_list))/np.std(A12_list)

group1_index=[] #degeneration group
group2_index=[] #adaptation group
for index in range(len(A01_list)):
    if(2*zscore_E1[index]>(zscore_A01[index]+zscore_A12[index])):
        group1_index.append(index)
    else:
        group2_index.append(index)
print("num (Degeneration Group)/num(Adaptation Group)="+str(len(group1_index)/len(group2_index)))

#Output the errorbar

zscore_group1_A01=[]
zscore_group1_E1=[]
zscore_group1_A12=[]
for index in group1_index:
    A01=zscore_A01[index]
    E1=zscore_E1[index]
    A12=zscore_A12[index]
    zscore_group1_A01.append(A01)
    zscore_group1_E1.append(E1)
    zscore_group1_A12.append(A12)
print("degeneration group:")
print("A01: "+"mean="+str(np.mean(zscore_group1_A01))+"   std="+str(np.std(zscore_group1_A01,ddof=1)/np.sqrt(len(group1_index))))
print("E1: "+"mean="+str(np.mean(zscore_group1_E1))+"   std="+str(np.std(zscore_group1_E1,ddof=1)/np.sqrt(len(group1_index))))
print("A12: "+"mean="+str(np.mean(zscore_group1_A12))+"   std="+str(np.std(zscore_group1_A12,ddof=1)/np.sqrt(len(group1_index))))

zscore_group2_A01=[]
zscore_group2_E1=[]
zscore_group2_A12=[]
for index in group2_index:
    A01=zscore_A01[index]
    E1=zscore_E1[index]
    A12=zscore_A12[index]
    zscore_group2_A01.append(A01)
    zscore_group2_E1.append(E1)
    zscore_group2_A12.append(A12)
print("adaptation group:")
print("A01: "+"mean="+str(np.mean(zscore_group2_A01))+"   std="+str(np.std(zscore_group2_A01,ddof=1)/np.sqrt(len(group2_index))))
print("E1: "+"mean="+str(np.mean(zscore_group2_E1))+"   std="+str(np.std(zscore_group2_E1,ddof=1)/np.sqrt(len(group2_index))))
print("A12: "+"mean="+str(np.mean(zscore_group2_A12))+"   std="+str(np.std(zscore_group2_A12,ddof=1)/np.sqrt(len(group2_index))))


x_values = ["Atrophy0,1", "E1", "Atrophy1,2"]
y_values_1 = [np.mean(zscore_group1_A01), 
              np.mean(zscore_group1_E1), 
              np.mean(zscore_group1_A12)]  
y_error_1 = [np.std(zscore_group1_A01,ddof=1)/np.sqrt(len(group1_index)),
             np.std(zscore_group1_E1,ddof=1)/np.sqrt(len(group1_index)),
             np.std(zscore_group1_A12,ddof=1)/np.sqrt(len(group1_index))]  

y_values_2 = [np.mean(zscore_group2_A01),
              np.mean(zscore_group2_E1),
              np.mean(zscore_group2_A12)] 
y_error_2 = [np.std(zscore_group2_A01,ddof=1)/np.sqrt(len(group2_index)),
             np.std(zscore_group2_E1,ddof=1)/np.sqrt(len(group2_index)),
             np.std(zscore_group2_A12,ddof=1)/np.sqrt(len(group2_index))]  


fig, ax = plt.subplots()
ax.errorbar(x_values, y_values_1, yerr=y_error_1, color='blue', label='Degeneration Group',capsize=4)
ax.errorbar(x_values, y_values_2, yerr=y_error_2, color='orangered', label='Adaptation Group',capsize=4)
ax.axhline(0, color='black', linestyle='--')
ax.set_ylabel('Zscore')
ax.legend()
plt.savefig("Fig4(c).png")
plt.show()

################Fig.4d#########################
#Simulating 51 individuals in 6 years for Atrophy0,1, E1, Atrophy1,2
individual_num=51 # same to empirical data
steps_in_6_years=int(6/(n0/2)) # number of steps for 6 years, where n0 steps ~ 2 years
Atrophy01_simulated_list=[]
Efficiency1_simulated_list=[]
Atrophy12_simulated_list=[]

for _ in range(individual_num):
    a,e=0,0 #
    for i in range(100): 
        a,e=updateState(e,a,k1,k2,ke,CA,CE) # runs 100 steps to exclude the effect initial value
    e_list=[e] #initial standarized efficiency
    a_list=[a] #inital atrophy rate
    t=0
    for i in range(steps_in_6_years):
        a,e=updateState(e,a,k1,k2,ke,CA,CE)
        a_list.append(a)
        e_list.append(e)
    E_list,A_list=inverse_standarization(e_list,a_list,n0,mean_E,var_A_2year,mean_A_2year,k1,k2,ke,CA,CE)
    Efficiency1=E_list[2]
    Atrophy01=A_list[1]+A_list[2]
    Atrophy12=A_list[3]+A_list[4]+A_list[5]+A_list[6]
    
    Atrophy01_simulated_list.append(Atrophy01)
    Atrophy12_simulated_list.append(Atrophy12)
    Efficiency1_simulated_list.append(Efficiency1)
A01_list=np.array(Atrophy01_simulated_list)
E1_list=np.array(Efficiency1_simulated_list)
A12_list=np.array(Atrophy12_simulated_list)

##########Fig4d_AtoE########################
x=A01_list
y=E1_list
plt.scatter(x,y,c='none',marker='o',edgecolor='black',label='data')
slope, intercept, r1, p1, std_err = st.linregress(x,y)
plt.plot(x,slope*x+intercept,c='r',label='fit')
plt.xlabel(r"$Atrophy_{0,1}$")
plt.ylabel(r"$E_1$")
plt.legend()
print("A01&E1: R="+str(r1)+",p="+str(p1))
plt.savefig("Fig4d_A01_E1.png")
plt.show()

x=A12_list
y=E1_list
plt.scatter(x,y,c='none',marker='o',edgecolor='black',label='data')
slope, intercept, r1, p1, std_err = st.linregress(x,y)
print("A12&E1: R="+str(r1)+",p="+str(p1))
plt.plot(x,slope*x+intercept,c='r',label='fit')
plt.xlabel(r"$Atrophy_{1,2}$")
plt.ylabel(r"$E_1$")
plt.legend()
plt.savefig("Fig4d_A12_E1.png")
plt.show()
