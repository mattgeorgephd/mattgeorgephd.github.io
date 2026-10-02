---
layout: post
title: Sat. Mar. 19, 2022
subtitle: Honeywell UDA2182 controller setup
tags: tutorials
comments: true
---

## Background
Pictures of a working setup for the [Honeywell UDA2182 dual analyzer](http://cindtechs.ca/unleashd/catalog/analytical/Honeywell-UDA2182/70-82-25-119.pdf) that is controlling to a pH set point after a durafet probe and CO2/solenoids are installed. CO2 is injected into a header tank using a ozone injector.

## Pictures
UDA2182 home screen
![Honeywell UDA2182 home screen](/post_images/20220319/home.jpg)

Relay - connected to solenoid that is normally closed
![UDA2182 relay settings, connected to a normally closed solenoid](/post_images/20220319/relay.jpg)

Input - durafet probe
![UDA2182 input settings for the Durafet pH probe](/post_images/20220319/input.jpg)

Output - 4-20 mA output of pH value to external device
![UDA2182 4-20 mA output settings](/post_images/20220319/output.jpg)

The UDA outputs supply current (0-20 mA, see above). If the another system wants volts than you will need to convert the mA signal. You can do that using a converter board like this [one](https://www.amazon.com/gp/product/B07MYXVDDX/ref=crt_ewc_img_srh_1?ie=UTF8&psc=1&smid=AJPBC0EQEE97B) (2 pack, move spacer on board to set output to 0-5V). The boards themselves will also need to be powered with a 12V DC power supply. This [one](https://www.amazon.com/gp/product/B01LATMSGS/ref=crt_ewc_img_dp_1?ie=UTF8&psc=1&smid=AXEJGN8WLZD9M) should be able to handle two no issues. Once the signal is converted, 20 mA -> 5 V -> pH 14. (edited)

Setup the PID loop (older firmware version)
![UDA2182 PID loop setup, step 1](/post_images/20220319/PID_1.jpg)
![UDA2182 PID loop setup, step 2](/post_images/20220319/PID_2.jpg)
![UDA2182 PID loop setup, step 3](/post_images/20220319/PID_3.jpg)
![UDA2182 PID loop setup, step 4](/post_images/20220319/PID_4.jpg)
![UDA2182 PID loop setup, step 5](/post_images/20220319/PID_5.jpg)
![UDA2182 PID loop setup, step 6](/post_images/20220319/PID_6.jpg)

Navigate to PID control screen
![UDA2182 PID control screen](/post_images/20220319/control_screen.jpg)

The top pH on the top left is the Durafet values, the bottom left is the setpoint, and the bottom right is the activity of the solenoid (% open)

Press enter to open PID control menu
![UDA2182 PID control menu](/post_images/20220319/control_menu.jpg)

Start PID loop

<video style="width:100%;max-width:420px" controls preload="metadata">
  <source src="/post_images/20220319/PID_start.mp4" type="video/mp4">
</video>

Video of the PID loop starting, recorded 18 Mar 2022 (also on [YouTube](https://youtu.be/wVeXxq7iC3E)).
