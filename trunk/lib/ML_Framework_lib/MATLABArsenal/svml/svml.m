function net = svml(fname, varargin)

% SVML - Wrapper for SVMlight
% 
%   NET = SVML(FNAME, OPTIONS)
%   Generate the SVMlight wrapper structure. FNAME is the file name
%   under which SVMlight will save its data files. FNAME can be left
%   empty (FNAME=''), in which case a random filename will be selected.
%   OPTIONS may either be a structure generated by SVMLOPT, or any other
%   sequence of arguments that is accepted by SVMLOPT.
%
%   Accepted options are:
%   Field      SVM light option  Range, description
%   'Verbosity'      -v       {0 .. 3}, default value 1
%                             Verbosity level
%   'Regression'     -z       {0, 1}, default value 0
%                             Switch between regression [1] and
%                             classification [0]
%   'C'              -c       (0, Inf), default value (avg. x*x)^-1
%                             Trade-off between error and margin
%   'TubeWidth'      -w       (0, Inf), default value 0.1
%                             Epsilon width of tube for regression
%   'CostFactor'     -j       (0, Inf), default value 1
%                             Cost-Factor by which training errors on
%                             positive examples outweight errors on
%                             negative examples
%   'Biased'         -b       {0, 1}, default value 1
%                             Use biased hyperplane x*w+b0 [1] instead of
%                             unbiased x*w0 [0]
%   'RemoveIncons'   -i       {0, 1}, default value 0
%                             Remove inconsistent training examples and
%                             retrain
%   'ComputeLOO'     -x       {0, 1}, default value 0
%                             Compute leave-one-out estimates [1]
%   'XialphaRho'     -o       )0, 2), default value 1.0
%                             Value of rho for XiAlpha-estimator and for
%                             pruning leave-one-out computation
%   'XialphaDepth'   -k       {0..100}, default value 0
%                             Search depth for extended XiAlpha-estimator 
%   'TransPosFrac'   -p       (0..1), default value ratio of
%                             positive and negative examples in the
%                             training data. Fraction of unlabeled
%                             examples to be classified into the positive
%                             class
%   'Kernel'         -t       {0..4}, default value 1
%                             Type of kernel function:
%                             0: linear
%                             1: polynomial (s a*b+c)^d
%                             2: radial basis function exp(-gamma ||a-b||^2)
%                             3: sigmoid tanh(s a*b + c)
%                             4: user defined kernel from kernel.h
%   'KernelParam'    -d, -g, -s, -r, -u
%                             Depending on the kernel, this vector
%                             contains [d] for polynomial kernel, [gamma]
%                             for RBF, [s, c] for tanh kernel, string for
%                             user-defined kernel
%   'MaximumQP'      -q       {2..}, default value 10
%                             Maximum size of QP-subproblems
%   'NewVariables'   -n       {2..}, default value is the value chosen
%                             for 'MaximumQP'. Number of new variables
%                             entering the working set in each
%                             iteration. Use smaller values to prevent
%                             zig-zagging
%   'CacheSize'      -m       (5..Inf), default value 40.
%                             Size of cache for kernel evaluations in MB
%   'EpsTermin'      -e       (0..Inf), default value 0.001
%                             Allow that error for termination criterion
%                             [y [w*x+b] - 1] < eps
%   'ShrinkIter'     -h       {5..Inf}, default value 100.
%                             Number of iterations a variable needs to be
%                             optimal before considered for shrinking
%   'ShrinkCheck'    -f       {0, 1}, default value 1
%                             Do final optimality check for variables
%                             removed by shrinking. Although this test is
%                             usually positive, there is no guarantee
%                             that the optimum was found if the test is
%                             omitted.
%   'TransLabelFile' -l       String. File to write predicted labels of
%                             unlabeled examples into after transductive
%                             learning.
%   'AlphaFile'      -a       String. Write all alphas to this file after
%                             learning (in the same order as in the
%                             training set).
%
%   Examples:
%   SVML('svmlightdata', 'Kernel', 0, 'C', 1);
%   SVML('', 'Kernel', 0, 'C', 1);
%   The above call is equivalent to
%     OPTS = SVMLOPT('Kernel', 0, 'C', 1);
%     SVML('', OPTS);
%
%
%   See also SVMLOPT, SVMLTRAIN, SVMLFWD
%

% 
% Copyright (c) by Anton Schwaighofer (2002)
% $Revision: 1.4 $ $Date: 2002/02/19 12:22:17 $
% mailto:anton.schwaighofer@gmx.net
% 
% This program is released unter the GNU General Public License.
% 

if nargin<1,
  fname = '';
end
if nargin<2,
  options = struct([]);
end

net.type = 'svml';
net.options = svmlopt(varargin{:});
net.fname = fname;
