*options nosource; /* Do not show source when running... */
options metaserver='sasgridmeta1.grid.sas';       
options metaport=8561;
options metauser="sasadm@saspw";           
options metapass='adminadmin1!';

/* Do not show source when running...      */
/* The grdsvc_enable call will go out to the SAS Metadata Server and   */ 
/* find the SAS Grid Server definition. A return code of 0 means that  */ 
/* all signons will use the grid. A non-0 return code means that there */ 
/* is a problem that should be investigated.                           */ 
%let SasAppSvr=SASApp;
/* This program assumes a SAS application server of SASMain.  If you   */ 
/* are using SASApp or some other SAS application server, you must     */ 
/* modify the enable and nodes function calls to specify your SAS      */ 
/* application server.                                                 */
%put;%put Trying to enable the grid for grid server &SasAppSvr...; 
%let gerc=%sysfunc(grdsvc_enable(_all_,resource=&SasAppSvr)); 
%put;%put Grid enable return code=&gerc (0 indicates grid was enabled);
/* Define a macro to loop to make sure that the grid nodes have been   */ 
/* set up correctly.                                                   */
%macro loop;
  /* If the grdsvc_enable call worked, try to signon to all nodes      */  
  %if (&gerc = 0) %then %do;
    /* The grdsvc_nnodes call will provide the number of grid nodes    */    
	/* available in the grid.                                          */    
	%let nnodes=%sysfunc(grdsvc_nnodes(resource=&SasAppSvr));    
	%put;%put Number of grid nodes=&nnodes;
    /* You can view the progress of the signons using the Grid Manager.*/    
	/* Watch for Job Names such as SASGrid:xxxx where xxxx is the value*/    
	/* of the sysjobid of this SAS session.                            */    
	%put;%put Job Name as it will appear in Grid Manager=SASGrid:&sysjobid;%put;
    /* Loop through all possible grid nodes                            */    
	%do i=1 %to &nnodes;
      /* Signon to the next grid node                                  */      
	  signon grdn&i cmacvar=SignonStatus;
      /* If the signon worked, put out information about the node      */      
	  %if (&SignonStatus = 0) %then %do;        
	  %let nodename=%sysfunc(grdsvc_getname(grdn&i));        
	  %let nodeaddr=%sysfunc(grdsvc_getaddr(grdn&i));        
	  %put; %put Session started on grid node: name, addr ===> &nodename, &nodeaddr;%put;%put;        
	  %end;
      /* If the signon failed, put out a message                       */      
	  %else %do;        %put;%put Signon failed to node &i;      %end;
    %end;
    /* Stop SAS running on the grid nodes.                             */    
	signoff _all_;
  %end;
  /* If the grdsvc_enable failed, do not signon to any nodes           */  
  %else %do; 
%put;%put Grid not enabled, signon loop cancelled;   
 %end;
%mend;
/* Invoke the loop macro to issue the signons.                         */ 
/* Monitor the progress of the signon to the nodes using SAS           */ 
/* Management Console and the Grid Manager.                            */ 
%loop;

