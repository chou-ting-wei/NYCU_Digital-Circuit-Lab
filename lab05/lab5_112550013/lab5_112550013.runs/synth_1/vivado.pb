
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
create_project: 2

00:00:012

00:00:052	
630.4882	
200.770Z17-268h px� 
�
Command: %s
1870*	planAhead2�
�read_checkpoint -auto_incremental -incremental D:/Coding/vivado-projects/NYCU/DLab/lab05/lab5_for_student.srcs/utils_1/imports/synth_1/lab5.dcpZ12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2b
`D:/Coding/vivado-projects/NYCU/DLab/lab05/lab5_for_student.srcs/utils_1/imports/synth_1/lab5.dcpZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
a
Command: %s
53*	vivadotcl20
.synth_design -top lab5 -part xc7a35ticsg324-1LZ4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
{
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2

xc7a35tiZ17-347h px� 
k
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2

xc7a35tiZ17-349h px� 
F
Loading part %s157*device2
xc7a35ticsg324-1LZ21-403h px� 
\
$Part: %s does not have CEAM library.966*device2
xc7a35ticsg324-1LZ21-9227h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
o
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
2Z8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
N
#Helper process launched with PID %s4824*oasys2
59380Z8-7075h px� 
�
%s*synth2{
yStarting RTL Elaboration : Time (s): cpu = 00:00:01 ; elapsed = 00:00:03 . Memory (MB): peak = 1483.438 ; gain = 449.324
h px� 
�
synthesizing module '%s'%s4497*oasys2
lab52
 2X
TD:/Coding/vivado-projects/NYCU/DLab/lab05/lab5_for_student.srcs/sources_1/new/lab5.v2
38@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2

LCD_module2
 2^
ZD:/Coding/vivado-projects/NYCU/DLab/lab05/lab5_for_student.srcs/sources_1/new/LCD_module.v2
138@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

LCD_module2
 2
02
12^
ZD:/Coding/vivado-projects/NYCU/DLab/lab05/lab5_for_student.srcs/sources_1/new/LCD_module.v2
138@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
lab52
 2
02
12X
TD:/Coding/vivado-projects/NYCU/DLab/lab05/lab5_for_student.srcs/sources_1/new/lab5.v2
38@Z8-6155h px� 
�
�Register %s in module %s has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4878*oasys2
	row_A_reg2
lab52X
TD:/Coding/vivado-projects/NYCU/DLab/lab05/lab5_for_student.srcs/sources_1/new/lab5.v2
268@Z8-7137h px� 
�
�Register %s in module %s has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4878*oasys2
	row_B_reg2
lab52X
TD:/Coding/vivado-projects/NYCU/DLab/lab05/lab5_for_student.srcs/sources_1/new/lab5.v2
278@Z8-7137h px� 
h
+design %s has port %s driven by constant %s3447*oasys2
lab52

usr_led[3]2
0Z8-3917h px� 
h
+design %s has port %s driven by constant %s3447*oasys2
lab52

usr_led[2]2
0Z8-3917h px� 
h
+design %s has port %s driven by constant %s3447*oasys2
lab52

usr_led[1]2
0Z8-3917h px� 
h
+design %s has port %s driven by constant %s3447*oasys2
lab52

usr_led[0]2
0Z8-3917h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2

usr_btn[3]2
lab5Z8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2

usr_btn[2]2
lab5Z8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2

usr_btn[1]2
lab5Z8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2

usr_btn[0]2
lab5Z8-7129h px� 
�
%s*synth2{
yFinished RTL Elaboration : Time (s): cpu = 00:00:01 ; elapsed = 00:00:04 . Memory (MB): peak = 1596.059 ; gain = 561.945
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:01 ; elapsed = 00:00:04 . Memory (MB): peak = 1596.059 ; gain = 561.945
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:01 ; elapsed = 00:00:04 . Memory (MB): peak = 1596.059 ; gain = 561.945
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0092

1596.0592
0.000Z17-268h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
Parsing XDC File [%s]
179*designutils2Z
VD:/Coding/vivado-projects/NYCU/DLab/lab05/lab5_for_student.srcs/constrs_1/new/lab5.xdc8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2Z
VD:/Coding/vivado-projects/NYCU/DLab/lab05/lab5_for_student.srcs/constrs_1/new/lab5.xdc8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2X
VD:/Coding/vivado-projects/NYCU/DLab/lab05/lab5_for_student.srcs/constrs_1/new/lab5.xdc2
.Xil/lab5_propImpl.xdcZ1-236h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1644.4572
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
 Constraint Validation Runtime : 2

00:00:002
00:00:00.0022

1644.4572
0.000Z17-268h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
Finished Constraint Validation : Time (s): cpu = 00:00:02 ; elapsed = 00:00:09 . Memory (MB): peak = 1644.457 ; gain = 610.344
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
D
%s
*synth2,
*Start Loading Part and Timing Information
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Loading part: xc7a35ticsg324-1L
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:02 ; elapsed = 00:00:09 . Memory (MB): peak = 1644.457 ; gain = 610.344
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
%s
*synth20
.Start Applying 'set_property' XDC Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:02 ; elapsed = 00:00:09 . Memory (MB): peak = 1644.457 ; gain = 610.344
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:02 ; elapsed = 00:00:09 . Memory (MB): peak = 1644.457 ; gain = 610.344
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Detailed RTL Component Info : 
h p
x
� 
(
%s
*synth2
+---Adders : 
h p
x
� 
F
%s
*synth2.
,	   2 Input   28 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   27 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    5 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    4 Bit       Adders := 3     
h p
x
� 
+
%s
*synth2
+---Registers : 
h p
x
� 
H
%s
*synth20
.	              128 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	               28 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	               27 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                4 Bit    Registers := 12    
h p
x
� 
H
%s
*synth20
.	                1 Bit    Registers := 11    
h p
x
� 
'
%s
*synth2
+---Muxes : 
h p
x
� 
F
%s
*synth2.
,	   2 Input  128 Bit        Muxes := 8     
h p
x
� 
F
%s
*synth2.
,	   3 Input  126 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	  13 Input    4 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    4 Bit        Muxes := 4     
h p
x
� 
F
%s
*synth2.
,	  13 Input    1 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    1 Bit        Muxes := 6     
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Finished RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
p
%s
*synth2X
VPart Resources:
DSPs: 90 (col length:60)
BRAMs: 100 (col length: RAMB18 60 RAMB36 30)
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
E
%s
*synth2-
+Start Cross Boundary and Area Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px� 
h
+design %s has port %s driven by constant %s3447*oasys2
lab52

usr_led[3]2
0Z8-3917h px� 
h
+design %s has port %s driven by constant %s3447*oasys2
lab52

usr_led[2]2
0Z8-3917h px� 
h
+design %s has port %s driven by constant %s3447*oasys2
lab52

usr_led[1]2
0Z8-3917h px� 
h
+design %s has port %s driven by constant %s3447*oasys2
lab52

usr_led[0]2
0Z8-3917h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2

usr_btn[3]2
lab5Z8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2

usr_btn[2]2
lab5Z8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2

usr_btn[1]2
lab5Z8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2

usr_btn[0]2
lab5Z8-7129h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:02 ; elapsed = 00:00:12 . Memory (MB): peak = 1644.457 ; gain = 610.344
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
@
%s
*synth2(
&Start Applying XDC Timing Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:03 ; elapsed = 00:00:15 . Memory (MB): peak = 1644.457 ; gain = 610.344
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
4
%s
*synth2
Start Timing Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2
}Finished Timing Optimization : Time (s): cpu = 00:00:03 ; elapsed = 00:00:15 . Memory (MB): peak = 1644.457 ; gain = 610.344
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
3
%s
*synth2
Start Technology Mapping
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2~
|Finished Technology Mapping : Time (s): cpu = 00:00:03 ; elapsed = 00:00:15 . Memory (MB): peak = 1644.457 ; gain = 610.344
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
-
%s
*synth2
Start IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
?
%s
*synth2'
%Start Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
B
%s
*synth2*
(Finished Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2x
vFinished IO Insertion : Time (s): cpu = 00:00:03 ; elapsed = 00:00:18 . Memory (MB): peak = 1644.457 ; gain = 610.344
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Start Renaming Generated Instances
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:03 ; elapsed = 00:00:18 . Memory (MB): peak = 1644.457 ; gain = 610.344
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start Rebuilding User Hierarchy
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:03 ; elapsed = 00:00:18 . Memory (MB): peak = 1644.457 ; gain = 610.344
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Renaming Generated Ports
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:03 ; elapsed = 00:00:18 . Memory (MB): peak = 1644.457 ; gain = 610.344
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:03 ; elapsed = 00:00:18 . Memory (MB): peak = 1644.457 ; gain = 610.344
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Start Renaming Generated Nets
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:03 ; elapsed = 00:00:18 . Memory (MB): peak = 1644.457 ; gain = 610.344
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Writing Synthesis Report
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
/
%s
*synth2

Report BlackBoxes: 
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
| |BlackBox name |Instances |
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
/
%s*synth2

Report Cell Usage: 
h px� 
2
%s*synth2
+------+-------+------+
h px� 
2
%s*synth2
|      |Cell   |Count |
h px� 
2
%s*synth2
+------+-------+------+
h px� 
2
%s*synth2
|1     |BUFG   |     1|
h px� 
2
%s*synth2
|2     |CARRY4 |    28|
h px� 
2
%s*synth2
|3     |LUT1   |     7|
h px� 
2
%s*synth2
|4     |LUT2   |    62|
h px� 
2
%s*synth2
|5     |LUT3   |    53|
h px� 
2
%s*synth2
|6     |LUT4   |   100|
h px� 
2
%s*synth2
|7     |LUT5   |    37|
h px� 
2
%s*synth2
|8     |LUT6   |    39|
h px� 
2
%s*synth2
|9     |MUXF7  |    11|
h px� 
2
%s*synth2
|10    |MUXF8  |     3|
h px� 
2
%s*synth2
|11    |FDCE   |   123|
h px� 
2
%s*synth2
|12    |FDPE   |    51|
h px� 
2
%s*synth2
|13    |FDRE   |    72|
h px� 
2
%s*synth2
|14    |FDSE   |     1|
h px� 
2
%s*synth2
|15    |LDC    |    24|
h px� 
2
%s*synth2
|16    |IBUF   |     6|
h px� 
2
%s*synth2
|17    |OBUF   |    11|
h px� 
2
%s*synth2
+------+-------+------+
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:03 ; elapsed = 00:00:18 . Memory (MB): peak = 1644.457 ; gain = 610.344
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
`
%s
*synth2H
FSynthesis finished with 0 errors, 0 critical warnings and 9 warnings.
h p
x
� 
�
%s
*synth2�
Synthesis Optimization Runtime : Time (s): cpu = 00:00:02 ; elapsed = 00:00:17 . Memory (MB): peak = 1644.457 ; gain = 561.945
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:03 ; elapsed = 00:00:18 . Memory (MB): peak = 1644.457 ; gain = 610.344
h p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0042

1644.4572
0.000Z17-268h px� 
T
-Analyzing %s Unisim elements for replacement
17*netlist2
66Z29-17h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
Q
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02
0Z31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1644.4572
0.000Z17-268h px� 
�
!Unisim Transformation Summary:
%s111*project2J
H  A total of 24 instances were transformed.
  LDC => LDCE: 24 instances
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

f9804463Z4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 

G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
262
192
02
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
synth_designZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
synth_design: 2

00:00:032

00:00:212

1644.4572

1009.168Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002
00:00:00.0012

1644.4572
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2R
PD:/Coding/vivado-projects/NYCU/DLab/lab05/lab5_for_student.runs/synth_1/lab5.dcpZ17-1381h px� 
�
Executing command : %s
56330*	planAhead2S
Qreport_utilization -file lab5_utilization_synth.rpt -pb lab5_utilization_synth.pbZ12-24828h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Tue Oct  8 04:37:25 2024Z17-206h px� 


End Record