function [E_Global, E_Nodal,D] = newform_CCM_efficiency_D(gMatrix)
% CCM_AvgShortestPath generates the shortest distance matrix of source nodes
% indice s to the target nodes indice t.
% Input:
% gMatrix symmetry binary connect matrix or weighted connect matrix
% s source nodes, default is 1:N
% t target nodes, default is 1:N
% Usage:
% [D_Global, D_Nodal] = CCM_AvgShortestPath(gMatrix) returns the mean
% shortest-path length of whole network D_Global,and the mean shortest-path
% length of each node in the network
% Example:
% G = CCM_TestGraph1('nograph');
% [D_Global, D_Nodal] = CCM_AvgShortestPath(G);
% See also dijk, MEAN, SUM
% Written by Yong Liu, Oct,2007
% Modified by Hu Yong, Nov 2010
% Center for Computational Medicine (CCM),
% Based on Matlab 2008a
% $Revision: 1.0, Copywrite (c) 2007
% ###### Input check #########
% gMatrix(gMatrix(:,:)>0.001)=1;%%%%%%%%%
error(nargchk(1,3,nargin,'struct'));
N = length(gMatrix);
if(nargin < 2 || isempty(s)), s = (1:N)';
else s = s(:); end
if(nargin < 3 || isempty(t)), t = (1:N)';
else t = t(:); end
% Calculate the shortest-path from s to all node
D = dijk(gMatrix,s);%D(isinf(D)) = 0;
D = D(:,t); %To target nodes
D=1./D;
D(logical(eye(size(D))))=0;
%%
E_Nodal=zeros(N,1);
for i=1:N
    temp=D(:,i);
    temp(isnan(temp))=[];
    temp(isinf(temp))=[];
    E_Nodal(i,1)=mean(temp);
end
% E_Nodal = (sum(D,2)./sum(D>0,2));
% E_Nodal(isnan(E_Nodal)) = [];
E_Global = mean(E_Nodal);
% E_Global = sum(sum(D),2)/sum(sum(D(:,:)>0.00001),2);%0530