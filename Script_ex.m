%
% Name: Script_ex
%
% Created by: Adam C. Lammert (2022)
%
% Description: Script implementing a worked example of stimulus whitening
% and its efficiency advantages for the reverse correlation experimental 
% paradigm. Three sub-examples are conducted with varying sample sizes, i.e., 
% number of stimulus-response trials obtained from reverse correlation. The
% first sub-example leaves the stimuli unwhitened, while the second and 
% third sub-example whiten the stimuli (see whiten_stimuli.m). For the 
% purposes of illustration, the underlying cognitive cognitive 
% representation is assumed, and the subject responses are simulated (
% see subject_responses.m). Fig 3 from the manuscript "Stimulus Whitening 
% Improves the Efficiency of Reverse Correlation".
%

figure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the Assumed Cognitive Representation

C = load('cog_rep_letter_s.mat');
B = C.B; % <--- cognitive representation
clear C

% Determine representation dimensions
n1 = size(B,1);
n2 = size(B,2);
n = n1*n2;

% Vectorize cognitive representation
B = B(:);

% Visualize cognitive representation
subplot(2,3,1), imagesc(reshape(B,n1,n2)), xlabel('Cognitive Representation'), axis image, set(gca,'xtick',[],'ytick',[])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example #1: Unwhitened Stimuli, Large Sample Size

l = 5000; % number of stimuli

% Create random matrix of stimuli
X = randn(l,n);

% Simulate subject responses to stimuli
y = subject_responses(B,X);

% Estimate representation using reverse correlation
B_hat = reverse_correlation(y,X);

% Visualize estimated cognitive representation
subplot(2,3,4), imagesc(reshape(B_hat,n1,n2)), xlabel('Unwhitened Stimuli (n=5k)'), axis image, set(gca,'xtick',[],'ytick',[])

% Quantify estimation quality via correlation
r = corrcoef(B,B_hat);
fprintf('Squared Correlation - Unwhitened Stimuli, Large Sample: %5.4f\n',r(1,2)^2)

% Visualize example unwhitened stimulus
subplot(2,3,2), imagesc(reshape(X(1,:),50,50)), xlabel('Unwhitened Stimulus'), axis image, set(gca,'xtick',[],'ytick',[])

% End example
clear X y B_hat r l

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example #2: Whitened Stimuli, Small Sample Size

l = 1300; % number of stimuli

% Create random matrix of stimuli
X = randn(l,n);

% Whiten stimulus matrix
[Xw, ~] = whiten_stimuli(X,0.001);

% Simulate subject responses to stimuli
y = subject_responses(B,Xw);

% Estimate representation using reverse correlation
B_hat = reverse_correlation(y,Xw);

% Visualize estimated cognitive representation
subplot(2,3,5), imagesc(reshape(B_hat,n1,n2)), xlabel('Whitened Stimuli (n=1.3k)'), axis image, set(gca,'xtick',[],'ytick',[])

% Quantify estimation quality via correlation
r = corrcoef(B,B_hat);
fprintf('Squared Correlation - Whitened Stimuli, Small Sample: %5.4f\n',r(1,2)^2)

% Visualize example whitened stimulus
subplot(2,3,3), imagesc(reshape(Xw(1,:),50,50)), xlabel('Whitened Stimulus'), axis image, set(gca,'xtick',[],'ytick',[])

% End example
clear X Xw y B_hat r l

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example #3: Whitened Stimuli, Large Sample Size

l = 5000; % number of stimuli

% Create random matrix of stimuli
X = randn(l,n);

% Whiten stimulus matrix
[Xw, ~] = whiten_stimuli(X,0.001);

% Simulate subject responses to stimuli
y = subject_responses(B,Xw);

% Estimate representation using reverse correlation
B_hat = reverse_correlation(y,Xw);

% Visualize estimated cognitive representation
subplot(2,3,6), imagesc(reshape(B_hat,n1,n2)), xlabel('Whitened Stimuli (n=5k)'), axis image, set(gca,'xtick',[],'ytick',[])

% Quantify estimation quality via correlation
r = corrcoef(B,B_hat);
fprintf('Squared Correlation - Whitened Stimuli, Large Sample: %5.4f\n',r(1,2)^2)

% End example
clear X Xw y B_hat r l

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

colormap gray

return
%eof