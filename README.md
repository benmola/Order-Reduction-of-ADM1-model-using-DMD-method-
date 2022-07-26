# Order-Reduction-of-ADM1-model-using-DMD-method-

Model order reduction using Dynamic Mode Decomposition :Application to the Anaerobic Digestion Model N.1 (ADM1).

In this repository I would like to share with you my work on the Model order reduction of the ADM1 model of  anaerobic digestion process using the famous DMD method. I have applied the DMD method to a set of data generated from the simulation of the AMD1 diffential equations. 
This work has been published in the CARI2020 conference  in the following link: https://www.cari-info.org/senegal-2020/ or ypu can find the paper in the HAL archive here: https://hal.inria.fr/hal-02928872v1.


#  Abstract

The Anaerobic Digestion Model No.1 (ADM1) is by far the most detailed model for the
simulation and monitoring of Anaerobic Digestion (AD) processes. However, the ADM1 model is not
dedicated for control purposes, due to its high dimension with 35 state variables. Dynamic Mode
Decomposition (DMD) technique was applied to reduce the ADM1 order, using data generated from
the Benchmark Simulation Model No. 2 (BSM2). The method allows to obtain a global linear model
with only 7 state variables, which are coherent with dominant dynamics of the ADM1. We show in
simulation that we can reconstruct original state variables of ADM1 model.

# Code 

The file  ADM1DataONE.mat is the data file generated from simulating the ADM1 model (ADM1SIMULATION.m).
The ADM1withDMD.m is the main code of the application of the method with DMD.m and DMDfull.m are the DMD matlab code used for the work.
