
�
Command: %s
1870*	planAhead2�
�read_checkpoint -auto_incremental -incremental D:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/utils_1/imports/synth_1/lab10.dcpZ12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2b
`D:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/utils_1/imports/synth_1/lab10.dcpZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
b
Command: %s
53*	vivadotcl21
/synth_design -top lab10 -part xc7a35ticsg324-1LZ4-113h px� 
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
28252Z8-7075h px� 
�
%s*synth2{
yStarting RTL Elaboration : Time (s): cpu = 00:00:01 ; elapsed = 00:00:04 . Memory (MB): peak = 1028.164 ; gain = 467.656
h px� 
�
synthesizing module '%s'%s4497*oasys2
lab102
 2T
PD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/sources_1/lab10.v2
238@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2

vga_sync2
 2W
SD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/sources_1/vga_sync.v2
198@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

vga_sync2
 2
02
12W
SD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/sources_1/vga_sync.v2
198@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
clk_divider2
 2Z
VD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/sources_1/clk_divider.v2
218@Z8-6157h px� 
J
%s
*synth22
0	Parameter divider bound to: 2 - type: integer 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
clk_divider2
 2
02
12Z
VD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/sources_1/clk_divider.v2
218@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2

debounce2
 2B
>D:/Coding/GitHub/NYCU_Digital-Circuit-Lab/lab10/src/debounce.v2
218@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

debounce2
 2
02
12B
>D:/Coding/GitHub/NYCU_Digital-Circuit-Lab/lab10/src/debounce.v2
218@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
sram2
 2S
OD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/sources_1/sram.v2
88@Z8-6157h px� 
N
%s
*synth26
4	Parameter DATA_WIDTH bound to: 12 - type: integer 
h p
x
� 
N
%s
*synth26
4	Parameter ADDR_WIDTH bound to: 18 - type: integer 
h p
x
� 
O
%s
*synth27
5	Parameter RAM_SIZE bound to: 93184 - type: integer 
h p
x
� 
O
%s
*synth27
5	Parameter FILE bound to: images.mem - type: string 
h p
x
� 
�
,$readmem data file '%s' is read successfully3426*oasys2

images.mem2S
OD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/sources_1/sram.v2
288@Z8-3876h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
sram2
 2
02
12S
OD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/sources_1/sram.v2
88@Z8-6155h px� 
�
Pwidth (%s) of port connection '%s' does not match port width (%s) of module '%s'689*oasys2
212
addr_12
182
sram2T
PD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/sources_1/lab10.v2
2998@Z8-689h px� 
�
Pwidth (%s) of port connection '%s' does not match port width (%s) of module '%s'689*oasys2
212
addr_22
182
sram2T
PD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/sources_1/lab10.v2
3008@Z8-689h px� 
�
synthesizing module '%s'%s4497*oasys2
sram__parameterized02
 2S
OD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/sources_1/sram.v2
88@Z8-6157h px� 
N
%s
*synth26
4	Parameter DATA_WIDTH bound to: 12 - type: integer 
h p
x
� 
N
%s
*synth26
4	Parameter ADDR_WIDTH bound to: 18 - type: integer 
h p
x
� 
O
%s
*synth27
5	Parameter RAM_SIZE bound to: 29696 - type: integer 
h p
x
� 
P
%s
*synth28
6	Parameter FILE bound to: images2.mem - type: string 
h p
x
� 
�
,$readmem data file '%s' is read successfully3426*oasys2
images2.mem2S
OD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/sources_1/sram.v2
288@Z8-3876h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
sram__parameterized02
 2
02
12S
OD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/sources_1/sram.v2
88@Z8-6155h px� 
�
Pwidth (%s) of port connection '%s' does not match port width (%s) of module '%s'689*oasys2
212
addr_12
182
sram__parameterized02T
PD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/sources_1/lab10.v2
3048@Z8-689h px� 
�
Pwidth (%s) of port connection '%s' does not match port width (%s) of module '%s'689*oasys2
212
addr_22
182
sram__parameterized02T
PD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/sources_1/lab10.v2
3058@Z8-689h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
lab102
 2
02
12T
PD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/sources_1/lab10.v2
238@Z8-6155h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr_1[17]2
sram__parameterized0Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr_1[16]2
sram__parameterized0Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr_1[15]2
sram__parameterized0Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr_2[17]2
sram__parameterized0Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr_2[16]2
sram__parameterized0Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr_2[15]2
sram__parameterized0Z8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr_1[17]2
sramZ8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr_2[17]2
sramZ8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
	usr_sw[3]2
lab10Z8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
	usr_sw[2]2
lab10Z8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
	usr_sw[1]2
lab10Z8-7129h px� 
�
%s*synth2{
yFinished RTL Elaboration : Time (s): cpu = 00:00:02 ; elapsed = 00:00:06 . Memory (MB): peak = 1302.477 ; gain = 741.969
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
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:02 ; elapsed = 00:00:06 . Memory (MB): peak = 1302.477 ; gain = 741.969
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
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:02 ; elapsed = 00:00:06 . Memory (MB): peak = 1302.477 ; gain = 741.969
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

1302.4772
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
179*designutils2V
RD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/constrs_1/lab10.xdc8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2V
RD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/constrs_1/lab10.xdc8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2T
RD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.srcs/constrs_1/lab10.xdc2
.Xil/lab10_propImpl.xdcZ1-236h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

1302.4772
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
00:00:00.0042

1302.4772
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
Finished Constraint Validation : Time (s): cpu = 00:00:04 ; elapsed = 00:00:12 . Memory (MB): peak = 1302.477 ; gain = 741.969
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
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:04 ; elapsed = 00:00:12 . Memory (MB): peak = 1302.477 ; gain = 741.969
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
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:04 ; elapsed = 00:00:12 . Memory (MB): peak = 1302.477 ; gain = 741.969
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
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:04 ; elapsed = 00:00:12 . Memory (MB): peak = 1302.477 ; gain = 741.969
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
,	   3 Input   32 Bit       Adders := 3     
h p
x
� 
F
%s
*synth2.
,	   3 Input   21 Bit       Adders := 3     
h p
x
� 
F
%s
*synth2.
,	   3 Input   12 Bit       Adders := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input   11 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   10 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    9 Bit       Adders := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input    8 Bit       Adders := 4     
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
,	   2 Input    3 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    2 Bit       Adders := 1     
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
.	               21 Bit    Registers := 4     
h p
x
� 
H
%s
*synth20
.	               12 Bit    Registers := 5     
h p
x
� 
H
%s
*synth20
.	               10 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                8 Bit    Registers := 4     
h p
x
� 
H
%s
*synth20
.	                5 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                4 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                3 Bit    Registers := 4     
h p
x
� 
H
%s
*synth20
.	                1 Bit    Registers := 10    
h p
x
� 
&
%s
*synth2
+---RAMs : 
h p
x
� 
Z
%s
*synth2B
@	            1092K Bit	(93184 X 12 bit)          RAMs := 1     
h p
x
� 
Z
%s
*synth2B
@	             348K Bit	(29696 X 12 bit)          RAMs := 1     
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
,	   4 Input   36 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input   21 Bit        Muxes := 4     
h p
x
� 
F
%s
*synth2.
,	   5 Input   21 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   9 Input   21 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   12 Bit        Muxes := 7     
h p
x
� 
F
%s
*synth2.
,	   3 Input    8 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input    7 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    5 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    3 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   3 Input    3 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   4 Input    3 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    2 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    1 Bit        Muxes := 23    
h p
x
� 
F
%s
*synth2.
,	   6 Input    1 Bit        Muxes := 1     
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
z
?The signal %s was recognized as a true dual port RAM template.
3473*oasys2
"lab10/ram_1/RAM_reg"Z8-3971h px� 
z
?The signal %s was recognized as a true dual port RAM template.
3473*oasys2
"lab10/ram_2/RAM_reg"Z8-3971h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
	usr_sw[3]2
lab10Z8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
	usr_sw[2]2
lab10Z8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
	usr_sw[1]2
lab10Z8-7129h px� 
z
?The signal %s was recognized as a true dual port RAM template.
3473*oasys2
"lab10/ram_1/RAM_reg"Z8-3971h px� 
z
?The signal %s was recognized as a true dual port RAM template.
3473*oasys2
"lab10/ram_2/RAM_reg"Z8-3971h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:05 ; elapsed = 00:00:16 . Memory (MB): peak = 1331.902 ; gain = 771.395
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
�---------------------------------------------------------------------------------
Start ROM, RAM, DSP, Shift Register and Retiming Reporting
h px� 
l
%s*synth2T
R---------------------------------------------------------------------------------
h px� 
R
%s*synth2:
8
Block RAM: Preliminary Mapping Report (see note below)
h px� 
�
%s*synth2�
�+------------+---------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+
h px� 
�
%s*synth2�
�|Module Name | RTL Object    | PORT A (Depth x Width) | W | R | PORT B (Depth x Width) | W | R | Ports driving FF | RAMB18 | RAMB36 | 
h px� 
�
%s*synth2�
�+------------+---------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+
h px� 
�
%s*synth2�
�|lab10       | ram_1/RAM_reg | 91 K x 12(WRITE_FIRST) | W | R | 91 K x 12(WRITE_FIRST) | W | R | Port A and B     | 0      | 36     | 
h px� 
�
%s*synth2�
�|lab10       | ram_2/RAM_reg | 29 K x 12(WRITE_FIRST) | W | R | 29 K x 12(WRITE_FIRST) | W | R | Port A and B     | 0      | 12     | 
h px� 
�
%s*synth2�
�+------------+---------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+

h px� 
�
%s*synth2�
�Note: The table above is a preliminary report that shows the Block RAMs at the current stage of the synthesis flow. Some Block RAMs may be reimplemented as non Block RAM primitives later in the synthesis flow. Multiple instantiated Block RAMs are reported only once. 
h px� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Finished ROM, RAM, DSP, Shift Register and Retiming Reporting
h px� 
l
%s*synth2T
R---------------------------------------------------------------------------------
h px� 
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
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:06 ; elapsed = 00:00:20 . Memory (MB): peak = 1425.082 ; gain = 864.574
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
}Finished Timing Optimization : Time (s): cpu = 00:00:07 ; elapsed = 00:00:21 . Memory (MB): peak = 1495.406 ; gain = 934.898
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s
*synth2�
�---------------------------------------------------------------------------------
Start ROM, RAM, DSP, Shift Register and Retiming Reporting
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
!
Block RAM: Final Mapping Report
h p
x
� 
�
%s
*synth2�
�+------------+---------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+
h p
x
� 
�
%s
*synth2�
�|Module Name | RTL Object    | PORT A (Depth x Width) | W | R | PORT B (Depth x Width) | W | R | Ports driving FF | RAMB18 | RAMB36 | 
h p
x
� 
�
%s
*synth2�
�+------------+---------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+
h p
x
� 
�
%s
*synth2�
�|lab10       | ram_1/RAM_reg | 91 K x 12(WRITE_FIRST) | W | R | 91 K x 12(WRITE_FIRST) | W | R | Port A and B     | 0      | 36     | 
h p
x
� 
�
%s
*synth2�
�|lab10       | ram_2/RAM_reg | 29 K x 12(WRITE_FIRST) | W | R | 29 K x 12(WRITE_FIRST) | W | R | Port A and B     | 0      | 12     | 
h p
x
� 
�
%s
*synth2�
�+------------+---------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+

h p
x
� 
�
%s
*synth2�
�---------------------------------------------------------------------------------
Finished ROM, RAM, DSP, Shift Register and Retiming Reporting
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
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_12
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_12
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_22
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_22
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_32
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_32
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_42
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_42
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_52
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_52
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_62
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_62
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_72
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_72
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_82
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_82
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_92
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_92
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_102
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_102
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_112
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_112
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_0__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_0__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_1__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_1__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_2__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_2__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_3__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_3__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_4__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_4__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_5__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_5__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_6__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_6__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_7__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_7__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_8__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_8__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_9__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_9__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_10__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_10__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_11__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_1/RAM_reg_1_11__02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_02
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_12
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_12
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_22
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_22
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_32
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_32
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_42
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_42
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_52
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_52
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_62
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_62
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_72
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_72
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_82
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_82
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_92
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_92
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_102
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_102
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_112
BlockZ8-7052h px� 
�
�The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2
ram_2/RAM_reg_0_112
BlockZ8-7052h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2~
|Finished Technology Mapping : Time (s): cpu = 00:00:07 ; elapsed = 00:00:22 . Memory (MB): peak = 1504.461 ; gain = 943.953
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
%s*synth2y
wFinished IO Insertion : Time (s): cpu = 00:00:07 ; elapsed = 00:00:24 . Memory (MB): peak = 1637.145 ; gain = 1076.637
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
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:07 ; elapsed = 00:00:24 . Memory (MB): peak = 1637.145 ; gain = 1076.637
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
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:07 ; elapsed = 00:00:24 . Memory (MB): peak = 1637.145 ; gain = 1076.637
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
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:07 ; elapsed = 00:00:24 . Memory (MB): peak = 1637.145 ; gain = 1076.637
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
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:07 ; elapsed = 00:00:24 . Memory (MB): peak = 1639.121 ; gain = 1078.613
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
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:07 ; elapsed = 00:00:24 . Memory (MB): peak = 1639.121 ; gain = 1078.613
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
4
%s*synth2
+------+---------+------+
h px� 
4
%s*synth2
|      |Cell     |Count |
h px� 
4
%s*synth2
+------+---------+------+
h px� 
4
%s*synth2
|1     |BUFG     |     1|
h px� 
4
%s*synth2
|2     |CARRY4   |   120|
h px� 
4
%s*synth2
|3     |LUT1     |    33|
h px� 
4
%s*synth2
|4     |LUT2     |   211|
h px� 
4
%s*synth2
|5     |LUT3     |   178|
h px� 
4
%s*synth2
|6     |LUT4     |   238|
h px� 
4
%s*synth2
|7     |LUT5     |    51|
h px� 
4
%s*synth2
|8     |LUT6     |   152|
h px� 
4
%s*synth2
|9     |MUXF7    |     3|
h px� 
4
%s*synth2
|10    |RAMB36E1 |    48|
h px� 
4
%s*synth2
|58    |FDCE     |    27|
h px� 
4
%s*synth2
|59    |FDPE     |    10|
h px� 
4
%s*synth2
|60    |FDRE     |   399|
h px� 
4
%s*synth2
|61    |IBUF     |     7|
h px� 
4
%s*synth2
|62    |OBUF     |    18|
h px� 
4
%s*synth2
+------+---------+------+
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
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:07 ; elapsed = 00:00:24 . Memory (MB): peak = 1639.121 ; gain = 1078.613
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
FSynthesis finished with 0 errors, 0 critical warnings and 4 warnings.
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Runtime : Time (s): cpu = 00:00:04 ; elapsed = 00:00:23 . Memory (MB): peak = 1639.121 ; gain = 1078.613
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:07 ; elapsed = 00:00:24 . Memory (MB): peak = 1639.121 ; gain = 1078.613
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
00:00:00.0142

1648.2852
0.000Z17-268h px� 
U
-Analyzing %s Unisim elements for replacement
17*netlist2
171Z29-17h px� 
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

1651.9342
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

1476493bZ4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1112
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

00:00:082

00:00:282

1651.9342

1281.875Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002
00:00:00.0032

1651.9342
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2R
PD:/Coding/vivado-projects/NYCU/DLab/lab10_new/lab10/lab10.runs/synth_1/lab10.dcpZ17-1381h px� 
�
Executing command : %s
56330*	planAhead2U
Sreport_utilization -file lab10_utilization_synth.rpt -pb lab10_utilization_synth.pbZ12-24828h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Wed Nov 20 03:39:46 2024Z17-206h px� 


End Record