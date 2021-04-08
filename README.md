# OFDM Implementation

*Mark Goldwater and Anusha Datar*

Olin College SP21 Principles of Wireless Communications Lab 3.
# Summary
This repository contains code and documentation associated with
decoding signals sent and received in an OFDM system.

The main function for the first part of the lab, which does not
require timing syncrhonization, is [simulate_with_synchronized_clocks.m](https://github.com/anushadatar/ofdm-implementation/blob/main/simulate_with_synchronized_clocks.m). 
The [release](https://github.com/anushadatar/ofdm-implementation/releases/tag/v.3.a) for this section of the lab provides a stable version
of this software.

The main function for the second part of the lab, which does
require timing syncrhonization, is [simulate_without_synchronized_clocks.m](https://github.com/anushadatar/ofdm-implementation/blob/main/simulate_without_synchronized_clocks.m). 
The [release](https://github.com/anushadatar/ofdm-implementation/releases/tag/v.3.b) for 
this section of the lab provides a stable version of this software. 

The third part of the lab requires the use of Universal Serial Radio
Peripheral (USRP) BS210 radios to send and receive OFDM signals in the
physical world. The main function for packaging data for transmission
using hardware was [package_data.m](https://github.com/anushadatar/ofdm-implementation/blob/main/package_data.m).
The main function for processing data received using hardware is 
[process_received_data_hardware.m](https://github.com/anushadatar/ofdm-implementation/blob/main/process_received_data_hardware.m). 
The [release](https://github.com/anushadatar/ofdm-implementation/releases/tag/v.3.c) for 
this section of the lab provides a stable version of this software. 

Our [final report](https://github.com/anushadatar/ofdm-implementation/blob/main/docs/report.pdf) 
includes more details about our implementation 
and additional theoretical background.
