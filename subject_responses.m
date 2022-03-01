function y = subject_responses(B,X)
%
% Name: subject_responses
%
% Inputs:
%    B - n-by-1 vector, the assumed cognitive representation
%    X - l-by-n matrix of stimuli (rows:stimuli;columns:features)
% Outputs:
%    y - l-by-1 vector of subject responses (-1:no;+1:yes)      
%
% Created by: Adam C. Lammert (2022)
%
% Description: Simulate subject responses on the basis of the response
%              generating procedure assumed by reverse correlation.
% 

y = sign(X*B);

return
%eof