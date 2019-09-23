%% to perturb (but only perturbs the sizes of cubes..)
mask = zeros([128,128,128]);
seqn = 32:32:128;
% perturb1 = randn([ 1, length(seqn)]);
% seqn1 = ceil(seqn+perturb1);
% 
% perturb2 = randn([ 1, length(seqn)]);
% seqn2 = ceil(seqn+perturb2);
% 
% perturb3 = randn([ 1, length(seqn)]);
% seqn3 = ceil(seqn+perturb3);
% mask(seqn1,seqn2,seqn3) = 1;


for i= seqn
    for j=seqn
        for k=seqn
            
            p1 = randn; %one is perturbed more
            p2 = 3*randn;
            p3 = rand;
            
            mask(ceil(i+p1), ceil(j+p2), ceil(k+p3))= 1;
            
        end
    end
end

            


dt = bwdist(mask);
ws = watershed(dt);
figure
imagesc(ws(:,:,5))