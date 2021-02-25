% script to download BoP data from IMF database
clearvars
close all
clc

%% load all series from IMF
db = struct();
tmp = databank.fromIMF.data("BOP", Frequency.YEARLY, ["US"], []);
db = dbmerge(db, tmp);
tmp = databank.fromIMF.data("BOP", Frequency.YEARLY, ["U2"], []);
db = dbmerge(db, tmp);
tmp = databank.fromIMF.data("BOP", Frequency.YEARLY, ["CN"], []);
db = dbmerge(db, tmp);

databank.toCSV(db,'bop_imf_all.csv');
