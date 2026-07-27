/* Derived from utl-python-send-a-list-of-zipcodes-...-longitudes.sas       */
/* Keeps the repo's macro-variable ZIP list core; the web/Python step is    */
/* replaced with a pure-SAS parse of the same &zips list so it runs anywhere.*/

%symdel key zips / nowarn;

%let zips="97048", "63640", "63628";

%put &=zips;

/* one row per ZIP straight from the &zips list above */
data zipcodes;
  length zip $5;
  do zip = &zips;
    output;
  end;
run;

proc print data=zipcodes noobs;
  title "ZIP codes from &=zips";
run;
