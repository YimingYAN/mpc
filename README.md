MPC: Mehrotra's Predictor-Corrector Interior Point Method
---------------------------------------------------------------------------

Author: Yiming Yan @ University of Edinburgh

Before you start
---------------------------------------------------------------------------
This is a just very simple demo version of the implementation
of the Methrotra's predictor-corrector IPM for Linear Programming.
There is no guarantee that it can solve very hard or large-scale 
problems and its performance may not be as good as the standard commercial
codes, but it does reflect the general ideas of the interior point methods.

The main solver MPCSOL (/solver/mpcSol.m) only accepts LP problems 
in the standard form, i.e.
```
        min c'*x 
        s.t. Ax = b, 
             x>=0.        
```
Any LP problem can be transformed to the standard form.


How To Use it
---------------------------------------------------------------------------
1. Run the script setup.m first to check and setup necessary
   system environment.

2. If your problem is in the standard form, you can use 

    ```[x, y, s, N] = mpcSol(A,b,c)```

   or 
   
    ```[x, y, s, N] = mpcSol(A,b,c, param_in, Name)```
    
   when you would like to specify the name of the problem and the parameters.

   The default value of input Name is "testProb". Regardnig to the default 
   value of parameters, see setParamOptions.m.

3. To test the examples, just run "testExamples" in your command line.
   The source code and data files of the script "testExamples.m" can be 
   found in folder "examples".

Have Fun! :)
Yiming


References
---------------------------------------------------------------------------
1. Stephen Wright, Primal-Dual Interior-Point Method
2. Sanjay Mehrotra, On the Implementation of a Primal-Dual 
   Interior Point Method. 
