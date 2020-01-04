Requirements prior to Environmental Setup:

Please ensure you have done the following steps before executing the tcl script.

(i) You have ubuntu 14.04 successfully installed.
(ii) copy the package ns-allinone-2.32.zip into /home and extract it.
      copy the directory Code into /home
      copy the ns file from the package-2.32 directoy into ns-allinone-2.32/bin directory 
      and replace the existing file.
(iii) Delete all other ns2 packages installed in your system.
(iv)  Open the terminal and set the path as,
	PATH=$PATH:/home/ns-allinone-2.32/bin
(v) now give the command
                   echo $PATH
      to see any other ns2 paths are included. 
The path should not show any other ns2 path other than /home/ns-allinone-2.32/bin.

***********************************************************************************
Instructions of Execution:
-----------
How to run:
-----------
1 Go to the tcl folder then run the following tcl files 
 
             cd /home/Code/tcl
             ns OKMSDT.tcl (proposed)
and
             ns KMDT.tcl (existing)

2. To view the output,
		nam out.nam

***********************************************************************************


Graph Generation steps
------------------------
Based on Nodes
------------------------
3. In OKMSDT.tcl,set the initial no.of nodes as 25 and rate as 250Kb.

	set val(nn)   25
	set rate      250Kb


4. execute the tcl file 
		ns OKMSDT.tcl

5. execute the following commands
		
		./create1
                cc graph.c
		./a.out

Enter the value as  25.

		

It will generate the output files  Delratio,Delay,Drop,Overhead,Throughput and Energy.
                
6.Repeat the above steps by changing the no.of nodes as 50,75,100 and 125.

7.cut and paste all the data files into Graph/Nodes directory.

-------------------
Based on Rate
-------------------

8.initially in OKMSDT.tcl set the rate as 50kb and no.of nodes as 125.

	set rate    50kb
	set val(nn) 125


9. execute the tcl file 

		ns OKMSDT.tcl

10. execute the following commands
		
		./create1
                cc graph.c
		./a.out

Enter the value as  50.

		
It will generate the output files  Delratio,Delay,Drop,Overhead,Throughput and Energy.
                
11.Repeat the above steps by changing the rate as 100,150,200 and 250kb.

12.cut and paste all the data files into Graph/Rate directory.

***********************************************************************************

For Comparison Graphs
====================
Based on Nodes
------------------------
13. In KMDT.tcl,set the initial no.of nodes as 25 and rate as 250Kb.

	set val(nn)   25
	set rate      250Kb


14. execute the tcl file 
		ns KMDT.tcl

15. execute the following commands
		
		./create2
                cc graph.c
		./a.out

Enter the value as  25.

		
It will generate the output files  Delratio,Delay,Drop,Overhead,Throughput and Energy.
                
16.Repeat the above steps by changing the no.of nodes as 50,75,100 and 125.

17.cut and paste all the data files into Graph/Nodes directory.

-------------------
Based on Rate
-------------------

18.initially in KMDT.tcl set the rate as 50kb and no.of nodes as 125.

	set rate    50kb
	set val(nn) 125


19. execute the tcl file 

		ns KMDT.tcl

20. execute the following commands
		
		./create2
                cc graph.c
		./a.out

Enter the value as  50.

		
It will generate the output files  Delratio,Delay,Drop,Overhead,Throughput and Energy.
                
21.Repeat the above steps by changing the rate as 100,150,200 and 250kb.

22.cut and paste all the data files into Graph/Rate directory.


*************************************************************************************


To view the graphs
------------------
23.change to the Rate directory,then run the following tcl file as,

		cd ..
		cd Graph/Rate

		ns Delay.tcl
		ns DelRatio.tcl
		ns Drop.tcl
		ns Energy.tcl
		ns Overhead.tcl
		ns Throughput.tcl


24.change to the Nodes directory,then run the following tcl file as,


		cd ..
		cd Nodes

		ns Delay.tcl
		ns DelRatio.tcl
		ns Drop.tcl
		ns Energy.tcl
		ns Overhead.tcl
		ns Throughput.tcl











