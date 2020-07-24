%==========================================================================
% This function creates a Self-Organizing Map and runs the related alg
% Inputs:
%           x_train: n-by-m features data. n indicates number of instances 
%       and m implies the dimensions of the space
%           netSize: Numbe of centers and dimension of eadch data
%           maxEpoch: Number main loop iteration
% Output:   
%           res: final weights, a 3-D data structure
% This code has been developed for educational purposes By Ali R. Nejad
% Reference: Neural Networks and Machine Learning by Simon Haykin
%==========================================================================
function [res] = SOM(X, netSize)
    a_max = 0.9;
    a_min = 0.5;
    tillNB = 2;
    maxIter = 150; 
    
    % make the neurons net
    nums = linspace(-2,2,netSize(1));
    cols = repmat(flip(nums'), [1, netSize(1)]);
    rows = repmat(nums, [netSize(2), 1]);
    W = zeros(netSize);
    W(:,:,1) = cols;
    W(:,:,2) = rows;
        
    X = X(randperm(size(X, 1)), :);

    for i=1:size(X,1)  %for each sample

        %visualization
        W1 = W(:,:,1); W2 = W(:,:,2);
        scatter(X(:,1), X(:,2),50, 'filled'); hold on;
        scatter(W1(:),W2(:),50, 'filled', 'red');
        drawNet(W);

%         pause(1)
        % calculate all neurons' distances to sample
        dists = zeros(netSize(1), netSize(2));
        for k=1:size(W, 1)
            for l=1:size(W, 2)
                w = reshape(W(k,l,:), [1, 2, 1]);
                dists(k,l) = sum((X(i,:)- flip(w)).^2);
            end
        end

        %find the nearest neuron
        minimum = min(min(dists));
        [minX,minY]=find(dists==minimum);

        %update all neurons
        lr = eta(a_max, a_min, maxIter, 80);

        for k=1:size(W, 1)
            for l=1:size(W, 2)
                w = reshape(W(k,l,:), [1, 2, 1]);
                diff_neuron_X = X(i,:) - flip(w);
                nb_dr = gaussianDist([minX, minY], [k, l], tillNB);

                % refine weight
                w = flip(w) + lr .* nb_dr .* diff_neuron_X;
                W(k,l,:) = reshape(flip(w), [1, 1, 2]);
            end
        end
        clf
    end
    
    % final resualt visualization
     W1 = W(:,:,1);
     W2 = W(:,:,2);
     scatter(X(:,1), X(:,2),50, 'filled'); hold on;
     scatter(W1(:), W2(:),50, 'filled', 'red'); 
     drawNet(W);
     hold off;
    res = W;
end

function neigh = gaussianDist (pos1, pos2, tillNb)
      neigh = exp(-(sqrt(sum((pos1-pos2).^2)))./2*(tillNb^2));
end

function lr = eta(a_max, a_min, t_max, t)
    lr = (a_max-a_min) * ((t_max-t)/(t_max-1)) + a_min;
end
