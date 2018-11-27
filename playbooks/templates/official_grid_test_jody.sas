options nosource; /* Do not show source when running... */
options metaserver='sasgridmeta1.grid.sas';     
options metaport=8561;
options metauser="sasadm@saspw";
options metapass="adminadmin1!";

%let SasAppSvr=SASApp;
%put;%put Trying to enable the grid for grid server &SasAppSvr...;
%let gerc=%sysfunc(grdsvc_enable(_all_,resource=&SasAppSvr));
%put;%put Grid enable return code=&gerc (0 indicates grid was enabled);
%macro loop;
%if (&gerc = 0) %then %do;
%let nnodes=%sysfunc(grdsvc_nnodes(resource=&SasAppSvr));
%put;%put Number of grid nodes=&nnodes;
%put;%put Job Name as it will appear in Grid Manager=SASGrid:&sysjobid;%put;
%do i=1 %to &nnodes;
signon grdn&i cmacvar=SignonStatus;
%if (&SignonStatus = 0) %then %do;
%let nodename=%sysfunc(grdsvc_getname(grdn&i));
%let nodeaddr=%sysfunc(grdsvc_getaddr(grdn&i));
%put; %put Session started on grid node: name, addr ===> &nodename,
&nodeaddr;%put;%put;
%end;
%else %do;
%put;%put Signon failed to node &i;
%end;
%end;
signoff _all_;
%end;
%else %do;
%put;%put Grid not enabled, signon loop cancelled;
%end;
%mend;
%loop;

