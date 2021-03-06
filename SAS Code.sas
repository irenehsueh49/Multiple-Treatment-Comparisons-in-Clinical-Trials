proc format; 
	value trt_format 1="Placebo" 2="Low Dose" 3="High Dose";
	value death_format 1="Died" 0="Alive";
run;

data cancer; 
	input trt outcome count;
	label outcome="Death"; 
	format trt trt_format. outcome death_format.;
cards;
1 1 30
2 1 23
3 1 13
1 0 16
2 0 22
3 0 31
;
run;

proc print data=cancer label;
run;



title "Pairwise Comparison between Low Dose and Placebo";
proc freq data=cancer order=formatted;
	where trt in (1, 2);
	tables trt*outcome / nocol nopercent chisq 
						 riskdiff (column=2 cl=wald norisks) 
						 relrisk (column=2 cl=wald) alpha=0.025;
	weight count;
run;
title;

title "Pairwise Comparison between High Dose and Placebo";
proc freq data=cancer order=formatted;
	where trt in (1, 3);
	tables trt*outcome / nocol nopercent chisq 
						 riskdiff (column=2 cl=wald norisks) 
						 relrisk (column=2 cl=wald) alpha=0.025;
	weight count;
run;
title;

