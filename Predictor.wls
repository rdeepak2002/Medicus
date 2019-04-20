#!/usr/bin/env wolframscript
(* ::Package:: *)

(*
	Author: Deepak Ramalingam
	Description: This program determines the most likely disease given a set of symptoms.
*)

(* hyperparameters *)

datasetPath = "/Users/dramalingam/Desktop/Medicus/data.csv" (* path to dataset *)
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
Print["Based upon your symptoms, you have " <> disease <> ". Have a good day :)"]

(* show 3d diagram of body part affected by disease 

AnatomyPlot3D[{{ClipPlanes -> {InfinitePlane[{{-50, -146, 1500}, {-20, -146 - 20, 1550}, {-50, -146 - 20, 1500}}]}, 
  Entity["AnatomicalStructure", "Skull"]}, 
  Entity["AnatomicalStructure", "Eye"], 
  Entity["AnatomicalStructure", "RightCerebralHemisphere"], 
  Directive[Specularity[White, 50], Hue[.58, 0, 1, .1], Lighting -> Join[{{"Ambient", Black}}, Table[{"Directional", Hue[.58, .5, 1], ImageScaled[{Sin[x], Cos[x], -.5}]}, {x, 0, 2 \[Pi] - \[Pi]/4, \[Pi]/4}]]], 
  Entity["AnatomicalStructure", "Nose"], 
  Entity["AnatomicalStructure", "Neck"], 
  Entity["AnatomicalStructure", "SkinOfHead"], 
  Entity["AnatomicalStructure", "SkinOfNeck"], 
  Entity["AnatomicalStructure", "Lip"], 
  Entity["AnatomicalStructure", "Ear"]}, 
  PlotRange -> Entity["AnatomicalStructure", "Head"], 
  PlotRangePadding -> 10, Background -> Hue[.58, 1, .3], 
  SphericalRegion -> True, ViewPoint -> {-1.18, -1.49, -0.07}, ViewVertical -> {0.015, -0.044, 1.0}, ViewAngle -> \[Pi]/5, ImageSize -> {400, 400}]
*)




