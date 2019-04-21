#!/usr/bin/env wolframscript
(* ::Package:: *)

(*
	Author: Deepak Ramalingam
	Description: This program determines the most likely disease given a set of symptoms.
*)

(* get pwd *)
args = $ScriptCommandLine
path = args[[2]]

(* hyperparameters *)
datasetPath = path <> "/data.csv" (* path to dataset *)
d = 2; (* target dimension to reduce original data to *)

(* import dataset *)
dataset = Import[datasetPath, "Data"]

(* extract features and labels *) 
xtrain = dataset[[2 ;;, 3 ;; ]];
ytrain = dataset[[2 ;;, 1]];
names = dataset[[2 ;;, 2]];

(* for now, just use train point as test and change an expected symptom *)
k = 44;
a = 10;
xtest = xtrain[[k]];
xtest[[a]] = 1 - xtest[[a]];

(* perform dimension reduction on both train and test data *)

dr = DimensionReduction[xtrain, d];
xtrainreduced = dr[xtrain];
xtestreduced = dr[xtest];

(* find the nearest (i.e. most "similar") train point to determine disease *)
nf = Nearest[Thread[xtrainreduced -> Range[Length[xtrainreduced]]]];
disease = names[[nf[xtestreduced]]];

(* print output *)
Print["" <> disease <> ""]



