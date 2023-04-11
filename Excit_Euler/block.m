function func = block(x,a,b)
% 	BLOCK is a block function, i.e. it is one if a < x < a+b, 
%   else zero
%	block(x,a,b)
%	x = argument, a denotes the beginning and b the length 
%   of a block

func = 0.5*(sign(x-a)-sign(x-(a+b)));	% sets the block to zero 
                                        % for a<x<a+b, else to 1
index_1 = min(find(func));		% FIND locates nonzero values
index_2 = max(find(func));		% FIND locates nonzero values
func(index_1) = 1;				% sets the value 1 for x=a
func(index_2) = 1;				% sets the value 1 for x=a+b
