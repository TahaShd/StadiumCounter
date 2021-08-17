# StadiumCounter
I creates stadium counter system where the attendance of each individual
stand is monitored. If a stand exceeds 90% capacity, an LED should light. Furthermore, the overall
attendance of the stadium should then be displayed (in decimal) on 7-segment displays. This functionality
was achieved using a 3-tier hierarchy system. This resulted in the project being split in two sections: a
stadium counter section (utilizing individual counters) and a display entity.

This consist of 5 Files which are for following purpose
counter_8bit: This files is just normal 8-bit counter
stadium_counter: This file is responsible for controlling overall process of counting in stadium. As well as checking the capacity of each section
segDis: This file is responsible for displaying result on 7-Segment Display
Control: This file just connects stadium_counter and SegDis to work togather
attendance_TB: This file includes testbench to work with counte
