In the last years I have been using R fairly extensively, both for analysis and figure making, mostly with ggplot since its the most common/powerful.
Recently I needed to add a little gap at the end part of the axis to indicate that the axis does not start from 0.
Somewhat surprisingly, this turned out to be quite hard and no ready implementation is available.
Here I put together two functions to do that (for the x and y axis). 
The strategy is:
-delete the existing axis
-make a fake zero point
-paint some geom_segments at the right spots as a new axis, as well as a gap
-make sure to turn off clipping outside the axes, so that the gaps will be visible.
This results in the axis something looking like this
![alt text](https://github.com/npriov/Axes_gaps_ggplot/blob/master/gaps_ax.png?raw=true)

