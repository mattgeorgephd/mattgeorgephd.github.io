---
layout: post
title: Thu. Dec. 10, 2020
subtitle: Pt. Whitney Tank Build - update 3
project: NOPP-gigas-ploidy-temp
tags: NOPP-gigas-ploidy-temp
comments: true
---

## Heating calculations

After the success of the tank prototype, I have completed the build of three additional tanks.

The next challenge is to heat the water in the tanks to 40 C.

Before ordering the heaters, I had to determine how many watts they needed to generate to heat 10 C seawater to 40 C at a sufficient rate to supply to tanks.

To be safe, I assumed the following conservative parameters (with converted imperial units for BTU calc):

Whole tank flow rate: 8 L/min or 1082 lbs/h
Per silo flow rate: 225 ml/min
Silo turn-over rate: 3.5 volumes per hour
Temperature increase: 30 C or 54 F
Specific heat of seawater: 0.932

Using the following heater transfer equation:

Q = W x (T2-T1) x Cp

where,

Q = Heat (BTU/h)
W = Flow rate (lbs/h)
T2-T1 = Temperature change (F)
Cp = specific heat of seawater

I was able to deterime that I needed,

Q = 54,475 BTU/h, or
Q = 15.8 kWatts

This confirmed that the two aqualogic 15kW heaters (220v, 37 Amps each) that we have are capable of heating the water needed, with plenty of room to spare (as my heat calc was a best case scenario that didn't take into account the heat loss in the system and that I have to pump water downstairs)

In comparison,

To get this same BTU generation at this flow rate you would need x10 [500 Watt titanium rod aquarium heaters (120V, 5 Amps each)](https://www.amazon.com/gp/product/B002TMTGGQ/ref=ppx_yo_dt_b_asin_title_o01_s00?ie=UTF8&psc=1).

## Tank build progress

The experimental tanks at Pt. Whitney are located downstairs, while the water heaters are located upstairs in the attic.

After I installed the heaters, I connected them to a reservoir tank upstairs.

The setup is a follows:

Incoming seawater (circa 10 C) fills a 200 L header tank upstairs (see below) that circulates through two [Aqualogic](https://aqualogicinc.com/) Optima Compact Plus 15 kW inline heat pumps that are plumbed in series and fed with a 2400 GPH pump. Two of the tanks downstairs are then fed off a circulation loop that runs downstairs and back and driven by a 2400 GPH pump.

Here is a picture of the heated header tank upstairs (without its lid):

![Heated header tank upstairs, lid removed](/post_images/121020/tank_upstairs.jpg)

A picture of the tanks downstairs:

![Experimental tanks downstairs, covered](/post_images/121020/all_tanks_covered.jpg)

Side view of the manifold:

![Side view of the silo manifold](/post_images/121020/silos_side_view.jpg)

Pictures of juvenile oysters in silos:

![Juvenile oysters inside the silos](/post_images/121020/silos_with_oyster.jpg)

To test the system, I have begun heating water to 40 C upstairs and fill the tanks downstairs. I will monitor the temp of tanks with and without rod heaters downstairs and report back soon.
