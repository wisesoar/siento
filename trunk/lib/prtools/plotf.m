%PLOTF Plot feature distribution, special version
% 
%   h = PLOTF(A,N)
% 
% Produces 1-D density plots for all the features in dataset A. The 
% densities are estimated using PARZENML. N is the number of 
% feature density plots on a row. 
% 
% See also DATASETS, PARZENML

% Copyright: R.P.W. Duin, duin@ph.tn.tudelft.nl
% Faculty of Applied Sciences, Delft University of Technology
% P.O. Box 5046, 2600 GA Delft, The Netherlands

% $Id: plotf.m,v 1.5 2007/04/23 12:17:19 duin Exp $

function h_out = plotf(a,n)
%DXD make a standard setting for n, I'm getting crazy!
if nargin<2
	n = 1;
end

	prtrace(mfilename);
	
	[m,k,c] = getsize(a);

	% Define the color for each of the classes:
	if c == 2
		map = [0 0 1; 1 0 0];
	else
		map = hsv(c);
	end

	% Make subplots for each feature, so a grid of p x q subplots is
	% defined
	h = [];
	if k >= n
		p = ceil(k/n); q = n;
	else
		p = k; q = 1;
	end

	% Get the feature names
	feats = getfeatlab(a,'string');
	if size(feats,2) == 1
		feats = [repmat('Feature ',size(feats,1),1) feats];
	end

	% Make the plot for each of the features:
	for j = 1:k
		b = a(:,j);
		s = zeros(1,c);
		d = zeros(121,c);
		bb = [-0.10:0.01:1.10]' * (max(b)-min(b)) + min(b);
		ex = 0;
		% Make a density estimate of each of the classes:
		for i = 1:c
			I = findnlab(a,i);
			D = +distm(bb,b(I,:));
			s(i) = parzenml(b(I,:));
			% Compute the density function
			d(:,i) = sum(exp(-D/(s(i).^2)),2)./(length(I)*s(i));;
		end
		% Create the subplots with the correct sizes:
		subplot(p,q,j)
		plot(bb,zeros(size(bb)),'w.');
		hold on
		h = [];
		% Scatter the data and plot the density functions for each of the
		% classes:
		for i = 1:c
			I = findnlab(a,i);
			hh = plot(b(I),zeros(size(b(I))),'x',bb,+d(:,i));
			set(hh,'color',map(i,:));
			h = [h;hh];
		end
		legend(h(1:2:end)',num2str(getlablist(a))); %does not work properly
		title([getname(a) ': ' feats(j,:)]);
		V = axis;
		axis([bb(1) bb(end) V(3) V(4)]);
		set(gca,'xtick',[]);
		set(gca,'ytick',[]);
		xlabel(feats(j,:));
		hold off
	end

	% The last details to take care of:
	if k == 1, title(''); end
	if nargout > 0
		h_out = h;
	end

	return
