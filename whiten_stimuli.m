function [Xw, W] = whiten_stimuli(X,epsilon)
%
% Name: whiten_stimuli
%
% Inputs:
%    X - l-by-n matrix of stimuli (rows:stimuli;columns:features)
%    epsilon - scalar value, a numerical matrix inversion bias parameter
% Outputs:
%    Xw - l-by-n matrix of whitened stimuli (rows:stimuli;columns:features)  
%    W - l-by-l whitening matrix
%
% Created by: Adam C. Lammert (2022)
%
% Description: Whiten rows of the stimulus matrix.
% 

l = size(X,1);
n = size(X,2);

% Center stimuli
Y = X-repmat(mean(X,2),1,n);

% Determine whitening matrix
W = inv(sqrtm(cov(Y')+epsilon*eye(l,l)));

% Whiten stimuli
Xw = W*Y;

return
%eof